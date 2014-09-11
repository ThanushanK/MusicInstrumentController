#include <stdio.h>

void strumLCD()
{
  	volatile char * LCD_display_ptr = (char *) 0x10003050;	// 16x2 character display

	char text [20] = "Strum";
	char *text_ptr = &text;
	while ( *(text_ptr) )
	{
		*(LCD_display_ptr + 1) = *(text_ptr);	// write to the LCD data register
		++text_ptr;
	}
}
void pitch1LCD()
{
  	volatile char * LCD_display_ptr = (char *) 0x10003050;	// 16x2 character display

	char text [20] = "Pitch: 1";
	char *text_ptr = &text;
	while ( *(text_ptr) )
	{
		*(LCD_display_ptr + 1) = *(text_ptr);	// write to the LCD data register
		++text_ptr;
	}
}
void pitch2LCD()
{
  	volatile char * LCD_display_ptr = (char *) 0x10003050;	// 16x2 character display

	char text [20] = "Pitch: 2";
	char *text_ptr = &text;
	while ( *(text_ptr) )
	{
		*(LCD_display_ptr + 1) = *(text_ptr);	// write to the LCD data register
		++text_ptr;
	}
}
void pitch3LCD()
{
  	volatile char * LCD_display_ptr = (char *) 0x10003050;	// 16x2 character display

	char text [20] = "Pitch: 3";
	char *text_ptr = &text;
	while ( *(text_ptr) )
	{
		*(LCD_display_ptr + 1) = *(text_ptr);	// write to the LCD data register
		++text_ptr;
	}
}
void pitch4LCD()
{
  	volatile char * LCD_display_ptr = (char *) 0x10003050;	// 16x2 character display

	char text [20] = "Pitch: 4";
	char *text_ptr = &text;
	while ( *(text_ptr) )
	{
		*(LCD_display_ptr + 1) = *(text_ptr);	// write to the LCD data register
		++text_ptr;
	}
}
void pitch5LCD()
{
  	volatile char * LCD_display_ptr = (char *) 0x10003050;	// 16x2 character display

	char text [20] = "Pitch: 5";
	char *text_ptr = &text;
	while ( *(text_ptr) )
	{
		*(LCD_display_ptr + 1) = *(text_ptr);	// write to the LCD data register
		++text_ptr;
	}
}
void pitch6LCD()
{
  	volatile char * LCD_display_ptr = (char *) 0x10003050;	// 16x2 character display

	char text [20] = "Pitch: 6";
	char *text_ptr = &text;
	while ( *(text_ptr) )
	{
		*(LCD_display_ptr + 1) = *(text_ptr);	// write to the LCD data register
		++text_ptr;
	}
}

void TimerOnLCD()
{
  	volatile char * LCD_display_ptr = (char *) 0x10003050;	// 16x2 character display

	char text [20] = "Timer: ON";
	char *text_ptr = &text;
	while ( *(text_ptr) )
	{
		*(LCD_display_ptr + 1) = *(text_ptr);	// write to the LCD data register
		++text_ptr;
	}
}
void TimerOffLCD()
{
  	volatile char * LCD_display_ptr = (char *) 0x10003050;	// 16x2 character display

	char text [20] = "Timer: OFF";
	char *text_ptr = &text;
	while ( *(text_ptr) )
	{
		*(LCD_display_ptr + 1) = *(text_ptr);	// write to the LCD data register
		++text_ptr;
	}
}
void Period1LCD()
{
  	volatile char * LCD_display_ptr = (char *) 0x10003050;	// 16x2 character display

	char text [20] = "Time Period: 1";
	char *text_ptr = &text;
	while ( *(text_ptr) )
	{
		*(LCD_display_ptr + 1) = *(text_ptr);	// write to the LCD data register
		++text_ptr;
	}
}
void Period2LCD()
{
  	volatile char * LCD_display_ptr = (char *) 0x10003050;	// 16x2 character display

	char text [20] = "Time Period: 2";
	char *text_ptr = &text;
	while ( *(text_ptr) )
	{
		*(LCD_display_ptr + 1) = *(text_ptr);	// write to the LCD data register
		++text_ptr;
	}
}

void Period3LCD()
{
  	volatile char * LCD_display_ptr = (char *) 0x10003050;	// 16x2 character display

	char text [20] = "Time Period: 3";
	char *text_ptr = &text;
	while ( *(text_ptr) )
	{
		*(LCD_display_ptr + 1) = *(text_ptr);	// write to the LCD data register
		++text_ptr;
	}
}

void TimeManualLCD()
{
  	volatile char * LCD_display_ptr = (char *) 0x10003050;	// 16x2 character display

	char text [20] = "Time: Manual";
	char *text_ptr = &text;
	while ( *(text_ptr) )
	{
		*(LCD_display_ptr + 1) = *(text_ptr);	// write to the LCD data register
		++text_ptr;
	}
}

