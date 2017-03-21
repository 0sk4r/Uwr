/*
 *  SE_ERR_NOASSOC
 */

#include <windows.h>
#include <Strsafe.h>
#include <Shlobj.h>

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, PSTR szCmdLine, int iCmdShow)
{
  DWORD dwWrote;
  HANDLE hFile;

  char sTime[22];
  SYSTEMTIME time;

  GetSystemTime(&time);
  GetDateFormat(LOCALE_SYSTEM_DEFAULT, 0, &time, TEXT("dd-MM-yyyy"), sTime, 22);

  LPCSTR path[MAX_PATH];

  SHGetSpecialFolderPath(HWND_DESKTOP, path, CSIDL_DESKTOPDIRECTORY, FALSE);
  
  StringCchCat(path, 200, TEXT("\\test.txt"));

  hFile = CreateFile(path, GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, 0, NULL);
  if (hFile == INVALID_HANDLE_VALUE)
  {
    MessageBox(NULL, TEXT("Wystapil blad podczas tworzenia pliku"), TEXT("Error"), 0);
    PostQuitMessage(0);
  }

  if (!WriteFile(hFile, sTime, 22, &dwWrote, NULL))
  {
    MessageBox(NULL, TEXT("Wystapil blad podczas zapisywania"), TEXT("Error"), MB_ICONEXCLAMATION);
    PostQuitMessage(0);
  }

  int result = ShellExecute(0, "print", path, NULL, NULL, 0);

  if (result<32)
  {
    WCHAR buf[64];
    swprintf_s(buf, 64, TEXT("Bład podczas drukowania: %d"), result);

    MessageBox(0, buf, 0, 0);
  }
 
  CloseHandle(hFile);
}