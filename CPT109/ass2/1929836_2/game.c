#include "game.h"

void printPic(int index) {
    switch (index) {
        case 0:
            printf(solved);
            break;
        case 1:
            printf(confusing);
            break;
        case 2:
            printf(weeping);
            break;
        case 3:
            printf(surprised);
            break;
        case 4:
            printf(died);
            break;
        case 5:
            printf(happy);
            break;
        case 6:
            printf(unbearable);
            break;
        case 7:
            printf(money);
            break;
        case 8:
            printf(blinking);
            break;
        default:
            printf(speechless);
    }
}

void printAxis(void) {
    /* X */
    setPos(15, 2);
    printf("1");
    setPos(24, 2);
    printf("2");
    setPos(33, 2);
    printf("3");
    setPos(42, 2);
    printf("4");

    /* Y */
    setPos(10, 4);
    printf("1");
    setPos(10, 8);
    printf("2");
    setPos(10, 12);
    printf("3");
    setPos(10, 16);
    printf("4");
}

void printAll(int matrix[SIZE_MATRIX][SIZE_MATRIX]) {
    int i, j;

    printf("\n\n\n\n");

    for (i = 0; i < SIZE_MATRIX; ++i) {

        /* Centering */
        printf(CENTERING);

        for (j = 0; j < SIZE_MATRIX; ++j) {
            SetColor(13, 0);

            if (matrix[i][j] == UNSOLVED)
                SetColor(7, 0);

            if (j == SIZE_MATRIX - 1) {
                printPic(matrix[i][j]);
                continue;
            }

            printPic(matrix[i][j]);
            printf(INTERVAL);  /* Interval space */
        }

        printf("\n\n\n\n");
    }
}

GameHistory* game(Accounts* player) {
    static GameHistory history;

    time_t start, end;
    double duration;
    struct tm* tm;

    int row_1;
    int row_2;
    int col_1;
    int col_2;
    int complete;
    int attempts = 0;
    int answer[SIZE_MATRIX][SIZE_MATRIX];
    int puzzle[SIZE_MATRIX][SIZE_MATRIX];

    /* Temp var */
    int i, j;
    int k = 1;
    int tmp_val, tmp_row, tmp_col;

    /* Initialise */
    for (i = 0; i < SIZE_MATRIX; ++i) {
        for (j = 0; j < SIZE_MATRIX; ++j, ++k) {
            answer[i][j] = k;
            answer[i][++j] = k;
        }
    }
    for (i = 0; i < SIZE_MATRIX; ++i) {
        for (j = 0; j < SIZE_MATRIX; ++j) {
            puzzle[i][j] = UNSOLVED;
        }
    }

    /* Shuffle */
    srand((unsigned)time(NULL));
    for (i = 0; i < SIZE_MATRIX; ++i) {
        for (j = 0; j < SIZE_MATRIX; ++j) {
            tmp_row = rand()%SIZE_MATRIX;
            tmp_col = rand()%SIZE_MATRIX;

            tmp_val = answer[i][j];
            answer[i][j] = answer[tmp_row][tmp_col];
            answer[tmp_row][tmp_col] = tmp_val;
        }
    }

    /* Show the answer with countdown */
    for (i = 5; i > 0; --i) {
		system("cls");
        SetColor(7, 0);
        printAll(answer);
        SetColor(14, 0);
        printf("                       Countdown %ds\n", i);
        Sleep(1000);
    }

    /* Game */
    time(&start);  /* Start the timer */
    while (ture) {
        /* Show the puzzle */
		system("cls");
        SetColor(13, 0);
        printAll(puzzle);
        SetColor(14, 0);
        printAxis();
        setPos(0, 20);

        /* First uncover */
        inputInt(&col_1, 1, SIZE_MATRIX + 1, "[5 for quit] Col");
        if (col_1 == 5)
            return NULL;
        inputInt(&row_1, 1, SIZE_MATRIX + 1, "[5 for quit] Row");  /* 5 for quit in the middle of the game */
        if (row_1 == 5)
            return NULL;

        /* Selected the already unlocked */
        if (puzzle[row_1-1][col_1-1] != UNSOLVED)
            continue;

        /* Uncover it */
        puzzle[row_1-1][col_1-1] = answer[row_1-1][col_1-1];

		/* Selected the already unlocked */
		do {
			system("cls");
            SetColor(13, 0);
            printAll(puzzle);
            SetColor(14, 0);
            printAxis();
            setPos(0, 20);

            /* Second uncover */
            inputInt(&col_2, 1, SIZE_MATRIX + 1, "[5 for quit] Col");
            if (col_2 == 5)
                return NULL;
            inputInt(&row_2, 1, SIZE_MATRIX + 1, "[5 for quit] Row");
            if (row_2 == 5)
                return NULL;

            /* Repeat selection */
			if (row_1 == row_2 && col_1 == col_2)
				continue;

			/* Selected the already unlocked */
			if (puzzle[row_2 - 1][col_2 - 1] != UNSOLVED)
				continue;
			
			break;
		} while (ture);

        puzzle[row_2-1][col_2-1] = answer[row_2-1][col_2-1];
        ++attempts;

        /* Wrong. wait for a while, then hide the wrong guess */
        if (puzzle[row_1-1][col_1-1] != puzzle[row_2-1][col_2-1]) {
			system("cls");
            SetColor(13, 0);
            printAll(puzzle);
            SetColor(14, 0);
            printf("                       Wrong  ");
            SetColor(13, 0);
            printf("%s\n", sad);
            Sleep(2000);

            /* Clear the wrong answer */
            puzzle[row_1-1][col_1-1] = UNSOLVED;
            puzzle[row_2-1][col_2-1] = UNSOLVED;

			continue;
        }

        /* Correct */
        system("cls");
        SetColor(13, 0);
        printAll(puzzle);
        Sleep(500);
        puzzle[row_1-1][col_1-1] = SOLVED;
        puzzle[row_2-1][col_2-1] = SOLVED;

        /* Complete or not */
        complete = ture;
        for (i = 0; i < SIZE_MATRIX; ++i) {
            for (j = 0; j < SIZE_MATRIX; ++j) {
                if (puzzle[i][j] == UNSOLVED)
                    complete = false;
            }
        }

        /* Not complete */
        if (complete == false)
            continue;

        /* Completed */
		system("cls");
        SetColor(13, 0);
        printAll(answer);
        SetColor(14, 0);
        printf("                       Attempts: %d\n\n", attempts);
		system("pause");
        break;
    }
    time(&end);  /* Stop the timer */

    /* Get game duration */
    duration = difftime(end, start);
    history.duration = duration;

    /* Get date */
    tm = localtime(&start);
    sprintf(history.date, "%d%s%d%s%d%s%d%s%d%s%d", (1900 + tm->tm_year), "/", tm->tm_mon, "/", tm->tm_mday, " ", tm->tm_hour, ":", tm->tm_min, ":", tm->tm_sec);

    /* Get ID */
    strcpy(history.id, player->id);

    /* Get attempts */
    history.attempt = attempts;

    return &history;
}