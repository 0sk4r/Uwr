#include <windows.h>
#include <stdlib.h>


/* Deklaracja wyprzedzająca: funkcja obsługi okna */
LRESULT CALLBACK WindowProcedure(HWND, UINT, WPARAM, LPARAM);
/* Nazwa klasy okna */
char szClassName[] = "Zadanie 1.1.1";

static const int STEP = 4;

inline int function1(int x)
{
	return abs(x);
}

inline int function2(int x)
{
	return x * x / 10;
}

int xs, ys;

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nShowCmd)
{
	HWND hwnd;               /* Uchwyt okna */
	MSG messages;            /* Komunikaty okna */
	WNDCLASSEX wincl;        /* Struktura klasy okna */

							 /* Klasa okna */
	wincl.hInstance = hInstance;
	wincl.lpszClassName = szClassName;
	wincl.lpfnWndProc = WindowProcedure;    // wskaźnik na funkcję 
											// obsługi okna  
	wincl.style = CS_DBLCLKS;
	wincl.cbSize = sizeof(WNDCLASSEX);

	/* Domyślna ikona i wskaźnik myszy */
	wincl.hIcon = LoadIcon(NULL, IDI_APPLICATION);
	wincl.hIconSm = LoadIcon(NULL, IDI_APPLICATION);
	wincl.hCursor = LoadCursor(NULL, IDC_ARROW);
	wincl.lpszMenuName = NULL;
	wincl.cbClsExtra = 0;
	wincl.cbWndExtra = 0;
	wincl.hbrBackground = (HBRUSH)GetStockObject(WHITE_BRUSH);

	/* Rejestruj klasę okna */
	if (!RegisterClassEx(&wincl)) return 0;

	/* Twórz okno */
	hwnd = CreateWindowEx(
		0, szClassName,
		TEXT("Zadanie 1.1.1"),
		WS_OVERLAPPEDWINDOW,
		CW_USEDEFAULT, CW_USEDEFAULT,
		512, 512,
		HWND_DESKTOP, NULL,
		hInstance, NULL);

	ShowWindow(hwnd, nShowCmd);
	UpdateWindow(hwnd);
	/* Pętla obsługi komunikatów */
	while (GetMessage(&messages, NULL, 0, 0))
	{
		/* Tłumacz kody rozszerzone */
		TranslateMessage(&messages);
		/* Obsłuż komunikat */
		DispatchMessage(&messages);
	}

	/* Zwróć parametr podany w PostQuitMessage( ) */
	return messages.wParam;
}

/* Tę funkcję woła DispatchMessage( ) */
LRESULT CALLBACK WindowProcedure(HWND hwnd, UINT message,
	WPARAM wParam, LPARAM lParam)
{

	RECT rect;
	HDC hdc;

	PAINTSTRUCT ps;

	int xcenter, ycenter;

	HPEN pen_red, pen_green, pen_black;

	switch (message)
	{
	case WM_DESTROY:
		PostQuitMessage(0);
		break;
	case WM_SIZE:
		xs = LOWORD(lParam);
		ys = HIWORD(lParam);

		GetClientRect(hwnd, &rect);
		InvalidateRect(hwnd, &rect, 1);

		break;
	case WM_PAINT:
		xcenter = xs / 2;
		ycenter = ys / 2;

		pen_red = CreatePen(PS_DOT, 2, RGB(255, 0, 0));
		pen_green = CreatePen(PS_DASHDOTDOT, 2, RGB(0, 255, 0));
		pen_black = CreatePen(PS_SOLID, 2, RGB(0, 0, 0));

		hdc = BeginPaint(hwnd, &ps);
		
		
		//osie
		SelectObject(hdc, pen_black);
		MoveToEx(hdc, xcenter, 0, 0);
		LineTo(hdc, xcenter, ys);
		MoveToEx(hdc, 0, ycenter, 0);
		LineTo(hdc, xs, ycenter);

		//f1
		SelectObject(hdc, pen_red);
		MoveToEx(hdc, xcenter, ycenter - function1(0), 0);
		for (int x = xcenter - STEP; x > 0; x -= STEP) // x <= 0
		{
			int y = ycenter - function1(x - xcenter);
			LineTo(hdc, x, y);
			MoveToEx(hdc, x, y, 0);
		}
		MoveToEx(hdc, xcenter, ycenter - function1(0), 0);
		for (int x = xcenter + STEP; x < xs; x += STEP) // x >= 0
		{
			int y = ycenter - function1(x - xcenter);
			LineTo(hdc, x, y);
			MoveToEx(hdc, x, y, 0);
		}

		//f2
		SelectObject(hdc, pen_green);
		MoveToEx(hdc, xcenter, ycenter - function2(0), 0);
		for (int x = xcenter - STEP; x > 0; x -= STEP) // x <= 0
		{
			int y = ycenter - function2(x - xcenter);
			LineTo(hdc, x, y);
			MoveToEx(hdc, x, y, 0);
		}
		MoveToEx(hdc, xcenter, ycenter - function2(0), 0);
		for (int x = xcenter + STEP; x < xs; x += STEP) // x >= 0
		{
			int y = ycenter - function2(x - xcenter);
			LineTo(hdc, x, y);
			MoveToEx(hdc, x, y, 0);
		}

		DeleteObject(pen_red);
		DeleteObject(pen_green);
		DeleteObject(pen_black);
		EndPaint(hwnd, &ps);

		break;
	default:
		return DefWindowProc(hwnd, message, wParam, lParam);
	}
	return 0;
}