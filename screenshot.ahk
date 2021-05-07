;############# RegionCapture Code is below ########################################################
/* CaptureScreen(aRect, bCursor, sFileTo)
1) If the optional parameter bCursor is True, captures the cursor too.
2) If the optional parameter sFileTo is 0, set the image to Clipboard.
   If it is omitted or "", saves to screen.bmp in the script folder,
   otherwise to sFileTo which can be BMP/JPG/PNG/GIF/TIF.
3) If aRect is 0/1/2, captures the screen/active window/client area of active window.
4) aRect can be comma delimited sequence of coordinates, e.g., "Left, Top, Right, Bottom" or "Left, Top, Right, Bottom, Width_Zoomed, Height_Zoomed".
   In this case, only that portion of the rectangle will be captured. Additionally, in the latter case, zoomed to the new width/height, Width_Zoomed/Height_Zoomed.
Build date is 20-12-2007
Example:
CaptureScreen(0)
CaptureScreen(1)
CaptureScreen(2)
CaptureScreen("100, 100, 200, 200")
CaptureScreen("100, 100, 200, 200, 400, 400")   ; Zoomed
*/

/* Convert(sFileFr, sFileTo)
Convert("C:\image.bmp", "C:\image.jpg")
Convert(0, "C:\clip.png")   ; Save the bitmap in the clipboard to sFileTo if sFileFr is "" or 0.
*/
CaptureScreen(aRect = 0, bCursor = False, sFile = "")
{
	If	!aRect
	{
		SysGet, Mon, Monitor, 1
		nL := MonLeft
		nT := MonTop
		nW := MonRight - MonLeft
		nH := MonBottom - MonTop
	}
	Else If	aRect = 1
		WinGetPos, nL, nT, nW, nH, A
	Else If	aRect = 2
	{
		WinGet, hWnd, ID, A
		VarSetCapacity(rt, 16, 0)
		DllCall("GetClientRect" , "Uint", hWnd, "Uint", &rt)
		DllCall("ClientToScreen", "Uint", hWnd, "Uint", &rt)
		nL := NumGet(rt, 0, "int")
		nT := NumGet(rt, 4, "int")
		nW := NumGet(rt, 8)
		nH := NumGet(rt,12)
	}
	Else
	{
		StringSplit, rt, aRect, `,, %A_Space%%A_Tab%
		nL := rt1
		nT := rt2
		nW := rt3 - rt1
		nH := rt4 - rt2
		znW := rt5
		znH := rt6
	}

	hDC := DllCall("GetDC", "Uint", 0)
	mDC := DllCall("CreateCompatibleDC", "Uint", hDC)
	hBM := DllCall("CreateCompatibleBitmap", "Uint", hDC, "int", nW, "int", nH)
	oBM := DllCall("SelectObject", "Uint", mDC, "Uint", hBM)
	DllCall("BitBlt", "Uint", mDC, "int", 0, "int", 0, "int", nW, "int", nH, "Uint", hDC, "int", nL, "int", nT, "Uint", 0x40000000 | 0x00CC0020)
	If	bCursor
		CaptureCursor(mDC, nL, nT)
	DllCall("SelectObject", "Uint", mDC, "Uint", oBM)
	DllCall("DeleteDC", "Uint", mDC)
	If	znW && znH
		hBM := Zoomer(hDC, hBM, nW, nH, znW, znH)
	If	sFile = 0
		SetClipboardData(hBM)
	Else	Convert(hBM, sFile)
	DllCall("DeleteObject", "Uint", hBM)
	DllCall("ReleaseDC", "Uint", 0, "Uint", hDC)
}

CaptureCursor(hDC, nL, nT)
{
	VarSetCapacity(mi, 20, 0)
	mi := Chr(20)
	DllCall("GetCursorInfo", "Uint", &mi)
	bShow   := NumGet(mi, 4)
	hCursor := NumGet(mi, 8)
	xCursor := NumGet(mi,12)
	yCursor := NumGet(mi,16)

	VarSetCapacity(ni, 20, 0)
	DllCall("GetIconInfo", "Uint", hCursor, "Uint", &ni)
	xHotspot := NumGet(ni, 4)
	yHotspot := NumGet(ni, 8)
	hBMMask  := NumGet(ni,12)
	hBMColor := NumGet(ni,16)

	If	bShow
		DllCall("DrawIcon", "Uint", hDC, "int", xCursor - xHotspot - nL, "int", yCursor - yHotspot - nT, "Uint", hCursor)
	If	hBMMask
		DllCall("DeleteObject", "Uint", hBMMask)
	If	hBMColor
		DllCall("DeleteObject", "Uint", hBMColor)
}

Zoomer(hDC, hBM, nW, nH, znW, znH)
{
	mDC1 := DllCall("CreateCompatibleDC", "Uint", hDC)
	mDC2 := DllCall("CreateCompatibleDC", "Uint", hDC)
	zhBM := DllCall("CreateCompatibleBitmap", "Uint", hDC, "int", znW, "int", znH)
	oBM1 := DllCall("SelectObject", "Uint", mDC1, "Uint",  hBM)
	oBM2 := DllCall("SelectObject", "Uint", mDC2, "Uint", zhBM)
	DllCall("SetStretchBltMode", "Uint", mDC2, "int", 4)
	DllCall("StretchBlt", "Uint", mDC2, "int", 0, "int", 0, "int", znW, "int", znH, "Uint", mDC1, "int", 0, "int", 0, "int", nW, "int", nH, "Uint", 0x00CC0020)
	DllCall("SelectObject", "Uint", mDC1, "Uint", oBM1)
	DllCall("SelectObject", "Uint", mDC2, "Uint", oBM2)
	DllCall("DeleteDC", "Uint", mDC1)
	DllCall("DeleteDC", "Uint", mDC2)
	DllCall("DeleteObject", "Uint", hBM)
	Return	zhBM
}

Convert(sFileFr = "", sFileTo = "")
{
	If	!sFileTo
		 sFileTo := %imagesavename%
	SplitPath, sFileTo, , , sExtTo
	hGdiPlus := DllCall("LoadLibrary", "str", "gdiplus.dll")
	VarSetCapacity(si, 16, 0), si := Chr(1)
	DllCall("gdiplus\GdiplusStartup", "UintP", pToken, "Uint", &si, "Uint", 0)
	DllCall("gdiplus\GdipGetImageEncodersSize", "UintP", nCount, "UintP", nSize)
	VarSetCapacity(ci, nSize)
	DllCall("gdiplus\GdipGetImageEncoders", "Uint", nCount, "Uint", nSize, "Uint", &ci)

	Loop,	%nCount%
	{
		If	!InStr(Ansi4Unicode(NumGet(ci, 76 * (A_Index - 1) + 44)), "." . sExtTo)
			Continue
		pCodec := &ci + 76 * (A_Index - 1)
			Break
	}

	If	!sFileFr
	{
		DllCall("OpenClipboard", "Uint", 0)
		If	 DllCall("IsClipboardFormatAvailable", "Uint", 2) && (hBM:=DllCall("GetClipboardData", "Uint", 2))
		DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "Uint", hBM, "Uint", 0, "UintP", pImage)
		DllCall("CloseClipboard")
	}
	Else If	sFileFr Is Integer
		DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "Uint", sFileFr, "Uint", 0, "UintP", pImage)
	Else	DllCall("gdiplus\GdipLoadImageFromFile", "Uint", Unicode4Ansi(wFileFr,sFileFr), "UintP", pImage)

	If	pImage
		DllCall("gdiplus\GdipSaveImageToFile", "Uint", pImage, "Uint", Unicode4Ansi(wFileTo,sFileTo), "Uint", pCodec, "Uint", 0), DllCall("gdiplus\GdipDisposeImage", "Uint", pImage)

	DllCall("gdiplus\GdiplusShutdown" , "Uint", pToken)
	DllCall("FreeLibrary", "Uint", hGdiPlus)
}

SetClipboardData(hMem, nFormat = 2)
{
	DetectHiddenWindows, On
	Process, Exist
	WinGet, hAHK, ID, ahk_pid %ErrorLevel%
	DllCall("OpenClipboard", "Uint", hAHK)
	DllCall("EmptyClipboard")
	DllCall("SetClipboardData", "Uint", nFormat, "Uint", hMem)
	DllCall("CloseClipboard")
}

Unicode4Ansi(ByRef wString, sString)
{
	nSize := DllCall("MultiByteToWideChar", "Uint", 0, "Uint", 0, "Uint", &sString, "int", -1, "Uint", 0, "int", 0)
	VarSetCapacity(wString, nSize * 2)
	DllCall("MultiByteToWideChar", "Uint", 0, "Uint", 0, "Uint", &sString, "int", -1, "Uint", &wString, "int", nSize)
	Return	&wString
}

Ansi4Unicode(pString)
{
	nSize := DllCall("WideCharToMultiByte", "Uint", 0, "Uint", 0, "Uint", pString, "int", -1, "Uint", 0, "int",  0, "Uint", 0, "Uint", 0)
	VarSetCapacity(sString, nSize)
	DllCall("WideCharToMultiByte", "Uint", 0, "Uint", 0, "Uint", pString, "int", -1, "str", sString, "int", nSize, "Uint", 0, "Uint", 0)
	Return	sString
}


	#space::
	imagesavename=C:\test.bmp
	; call the screencapture function
	CaptureScreen(0,false,imagesavename)
Return
