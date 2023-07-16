#ifndef ASS_2_UI_H
#define ASS_2_UI_H

#include <stdio.h>
#include <windows.h>

#include "global.h"

#define centering "                         "

/* I/O */
void inputInt(int* container,
              int min,
              int max,
              char* notice);
void inputBox(char* container,
              int minLen,
              int maxLen,
              char* notice);
int reg(Accounts* reg);
int login(Accounts* login);
int printGameHistory(Accounts* user);
int appendGameHistory(GameHistory* gameHistory);
int removeGameHistoryofUser(Accounts* user);
int destroyAccount(Accounts* user);

/* Game */
GameHistory* game(Accounts* player);

#endif
