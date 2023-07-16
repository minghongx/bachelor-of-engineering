#ifndef ASS_2_GAME_H
#define ASS_2_GAME_H

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <windows.h>

#include "global.h"

#define SIZE_MATRIX 4
#define UNSOLVED -1
#define SOLVED 0

#define solved "     "
#define confusing "(@_@)"
#define weeping "(T_T)"
#define surprised "(o_O)"
#define died "(X_X)"
#define happy "(^O^)"
#define unbearable "(>_<)"
#define money "($_$)"
#define blinking "(^_+)"
#define speechless "(=_=)"
#define sad "(U_U)"

#define CENTERING "             "
#define INTERVAL "    "

/* IO */
void inputInt(int* container,
              int min,
              int max,
              char* notice);

/* UI */
void SetColor(UINT uFore, UINT uBack);
void setPos(int x, int y);

#endif
