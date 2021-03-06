#include <windows.h>
#include <CommCtrl.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>

#define ID_TIMER 1
#define TICK 100


/* Deklaracja wyprzedzaj�ca: funkcja obs�ugi okna */
LRESULT CALLBACK WindowProcedure(HWND, UINT, WPARAM, LPARAM);
/* Nazwa klasy okna */
char szClassName[] = "zadania 1.1.5 ";

HWND hProgressbar, hStatusbar, hListbox, hbutton;

int counter = 0;

HINSTANCE * hMainInstance;

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nShowCmd)
{
  
  hMainInstance = &hInstance;

  HWND hwnd;               /* Uchwyt okna */
  MSG messages;            /* Komunikaty okna */
  WNDCLASSEX wincl;        /* Struktura klasy okna */

                           /* Klasa okna */
  wincl.hInstance = hInstance;
  wincl.lpszClassName = szClassName;
  wincl.lpfnWndProc = WindowProcedure;    // wska�nik na funkcj� 
                                          // obs�ugi okna  
  wincl.style = CS_DBLCLKS;
  wincl.cbSize = sizeof(WNDCLASSEX);

  /* Domy�lna ikona i wska�nik myszy */
  wincl.hIcon = LoadIcon(NULL, IDI_APPLICATION);
  wincl.hIconSm = LoadIcon(NULL, IDI_APPLICATION);
  wincl.hCursor = LoadCursor(NULL, IDC_ARROW);
  wincl.lpszMenuName = NULL;
  wincl.cbClsExtra = 0;
  wincl.cbWndExtra = 0;
  wincl.hbrBackground = (HBRUSH)GetStockObject(WHITE_BRUSH);

  /* Rejestruj klas� okna */
  if (!RegisterClassEx(&wincl)) return 0;

  /* Tw�rz okno */
  hwnd = CreateWindowEx(
    0, szClassName,
    TEXT("1.1.5"),
    WS_OVERLAPPEDWINDOW,
    CW_USEDEFAULT, CW_USEDEFAULT,
    500, 500,
    HWND_DESKTOP, NULL,
    hInstance, NULL);

  ShowWindow(hwnd, nShowCmd);
  UpdateWindow(hwnd);

  /* P�tla obs�ugi komunikat�w */
  while (GetMessage(&messages, NULL, 0, 0))
  {
    /* T�umacz kody rozszerzone */
    TranslateMessage(&messages);
    /* Obs�u� komunikat */
    DispatchMessage(&messages);
  }

  /* Zwr�� parametr podany w PostQuitMessage( ) */
  return messages.wParam;
}

/* T� funkcj� wo�a DispatchMessage( ) */
LRESULT CALLBACK WindowProcedure(HWND hwnd, UINT message,
  WPARAM wParam, LPARAM lParam)
{
  PAINTSTRUCT ps;
  HDC hdc;
  int tmp;
  WCHAR buf[80];

  switch (message)
  {
  case WM_TIMER:
    counter += 1;
    swprintf_s(buf, 80, TEXT("Total clicks: %d"), counter);
    SendMessage(hProgressbar, PBM_SETPOS, counter,(LPARAM) MAKELONG(0,50));
    SendMessage(hListbox, LB_INSERTSTRING, 0, (LPARAM)buf);
    swprintf_s(buf, 80, TEXT("Total clicks: %d"), counter);
    SendMessage(hStatusbar, SB_SETTEXT, 0, (LPARAM)buf);
    break;
  case WM_DESTROY:
	KillTimer(hwnd, ID_TIMER);
    PostQuitMessage(0);
    break;
  case WM_SIZE:
    SendMessage(hStatusbar, WM_SIZE, 0, 0);
    break;
  case WM_CREATE:
    hProgressbar = CreateWindowEx(0, PROGRESS_CLASS, NULL, WS_CHILD | WS_VISIBLE | PBS_SMOOTH, 5, 5, 500, 20, hwnd, 0, *hMainInstance, 0);
    hStatusbar = CreateWindowEx(0, STATUSCLASSNAME, TEXT("Total clicks: 0"), WS_CHILD | WS_VISIBLE, 0, 0, 0, 0, hwnd, 0, *hMainInstance, 0);
    hListbox = CreateWindowEx(0, WC_LISTBOX, NULL, WS_CHILD | WS_VISIBLE | WS_VSCROLL | ES_AUTOHSCROLL, 5, 50, 500, 200, hwnd, 0, *hMainInstance, 0);
	hbutton = CreateWindowEx(0, "BUTTON", "Click!", WS_CHILD | WS_VISIBLE,600, 100, 150, 30, hwnd, NULL, *hMainInstance, NULL);
	SetTimer(hwnd, ID_TIMER, TICK, NULL);
    break;
  case WM_PAINT:
    hdc = BeginPaint(hwnd, &ps);

    EndPaint(hwnd, &ps);
    break;
  case WM_COMMAND:
    switch (wParam)
    {
    default:
      break;
    }
    break;
  default:
    return DefWindowProc(hwnd, message, wParam, lParam);
  }
  return 0;
}