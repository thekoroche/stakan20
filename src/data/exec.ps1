<#
    WARNING!
    ---------------------------------------------------------------------------
    This program is intended solely for demonstration and educational purposes. 
    Running this code can be risky and may harm your system. It is strongly    
    recommended to execute it in a virtual machine or a controlled environment.
    ---------------------------------------------------------------------------

    DISCLAIMER: The author and developer of this code assume no responsibility for
    any damage or issues that may arise from using this software. By running, 
    modifying, or sharing this code, you agree to do so at your own risk.
    
    ---------------------------------------------------------------------------

    NOTE: This code contains functions that can be used in your projects. 
    Modifying it for malicious purposes, including creating virus-like programs, 
    is illegal and unethical. 

    ---------------------------------------------------------------------------

    This program may cause unintended disruptions to system operations and can 
    risk data corruption. It is important to understand that this program is 
    for educational purposes and should be used responsibly and ethically. 

    If you choose to distribute this program, you must provide the open-source 
    code to all who download it.

    ---------------------------------------------------------------------------

    ADDITIONAL NOTE: Users must be fully aware of the potential dangers involved 
    when running this code in any environment.

    ===========================================================================

    By proceeding, you acknowledge that you have read and understood this 
    disclaimer and agree to use the code responsibly in a controlled 
    educational environment.
#>

# Load the necessary .NET assemblies
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Show warnings
# WARNING: Removing or modifing these warnings to prevent users from understanding the actions of this program, it can lead to serious issues or conflicts.
function Show-Message {
    param (
        [string]$Title,
        [string]$Message
    )

    Add-Type -AssemblyName PresentationFramework

    [System.Windows.MessageBox]::Show($Message, $Title, [System.Windows.MessageBoxButton]::YesNo, [System.Windows.MessageBoxImage]::Warning)
}

# First warning
$warningConfirm1 = Show-Message -Title "Warning!" -Message @"
WARNING!

This program is intended solely for educational and demonstration purposes. The author assumes no responsibility for any consequences, including system damage or data loss.

It is strongly recommended to run this program only in a controlled environment, such as a virtual machine.

Click "No" to abort.
"@

if ($warningConfirm1 -eq [System.Windows.MessageBoxResult]::Yes) {
    # Second warning
    $warningConfirm2 = Show-Message -Title "Final Confirmation" -Message @"
FINAL WARNING!

You are about to run this program.

This program is intended solely for educational and demonstration purposes. The author assumes no responsibility for any consequences, including system damage or data loss.

It is strongly recommended to run this program only in a controlled environment, such as a virtual machine.

Click "No" to abort.

Proceed at your own risk.
"@

    if ($warningConfirm2 -eq [System.Windows.MessageBoxResult]::Yes) {
        # Continue executing
    } else {
        exit 1
    }
} else {
    exit 1
}

# Define the Gdi32 class 
Add-Type @"
    using System;
    using System.Runtime.InteropServices;

    public class Gdi32 {
        [DllImport("kernel32.dll", SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool FreeLibrary(IntPtr hModule);

        [DllImport("user32.dll", SetLastError = true)]
        public static extern IntPtr GetDC(IntPtr hwnd);
		
		[DllImport("gdi32.dll", SetLastError = true)]
		public static extern bool DeleteDC(IntPtr hdc);

        [DllImport("user32.dll", SetLastError = true)]
        public static extern int ReleaseDC(IntPtr hdc);

        [DllImport("gdi32.dll", SetLastError = true)]
        public static extern uint SetPixel(IntPtr hdc, int X, int Y, uint color);

        [DllImport("gdi32.dll", SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool Rectangle(IntPtr hdc, int left, int top, int right, int bottom);

        [DllImport("gdi32.dll", SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool Ellipse(IntPtr hdc, int left, int top, int right, int bottom);

        [DllImport("gdi32.dll", SetLastError = true)]
        public static extern IntPtr CreatePen(int fnPenStyle, int nWidth, uint crColor);

        [DllImport("gdi32.dll", SetLastError = true)]
        public static extern IntPtr SelectObject(IntPtr hdc, IntPtr hObject);

        [DllImport("gdi32.dll", SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool DeleteObject(IntPtr hObject);

        [DllImport("gdi32.dll", SetLastError = true)]
        public static extern int TextOut(IntPtr hdc, int x, int y, string lpString, int c);

        [DllImport("gdi32.dll", SetLastError = true)]
        public static extern uint SetTextColor(IntPtr hdc, uint color);

        [DllImport("gdi32.dll", SetLastError = true)]
        public static extern uint SetBkColor(IntPtr hdc, uint color);

        [DllImport("gdi32.dll", SetLastError = true)]
        public static extern uint SetBkMode(IntPtr hdc, int mode);

        [DllImport("gdi32.dll", SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool BitBlt(IntPtr hdcDest, int nXDest, int nYDest, int nWidth, int nHeight, IntPtr hdcSrc, int nXSrc, int nySrc, uint dwRop);

        [DllImport("gdi32.dll", SetLastError = true)]
        public static extern IntPtr CreateCompatibleDC(IntPtr hdc);

        [DllImport("gdi32.dll", SetLastError = true)]
        public static extern IntPtr CreateFont(int nHeight, int nWidth, int nEscapement, int nOrientation, int fnWeight, uint fdwItalic, uint fdwUnderline, uint fdwStrikeOut, uint fdwCharSet, uint fdwOutputPrecision, uint fdwClipPrecision, uint fdwQuality, uint fdwPitchAndFamily, string lpszFace);

        [DllImport("gdi32.dll", SetLastError = true)]
        public static extern bool MoveToEx(IntPtr hdc, int X, int Y, IntPtr lpPoint);

        [DllImport("gdi32.dll", SetLastError = true)]
        public static extern bool LineTo(IntPtr hdc, int X, int Y);

        [DllImport("gdi32.dll", SetLastError = true)]
        public static extern IntPtr CreateSolidBrush(uint crColor);

        [DllImport("gdi32.dll", SetLastError = true)]
        public static extern bool PatBlt(IntPtr hdc, int x, int y, int cx, int cy, uint dwRop);
		
		[DllImport("gdi32.dll", SetLastError = true)]
		public static extern bool StretchBlt(IntPtr hdcDest, int nXOriginDest, int nYOriginDest, int nWidthDest, int nHeightDest,
                                         IntPtr hdcSrc, int nXOriginSrc, int nYOriginSrc, int nWidthSrc, int nHeightSrc, int dwRop);


        [DllImport("msimg32.dll", SetLastError = true)]
		[return: MarshalAs(UnmanagedType.Bool)]
		public static extern bool TransparentBlt(IntPtr hdcDest, int nXDest, int nYDest, int nWidthDest, int nHeightDest, IntPtr hdcSrc, int nXSrc, int nYSrc, int nWidthSrc, int nHeightSrc, uint crTransparent);
		
        [DllImport("gdi32.dll", SetLastError = true)]
        public static extern IntPtr CreateCompatibleBitmap(IntPtr hdc, int nWidth, int nHeight);
		
		public static uint RGB(byte red, byte green, byte blue) {
            return (uint)((red << 16) | (green << 8) | blue);
        }

        public const uint SRCCOPY = 0x00CC0020;
        public const uint SRCPAINT = 0x00EE0086;
        public const uint SRCAND = 0x008800C6;
        public const uint SRCINVERT = 0x00660046;
        public const uint SRCERASE = 0x00440328;
        public const uint NOTSRCCOPY = 0x00330008;
        public const uint NOTSRCERASE = 0x001100A6;
        public const uint MERGECOPY = 0x00C000CA;
        public const uint PATCOPY = 0x00F00021;
        public const uint PATPAINT = 0x00FB0A09;
        public const uint PATINVERT = 0x005A0049;
        public const uint DSTINVERT = 0x00550009;
        public const uint BLACKNESS = 0x00000042;
        public const uint WHITENESS = 0x00FF0062;

        public const int WHITE_BRUSH = 0;
        public const int LTGRAY_BRUSH = 1; 
        public const int GRAY_BRUSH = 2;
        public const int DKGRAY_BRUSH = 3;
        public const int BLACK_BRUSH = 4;
        public const int NULL_BRUSH = 5;
        public const int HOLLOW_BRUSH = NULL_BRUSH;
        public const int WHITE_PEN = 6;
        public const int BLACK_PEN = 7;
        public const int NULL_PEN = 8;
        public const int OEM_FIXED_FONT = 10;
        public const int ANSI_FIXED_FONT = 11;
        public const int ANSI_VAR_FONT = 12;
        public const int SYSTEM_FONT = 13;
        public const int DEVICE_DEFAULT_FONT = 14;
        public const int DEFAULT_PALETTE = 15;
        public const int SYSTEM_FIXED_FONT = 16;
        public const int DEFAULT_GUI_FONT = 17;
        public const int DC_BRUSH = 18;
        public const int DC_PEN = 19;
        
        public const int TRANSPARENT = 1;
        public const int OPAQUE = 2;
    }
"@

# Define the User32 class
Add-Type @"
using System;
using System.Runtime.InteropServices;

public class User32 {
    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SetForegroundWindow(IntPtr hWnd);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool PostMessage(IntPtr hWnd, uint Msg, IntPtr wParam, IntPtr lParam);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool GetWindowRect(IntPtr hWnd, out RECT lpRect);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool GetClientRect(IntPtr hWnd, out RECT lpRect);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool GetWindowText(IntPtr hWnd, System.Text.StringBuilder lpString, int nMaxCount);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SetWindowText(IntPtr hWnd, string lpString);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool GetWindowPlacement(IntPtr hWnd, out WINDOWPLACEMENT lpWindowPlacement);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SetWindowPlacement(IntPtr hWnd, ref WINDOWPLACEMENT lpWindowPlacement);

    [DllImport("user32.dll")]
    public static extern bool GetCursorPos(out POINT lpPoint);

    [DllImport("user32.dll")]
    public static extern bool SetCursorPos(int X, int Y);
	
	[DllImport("user32.dll", SetLastError = true)]
    public static extern bool InvalidateRect(IntPtr hWnd, IntPtr lpRect, bool bErase);
	
	[DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
	
	public const int SPI_GETDESKWALLPAPER = 0x0073;

    public static string GetDesktopWallpaper()
    {
        // Buffer for wallpaper path
        string wallpaperPath = new string('\0', 260);
        SystemParametersInfo(SPI_GETDESKWALLPAPER, wallpaperPath.Length, wallpaperPath, 0);
        
        // Return the trimmed wallpaper path
        return wallpaperPath.Trim('\0');
    }


    [StructLayout(LayoutKind.Sequential)]
    public struct RECT {
        public int left;
        public int top;
        public int right;
        public int bottom;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct WINDOWPLACEMENT {
        public int length;
        public int flags;
        public int showCmd;
        public POINT ptMinPosition;
        public POINT ptMaxPosition;
        public RECT rcNormalPosition;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct POINT {
        public int X;
        public int Y;
    }

    public const int SW_SHOW = 5;
    public const int SW_HIDE = 0;
    public const uint WM_CLOSE = 0x0010;
    public const uint WM_QUIT = 0x0012;
}
"@

# Invoke-BSOD removed

# Initializing resources
$programName = "stakanchik" # Need to be changed in "launcher.bat"
$currentPath = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), $programName)

$musicName = "music.wav" 												# Music 
$musicPath = Join-Path -Path $currentPath -ChildPath $musicName

# Define your resources here
$cursorName = "cur.bmp"													
$cursorPath = Join-Path -Path $currentPath -ChildPath $cursorName

$backgroundName = "background.jpeg"													
$backgroundPath = Join-Path -Path $currentPath -ChildPath $backgroundName

# Function to play audio file
function Play-Audio {
    param (
        [string]$FilePath
    )

    $soundPlayer = New-Object System.Media.SoundPlayer
    $soundPlayer.SoundLocation = $FilePath
    $soundPlayer.Load()
    $soundPlayer.Play()
}

#get size of screen
$currentScreen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds;
$width = $currentScreen.width;
$height = $currentScreen.height;

<#
	BASIC METHODS
	---------------------
	Defined by defualt often methods, with user32, gdi32 classes.
#>

function Get-DC {
    return [Gdi32]::GetDC([IntPtr]::Zero)
}

function Release-DC {
    param (
        [IntPtr]$HDC
    )
    [void][Gdi32]::ReleaseDC($HDC)
}

$hdc = Get-DC

function Reset-HDC {
	Release-DC -HDC $hdc
	$hdc = Get-DC
}

function Screen-InvertAll {
	Screen-ROPOperation -ROP $ROP_DSTINVERT
}

function Screen-SRCInvert {
	Screen-ROPOperation -ROP $ROP_SRCINVERT
}

function Screen-SRCErase {
	Screen-ROPOperation -ROP $ROP_SRCERASE
}

function Screen-SRCPaint {
	Screen-ROPOperation -ROP $ROP_SRCPAINT
}

function Screen-ROPOperation {
	param (
		[int]$ROP
	)
	
	$ropCode = Get-ROPFromIndex $ROP
	
	$hdcMem = [Gdi32]::CreateCompatibleDC($hdc)
    $hbm = [Gdi32]::CreateCompatibleBitmap($hdc, $width, $height)
    $hOldBmp = [Gdi32]::SelectObject($hdcMem, $hbm)

    [void][Gdi32]::BitBlt($hdcMem, 0, 0, $width, $height, $hdc, 0, 0, [Gdi32]::SRCCOPY)
    [void][Gdi32]::BitBlt($hdc, 0, 0, $width, $height, $hdcMem, 0, 0, $ropCode)

    [void][Gdi32]::SelectObject($hdcMem, $hOldBmp)
    [void][Gdi32]::DeleteObject($hbm)
    [void][Gdi32]::DeleteDC($hdcMem)
}

function Screen-StretchInside {
    param (
        [int]$Power,
		[int]$ROP = 0
    )
	
	$ropCode = Get-ROPFromIndex $ROP

    $srcWidth = $width
    $srcHeight = $height
    $destWidth = $width - $Power
    $destHeight = $height - $Power

    $hdcMem = [Gdi32]::CreateCompatibleDC($hdc)
    $hbm = [Gdi32]::CreateCompatibleBitmap($hdc, $srcWidth, $srcHeight)
    $hOldBmp = [Gdi32]::SelectObject($hdcMem, $hbm)

    [void][Gdi32]::BitBlt($hdcMem, 0, 0, $srcWidth, $srcHeight, $hdc, 0, 0, [Gdi32]::SRCCOPY)
    [void][Gdi32]::StretchBlt($hdc, $Power/2, $Power/2, $destWidth, $destHeight, $hdcMem, 0, 0, $srcWidth, $srcHeight, $ropCode)

    [void][Gdi32]::SelectObject($hdcMem, $hOldBmp)
    [void][Gdi32]::DeleteObject($hbm)
    [void][Gdi32]::DeleteDC($hdcMem)
}

function Screen-StretchOutside {
    param (
        [int]$Power,
		[int]$ROP = 0
    )
	
	$ropCode = Get-ROPFromIndex $ROP

    $srcWidth = $width
    $srcHeight = $height
    $destWidth = $width + $Power
    $destHeight = $height + $Power

    $hdcMem = [Gdi32]::CreateCompatibleDC($hdc)
    $hbm = [Gdi32]::CreateCompatibleBitmap($hdc, $srcWidth, $srcHeight)
    $hOldBmp = [Gdi32]::SelectObject($hdcMem, $hbm)

    [void][Gdi32]::BitBlt($hdcMem, 0, 0, $srcWidth, $srcHeight, $hdc, 0, 0, [Gdi32]::SRCCOPY)
    [void][Gdi32]::StretchBlt($hdc, -$Power/2, -$Power/2, $destWidth, $destHeight, $hdcMem, 0, 0, $srcWidth, $srcHeight, $ropCode)

    [void][Gdi32]::SelectObject($hdcMem, $hOldBmp)
    [void][Gdi32]::DeleteObject($hbm)
    [void][Gdi32]::DeleteDC($hdcMem)
}

function Screen-FlipVertical {
    $hdcMem = [Gdi32]::CreateCompatibleDC($hdc)
    $hbm = [Gdi32]::CreateCompatibleBitmap($hdc, $width, $height)
    $hOldBmp = [Gdi32]::SelectObject($hdcMem, $hbm)

    [void][Gdi32]::BitBlt($hdcMem, 0, 0, $width, $height, $hdc, 0, 0, [Gdi32]::SRCCOPY)
    [void][Gdi32]::StretchBlt($hdc, 0, 0, $width, $height, $hdcMem, 0, $height, $width, -$height, [Gdi32]::SRCCOPY)

    [void][Gdi32]::SelectObject($hdcMem, $hOldBmp)
    [void][Gdi32]::DeleteObject($hbm)
    [void][Gdi32]::DeleteDC($hdcMem)
}

function Screen-FlipHorizontal {
    $hdcMem = [Gdi32]::CreateCompatibleDC($hdc)
    $hbm = [Gdi32]::CreateCompatibleBitmap($hdc, $width, $height)
    $hOldBmp = [Gdi32]::SelectObject($hdcMem, $hbm)

    [void][Gdi32]::BitBlt($hdcMem, 0, 0, $width, $height, $hdc, 0, 0, [Gdi32]::SRCCOPY)
    [void][Gdi32]::StretchBlt($hdc, 0, 0, $width, $height, $hdcMem, $width, 0, -$width, $height, [Gdi32]::SRCCOPY)

    [void][Gdi32]::SelectObject($hdcMem, $hOldBmp)
    [void][Gdi32]::DeleteObject($hbm)
    [void][Gdi32]::DeleteDC($hdcMem)
}

function Screen-Pixelate {
	param (
		[int]$Power
	)
	
    $hMemDC = [Gdi32]::CreateCompatibleDC($hdc)
    $hBitmap = [Gdi32]::CreateCompatibleBitmap($hdc, $width, $height)
    [void][Gdi32]::SelectObject($hMemDC, $hBitmap)

    [void][Gdi32]::BitBlt($hMemDC, 0, 0, $width, $height, $hdc, 0, 0, [Gdi32]::SRCCOPY)

    $hMemDCPixel = [Gdi32]::CreateCompatibleDC($hdc)
    $hBitmapPixel = [Gdi32]::CreateCompatibleBitmap($hdc, $width / $Power, $height / $Power)
    [void][Gdi32]::SelectObject($hMemDCPixel, $hBitmapPixel)

    [void][Gdi32]::StretchBlt($hMemDCPixel, 0, 0, $width / $Power, $height / $Power, $hMemDC, 0, 0, $width, $height, [Gdi32]::SRCCOPY)

    [void][Gdi32]::StretchBlt($hdc, 0, 0, $width, $height, $hMemDCPixel, 0, 0, $width / $Power, $height / $Power, [Gdi32]::SRCCOPY)

    [void][Gdi32]::DeleteDC($hMemDC)
    [void][Gdi32]::DeleteDC($hMemDCPixel)
    [void][Gdi32]::DeleteObject($hBitmap)
    [void][Gdi32]::DeleteObject($hBitmapPixel)
}

function Screen-Move {
	param (
		[int]$OffsetX,
		[int]$OffsetY
	)
	
	$hdcMem = [Gdi32]::CreateCompatibleDC($hdc)
    $hbm = [Gdi32]::CreateCompatibleBitmap($hdc, $width, $height)
    $hOldBmp = [Gdi32]::SelectObject($hdcMem, $hbm)

    [void][Gdi32]::BitBlt($hdcMem, 0, 0, $width, $height, $hdc, 0, 0, [Gdi32]::SRCCOPY)
    [void][Gdi32]::BitBlt($hdc, $OffsetX, $OffsetY, $width, $height, $hdcMem, 0, 0, [Gdi32]::SRCCOPY)
    [void][Gdi32]::BitBlt($hdc, $OffsetX - $width, 0, $width, $height, $hdcMem, 0, 0, [Gdi32]::SRCCOPY)
    [void][Gdi32]::BitBlt($hdc, 0, $OffsetY - $height, $width, $height, $hdcMem, 0, 0, [Gdi32]::SRCCOPY)
    [void][Gdi32]::BitBlt($hdc, $OffsetX - $width, $OffsetY - $height, $width, $height, $hdcMem, 0, 0, [Gdi32]::SRCCOPY)

    [void][Gdi32]::SelectObject($hdcMem, $hOldBmp)
    [void][Gdi32]::DeleteObject($hbm)
    [void][Gdi32]::DeleteDC($hdcMem)
}

function Screen-Text {
    param (
		[int]$X,
		[int]$Y,
        [string]$Text,
        [int]$Size,
        [int]$Color
    )

    $hdcMem = [Gdi32]::CreateCompatibleDC($hdc)
    $hFont = [Gdi32]::CreateFont($Size, 0, 0, 0, [Gdi32]::FW_NORMAL, 0, 0, 0, [Gdi32]::DEFAULT_CHARSET, [Gdi32]::OUT_DEFAULT_PRECIS, [Gdi32]::CLIP_DEFAULT_PRECIS, [Gdi32]::DEFAULT_QUALITY, [Gdi32]::DEFAULT_PITCH, "Arial")
    $hOldFont = [Gdi32]::SelectObject($hdcMem, $hFont)
    $oldColor = [Gdi32]::SetTextColor($hdc, $Color)
    $oldBkColor = [Gdi32]::SetBkColor($hdc, [Gdi32]::RGB(0, 0, 0))
    $oldBkMode = [Gdi32]::SetBkMode($hdc, [Gdi32]::TRANSPARENT)

    [void][Gdi32]::TextOut($hdc, $X, $Y, $Text, $Text.Length)

    [void][Gdi32]::SetTextColor($hdc, $oldColor)
    [void][Gdi32]::SetBkColor($hdc, $oldBkColor)
    [void][Gdi32]::SetBkMode($hdc, $oldBkMode)
    [void][Gdi32]::SelectObject($hdcMem, $hOldFont)
    [void][Gdi32]::DeleteObject($hFont)
    [void][Gdi32]::DeleteDC($hdcMem)
}

function Ellipse {
    param (
        [int]$X,
        [int]$Y,
        [int]$Width,
        [int]$Height,
        [int]$Color,
        [int]$Stroke = 5,
        [int]$StrokeColor
    )
    
    [void][Gdi32]::SetBkMode($hdc, [Gdi32]::TRANSPARENT)
    
    $hPen = [Gdi32]::CreatePen([Gdi32]::PS_SOLID, $Stroke, $StrokeColor)
    $hOldPen = [Gdi32]::SelectObject($hdc, $hPen)
    
    $hBrush = [Gdi32]::CreateSolidBrush($Color)
    $hOldBrush = [Gdi32]::SelectObject($hdc, $hBrush)
    
    [void][Gdi32]::Ellipse($hdc, $X, $Y, $X + $Width, $Y + $Height)
    
    [void][Gdi32]::SelectObject($hdc, $hOldPen)
    [void][Gdi32]::SelectObject($hdc, $hOldBrush)
    [void][Gdi32]::DeleteObject($hPen)
    [void][Gdi32]::DeleteObject($hBrush)
}

function Rectangle {
    param (
        [int]$X,
        [int]$Y,
        [int]$Width,
        [int]$Height,
        [int]$Color,
        [int]$Stroke = 5,
        [int]$StrokeColor
    )
    
    [void][Gdi32]::SetBkMode($hdc, [Gdi32]::TRANSPARENT)
    
    $hPen = [Gdi32]::CreatePen([Gdi32]::PS_SOLID, $Stroke, $StrokeColor)
    $hOldPen = [Gdi32]::SelectObject($hdc, $hPen)
    
    $hBrush = [Gdi32]::CreateSolidBrush($Color)
    $hOldBrush = [Gdi32]::SelectObject($hdc, $hBrush)
    
    [void][Gdi32]::Rectangle($hdc, $X, $Y, $X + $Width, $Y + $Height)
    
    [void][Gdi32]::SelectObject($hdc, $hOldPen)
    [void][Gdi32]::SelectObject($hdc, $hOldBrush)
    [void][Gdi32]::DeleteObject($hPen)
    [void][Gdi32]::DeleteObject($hBrush)
}

function Screen-InvertRectangle {
    param (
        [int]$X,
        [int]$Y,
        [int]$Width,
        [int]$Height,
        [int]$Align = 0, # 0 - Default | 1 - Center
        [int]$ROP = $ROP_DSTINVERT
    )
	
	$ropCode = Get-ROPFromIndex -Index $ROP
    
    if ($Align -eq 1) {
        $X = $X - [math]::Floor($Width / 2)
        $Y = $Y - [math]::Floor($Height / 2)
    }

    [void][Gdi32]::PatBlt($hdc, $X, $Y, $Width, $Height, $ropCode)
}

function Screen-DrawImage {
    param (
        [string]$Image,       	# Path to the image
        [int]$X,              	
        [int]$Y,              	
        [int]$ImageWidth = -1,	# Width to draw the image (default: -1, original width)
        [int]$ImageHeight = -1,	# Height to draw the image (default: -1, original height)
        [int]$ROP = $ROP_SRCCOPY
    )
	
	$ropCode = Get-ROPFromIndex -Index $ROP

    $bitmap = [System.Drawing.Bitmap]::FromFile($Image)

    $originalWidth = $bitmap.Width
    $originalHeight = $bitmap.Height

    if ($ImageWidth -eq -1) {
        $ImageWidth = $originalWidth
    }
    if ($ImageHeight -eq -1) {
        $ImageHeight = $originalHeight
    }

    $hdcMem = [Gdi32]::CreateCompatibleDC($hdc)

    $hBitmap = $bitmap.GetHbitmap()
    $hOldBmp = [Gdi32]::SelectObject($hdcMem, $hBitmap)

    [void][Gdi32]::StretchBlt($hdc, $X, $Y, $ImageWidth, $ImageHeight, $hdcMem, 0, 0, $originalWidth, $originalHeight, $ropCode)

    [void][Gdi32]::SelectObject($hdcMem, $hOldBmp)
    [void][Gdi32]::DeleteObject($hBitmap)
    [void][Gdi32]::DeleteDC($hdcMem)
    [void]$bitmap.Dispose()
}

function Screen-Waves {
	param (
        [int]$Frequency = 10,
        [int]$Amplitude = 10,
        [int]$Optimize = 2,
        [switch]$Horizontal,
        [switch]$Vertical
    )

    $hdcMem = [Gdi32]::CreateCompatibleDC($hdc)
    $hBitmap = [Gdi32]::CreateCompatibleBitmap($hdc, $width, $height)
    $hOldBitmap = [Gdi32]::SelectObject($hdcMem, $hBitmap)

    [void][Gdi32]::BitBlt($hdcMem, 0, 0, $width, $height, $hdc, 0, 0, [Gdi32]::SRCCOPY)

    $twoPiOverFreq = 2 * [math]::PI / $Frequency

    if ($Horizontal) {
        for ($y = 0; $y -lt $height; $y += $Optimize) {
            $offset = [math]::Sin($twoPiOverFreq * $y) * $Amplitude
            [void][Gdi32]::BitBlt($hdc, $offset, $y, $width - [math]::Abs($offset), $Optimize, $hdcMem, 0, $y, [Gdi32]::SRCCOPY)
        }
    }

    if ($Vertical) {
        for ($x = 0; $x -lt $width; $x += $Optimize) {
            $offset = [math]::Sin($twoPiOverFreq * $x) * $Amplitude
            [void][Gdi32]::BitBlt($hdc, $x, $offset, $Optimize, $height - [math]::Abs($offset), $hdcMem, $x, 0, [Gdi32]::SRCCOPY)
        }
    }

    [void][Gdi32]::SelectObject($hdcMem, $hOldBitmap)
    [void][Gdi32]::DeleteObject($hBitmap)
    [void][Gdi32]::DeleteDC($hdcMem)
}

function Screen-Refresh {
    [void][User32]::InvalidateRect([IntPtr]::Zero, [IntPtr]::Zero, $true)
}

function Get-RandomColor {
	return Get-Random -Minimum 0 -Maximum 0xFFFFFF
}

$ROP_SRCCOPY = 0
$ROP_SRCPAINT = 1
$ROP_SRCAND = 2
$ROP_SRCINVERT = 3
$ROP_SRCERASE = 4
$ROP_NOTSRCCOPY = 5
$ROP_NOTSRCERASE = 6
$ROP_MERGECOPY = 7
$ROP_PATCOPY = 8
$ROP_PATPAINT = 9
$ROP_PATINVERT = 10
$ROP_DSTINVERT = 11
$ROP_BLACKNESS = 12
$ROP_WHITENESS = 13

function Get-ROPFromIndex {
    param (
        [int]$Index
    )

    switch ($Index) {
        0 { return [Gdi32]::SRCCOPY }
        1 { return [Gdi32]::SRCPAINT }
        2 { return [Gdi32]::SRCAND }
        3 { return [Gdi32]::SRCINVERT }
        4 { return [Gdi32]::SRCERASE }
        5 { return [Gdi32]::NOTSRCCOPY }
        6 { return [Gdi32]::NOTSRCERASE }
        7 { return [Gdi32]::MERGECOPY }
        8 { return [Gdi32]::PATCOPY }
        9 { return [Gdi32]::PATPAINT }
        10 { return [Gdi32]::PATINVERT }
        11 { return [Gdi32]::DSTINVERT }
        12 { return [Gdi32]::BLACKNESS }
        13 { return [Gdi32]::WHITENESS }
        default { throw "Invalid ROP index" }
    }
}

function User-GetCursorPosition {
    $point = New-Object User32+POINT
    [void][User32]::GetCursorPos([ref]$point)
    return [PSCustomObject]@{
        X = $point.X
        Y = $point.Y
    }
}

function User-SetCursorPosition {
    param (
        [int]$X,
        [int]$Y
    )
    [void][User32]::SetCursorPos($X, $Y)
}

function User-DragCursor {
    param (
        [int]$Scale = 10
    )

    if ($Scale -le 0) {
        throw "Scale must be a positive integer."
    }

    $mouse = User-GetCursorPosition
    $invertedScale = $Scale * -1
    $offsetX = Get-Random -Minimum $invertedScale -Maximum $Scale
    $offsetY = Get-Random -Minimum $invertedScale -Maximum $Scale
    $mouseX = $mouse.X + $offsetX
    $mouseY = $mouse.Y + $offsetY
    User-SetCursorPosition -X $mouseX -Y $mouseY

    return [PSCustomObject]@{
        X = $mouseX
        Y = $mouseY
    }
}

function User-SetDesktopBackground {
    param (
        [string]$ImagePath
    )

    if (-Not (Test-Path $imagePath)) {
        Write-Error "Image path does not exist."
        return
    }

    # SPI_SETDESKWALLPAPER is 20, and SPIF_UPDATEINIFILE | SPIF_SENDWININICHANGE is 0x01 | 0x02
    $SPI_SETDESKWALLPAPER = 0x0014
    $SPIF_UPDATEINIFILE = 0x01
    $SPIF_SENDWININICHANGE = 0x02

    $result = [User32]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $ImagePath, $SPIF_UPDATEINIFILE -bor $SPIF_SENDWININICHANGE)

    if ($result -ne 0) {
    } else {
        Write-Error "Failed to change desktop background."
    }
}

function User-GetDesktopBackground {
	return [Wallpaper]::GetDesktopWallpaper()
}


<#
	YOUR METHODS
	---------------------
	Define your methods here.
#>


<#
	MAIN LOOP
	---------------------
	Define your program logic. 
#>

# Define TimeKeys array with time intervals
$TimeKeys = @(7, 20, 32, 46, 58, 71, 84, 92, 99)

# Play music
Play-Audio -FilePath $musicPath

# Start time
$startTime = Get-Date

# To-Do once
Add-Type -AssemblyName System.Drawing
Add-Type @"
using System;
using System.Runtime.InteropServices;

public class Wallpaper
{
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
    
    public const int SPI_GETDESKWALLPAPER = 0x0073;
    public const int SPI_SETDESKWALLPAPER = 20;

    public static string GetDesktopWallpaper()
    {
        // Buffer for wallpaper path
        string wallpaperPath = new string('\0', 260);
        SystemParametersInfo(SPI_GETDESKWALLPAPER, wallpaperPath.Length, wallpaperPath, 0);
        return wallpaperPath.Trim('\0');
    }

    public static void SetDesktopWallpaper(string wallpaperPath)
    {
        SystemParametersInfo(SPI_SETDESKWALLPAPER, 0, wallpaperPath, 3);
    }
}
"@

# Получение текущего фона рабочего стола
$currentWallpaperPath = [Wallpaper]::GetDesktopWallpaper()

if (-not [string]::IsNullOrWhiteSpace($currentWallpaperPath)) {
    Write-Host "Current desktop wallpaper path: $currentWallpaperPath"
    
    # Сохранение текущего фона в файл
    $backupWallpaperPath = Join-Path -Path $env:TEMP -ChildPath "backup_wallpaper.jpg"
    Copy-Item -Path $currentWallpaperPath -Destination $backupWallpaperPath -ErrorAction SilentlyContinue
    
    # Установка нового фона рабочего стола
    [Wallpaper]::SetDesktopWallpaper($backgroundPath)
} else {
    Write-Host "No wallpaper found."
}

while ($true) {
    $elapsedSeconds = (Get-Date) - $startTime
    $currentElapsed = $elapsedSeconds.TotalSeconds # Elapsed Seconds (Value)
	
	Reset-HDC

    if ($currentElapsed -lt $TimeKeys[0]) {
        $x = Get-Random -Minimum 0 -Maximum $width
        $y = Get-Random -Minimum 0 -Maximum $height
		$c = Get-Random -Minimum 5 -Maximum 10
		$p = Get-Random -Minimum 0 -Maximum 1
        for ($i = 0; $i -lt $c; $i++) {
            $s = $i * 50
            Screen-InvertRectangle -X $x -Y $y -Width $s -Height $s -Align $p
        }
    } elseif ($currentElapsed -lt $TimeKeys[1]) {
		$power = Get-Random -Minimum 35 -Maximum 45
		Screen-StretchInside -Power $power
		Screen-Waves -Frequency 5 -Amplitude 20 -Optimize 4 -Horizontal
    } elseif ($currentElapsed -lt $TimeKeys[2]) {
		Screen-Move -OffsetX 10 -OffsetY 10
    } elseif ($currentElapsed -lt $TimeKeys[3]) {
		$power = Get-Random -Minimum 2 -Maximum 3
		$offsetX = Get-Random -Minimum (-10) -Maximum 10
		$offsetY = Get-Random -Minimum (-10) -Maximum 10
		Screen-Pixelate -Power $power
		Screen-Move -OffsetX $offsetX -OffsetY $offsetY
    } elseif ($currentElapsed -lt $TimeKeys[4]) {
		Screen-FlipHorizontal
		Screen-StretchOutside -Power 20 -ROP $ROP_SRCINVERT
    } elseif ($currentElapsed -lt $TimeKeys[5]) {
		$power = Get-Random -Minimum 35 -Maximum 45
		Screen-StretchInside -Power $power
		Screen-Waves -Frequency 5 -Amplitude 20 -Optimize 4 -Vertical
    } elseif ($currentElapsed -lt $TimeKeys[6]) {
		for ($i = 0; $i -lt 5; $i++) {
			Reset-HDC
			$color = Get-RandomColor
			$x = Get-Random -Minimum 0 -Maximum $width
			$y = Get-Random -Minimum 0 -Maximum $height
			Screen-Text -X $x -Y $y -Text "STAKAN20.EXE" -Size 50 -Color $color		
			$color = Get-RandomColor
			$x = Get-Random -Minimum 0 -Maximum $width
			$y = Get-Random -Minimum 0 -Maximum $height
			Screen-Text -X $x -Y $y -Text "stakan20.EXE" -Size 50 -Color $color
		}
    } elseif ($currentElapsed -lt $TimeKeys[7]) {
		Screen-FlipHorizontal
		Screen-FlipVertical
		
		$x = Get-Random -Minimum 0 -Maximum $width
		$y = Get-Random -Minimum 0 -Maximum $height
		Screen-DrawImage $cursorPath -X $x -Y $y -ROP 0
		Screen-StretchInside -ROP 2
    } elseif ($currentElapsed -lt $TimeKeys[8]) {
		Screen-DrawImage -Image $cursorPath -X 0 -Y 0 -Width $width -Height $height
		Start-Sleep -Milliseconds 100
    } else {
        break
    }
	
	$mouse = User-GetCursorPosition
	Screen-DrawImage -Image $cursorPath -X $mouse.X -Y $mouse.Y -ROP 3
	Screen-DrawImage -Image $cursorPath -X $mouse.X -Y $mouse.Y -ROP 1
    Start-Sleep -Milliseconds 1
}

# Восстановление оригинального фона рабочего стола
$backupWallpaperPath = Join-Path -Path $env:TEMP -ChildPath "backup_wallpaper.jpg"

if (Test-Path $backupWallpaperPath) {
    [Wallpaper]::SetDesktopWallpaper($backupWallpaperPath)
} else {
    Write-Host "Backup wallpaper not found. Cannot restore."
}
Release-DC -HDC $hdc