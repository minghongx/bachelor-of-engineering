#include "UI.h"

void SetColor(UINT uFore, UINT uBack) {
    HANDLE handle = GetStdHandle(STD_OUTPUT_HANDLE);
    SetConsoleTextAttribute(handle,uFore+uBack*0x10);
}

void killConsoleButton(void) {
    /* Kill close button */
    DeleteMenu(GetSystemMenu(GetConsoleWindow(), FALSE),
               SC_CLOSE, MF_DISABLED);
    DrawMenuBar(GetConsoleWindow());

    /* Gray out maximize button */
    HWND hwnd = GetConsoleWindow();
    DWORD style = GetWindowLong(hwnd, GWL_STYLE);
    style &= ~WS_MAXIMIZEBOX;
    SetWindowLong(hwnd, GWL_STYLE, style);
    SetWindowPos(hwnd, NULL, 0, 0, 0, 0, SWP_NOSIZE|SWP_NOMOVE|SWP_FRAMECHANGED);
}

void hideConsoleCursor(void) {
    CONSOLE_CURSOR_INFO cursor_info = {1, 0};
    SetConsoleCursorInfo(GetStdHandle(STD_OUTPUT_HANDLE), &cursor_info);
}

void setPosC(COORD a) {
    HANDLE out = GetStdHandle(STD_OUTPUT_HANDLE);
    SetConsoleCursorPosition(out, a);
}
void setPos(int x, int y) {
    COORD pos = {x, y};
    setPosC(pos);
}

void printCommonRina(void) {
    printf("\n\n");
    printf("                    xx                xx\n");
    printf("                    xx                xx\n");
    printf("                    xx                xx\n");
    printf("\n");
    printf("                                        \n");
    printf("                         xxxxxxxxxx     \n");
    printf("                                        \n");
    printf("\n\n");
}

void printSmileRina(void) {
    printf("\n\n");
    printf("                    xx                xx\n");
    printf("                    xx              xx  \n");
    printf("                    xx                xx\n");
    printf("\n");
    printf("                  x x  x          x  x x\n");
    printf("                        xx      xx      \n");
    printf("                          xxxxxx        \n");
    printf("\n\n");
}

void printHappyRina(void) {
    printf("\n\n");
    printf("                  xx                  xx\n");
    printf("                    xx              xx  \n");
    printf("                  xx                  xx\n");
    printf("\n");
    printf("                  x x   xxxxxxxxxx   x x\n");
    printf("                        x        x      \n");
    printf("                          xxxxxx        \n");
    printf("\n\n");
}

void iniCMD(void) {
    killConsoleButton();
    system("title TennShiTennSaiTennNouJi! -- Find the Pairs");
    system("mode con cols=60 lines=25");
}

/**
 * Login menu
 * @return NULL: Exit
 *         Not NULL: User account info
 */
Accounts* Menu_login(void) {
    static Accounts account;
    int choice;
    int flag;

    iniCMD();

    /* Login or register successfully to continue */
    do {
        /* Hint */
		system("cls");
		SetColor(13, 0);
		printCommonRina();
		SetColor(14, 0);
        printf("[1] Register\n");
        printf("[2] Login\n");
        printf("[3] Exit\n");
		printf("\n");

		/* Input */
        inputInt(&choice, 1, 3, "You want");

        switch (choice) {
            case 1:
				system("cls");
                SetColor(13, 0);
                printSmileRina();
                SetColor(14, 0);
                inputBox(account.id, 1, ID_maxLen, "ID");
                inputBox(account.pwd, 1, ID_maxLen, "Password");
				printf("\n");

                /* Try to register */
                flag = reg(&account);

                /* ID already exist */
                if (flag == -3) {
                    system("cls");
                    SetColor(13, 0);
                    printCommonRina();
                    SetColor(14, 0);
                    printf("The ID");
                    SetColor(13, 0);
                    printf(" %s ", account.id);
                    SetColor(14, 0);
                    printf("already exist\n\n");
                    system("pause");
                    continue;
                }

                /* Preventing accidents */
                if (flag != SUCCESS) {
                    system("cls");
                    SetColor(13, 0);
                    printCommonRina();
                    SetColor(14, 0);
                    printf("Something wrong. Try again\n\n");
                    system("pause");
                    continue;
                }

                system("cls");
                SetColor(13, 0);
                printSmileRina();
                SetColor(14, 0);
                printf("Successful Registration\n");
                Sleep(3000);
                return &account;

            case 2:
				system("cls");
                SetColor(13, 0);
                printSmileRina();
                SetColor(14, 0);
                inputBox(account.id, 1, ID_maxLen, "ID");
                inputBox(account.pwd, 1, ID_maxLen, "Password");
                printf("\n");

                /* Try logging in */
                flag = login(&account);

                if (flag == -2) {
                    system("cls");
                    SetColor(13, 0);
                    printCommonRina();
                    SetColor(14, 0);
                    printf("Account data file cannot be found\n\n");
                    system("pause");
                    continue;
                }

                if (flag == -3) {
                    system("cls");
                    SetColor(13, 0);
                    printCommonRina();
                    SetColor(14, 0);
                    printf("ID does not exit\n\n");
                    system("pause");
                    continue;
                }

                if (flag == -4) {
                    system("cls");
                    SetColor(13, 0);
                    printCommonRina();
                    SetColor(14, 0);
                    printf("Password is wrong\n\n");
                    system("pause");
                    continue;
                }

                /* Preventing accidents */
                if (flag != SUCCESS) {
                    system("cls");
                    SetColor(13, 0);
                    printCommonRina();
                    SetColor(14, 0);
                    printf("Something wrong. Try again\n\n");
                    system("pause");
                    continue;
                }

                return &account;

            case 3:
				system("cls");
				hideConsoleCursor();
                SetColor(13, 0);
                printSmileRina();
                SetColor(14, 0);
                printf("%sSee you!\n", centering);
                Sleep(2500);
                return NULL;

            default:
                system("cls");
                SetColor(13, 0);
                printCommonRina();
                SetColor(14, 0);
                printf("There is no such option\n");
                Sleep(3000);
                continue;
        }
    } while (ture);
}

/**
 *  Main menu
 * @return -1: Exit
 */
int Menu_main(Accounts* user) {
    GameHistory* gameHistory;
    int choice;
    int flag;

    /* Login or register successfully to continue */
    do {
        /* Hint */
		system("cls");
        SetColor(13, 0);
        printHappyRina();
        SetColor(14, 0);
        printf("Love you, ");
        SetColor(13, 0);
        printf("%s\n\n", user->id);
        SetColor(14, 0);
        printf("[1] Game start!\n");
        printf("[2] Print game history\n");
        printf("[3] Delete game history\n");
        printf("[4] Delete account (also its game histories!)\n");
        printf("[5] Log out\n");
        printf("[6] Exit\n");
		printf("\n");

		/* Input */
		inputInt(&choice, 1, 6, "You want");

        switch (choice) {
            case 1:
                gameHistory = game(user);

                /* Quit the game in the middle */
                if (!gameHistory)
                    continue;

                appendGameHistory(gameHistory);
                continue;

            case 2:
                system("cls");
                SetColor(13, 0);
                flag = printGameHistory(user);

                if (flag == -2) {
                    SetColor(13, 0);
                    printCommonRina();
                    SetColor(14, 0);
                    printf("Game history data file cannot be found\n\n");
                    system("pause");
                    continue;
                }

                /* Preventing accidents */
                if (flag != SUCCESS) {
                    SetColor(13, 0);
                    printCommonRina();
                    SetColor(14, 0);
                    printf("Something wrong. Try again\n\n");
                    system("pause");
                    continue;
                }

				printf("\n");
                SetColor(14, 0);
				system("pause");
                continue;

            case 3:
                system("cls");
                flag = removeGameHistoryofUser(user);

                if (flag == -2) {
                    SetColor(13, 0);
                    printCommonRina();
                    SetColor(14, 0);
                    printf("Game history data file cannot be found\n\n");
                    system("pause");
                    continue;
                }

                /* Preventing accidents */
                if (flag != SUCCESS) {
                    SetColor(13, 0);
                    printCommonRina();
                    SetColor(14, 0);
                    printf("Something wrong. Try again\n\n");
                    system("pause");
                    continue;
                }

                SetColor(13, 0);
                printSmileRina();
                SetColor(14, 0);
                printf("Game history has been deleted and cannot be recovered\n\n");
                system("pause");
                continue;
            case 4:
                destroyAccount(user);
                return SUCCESS;

            case 5:
                return SUCCESS;

            case 6:
                system("cls");
                hideConsoleCursor();
                SetColor(13, 0);
                printSmileRina();
                SetColor(14, 0);
                printf("%sSee you!\n", centering);
                Sleep(2500);
                return -1;

            default:
                system("cls");
                SetColor(13, 0);
                printCommonRina();
                SetColor(14, 0);
                printf("There is no such option\n");
                Sleep(3000);
                continue;
        }
    } while (ture);
}

/**
 * References
 *
 * Function for console
 * https://blog.csdn.net/cjz2005/article/details/104358000
 *
 * Console API function
 * https://www.cnblogs.com/lanhaicode/p/10498497.html
 *
 * How to Disable the Move System Menu Item?
 * https://stackoverflow.com/questions/2602375/how-to-disable-the-move-system-menu-item
 *
 * Disable Maximize Button c++ console application
 * https://stackoverflow.com/questions/46145256/disable-maximize-button-c-console-application
 *
 * 被玩坏的 C 程序控制台窗口
 * https://blog.csdn.net/mlyjqx/article/details/54458971
 *
 * SetConsoleTextAttribute
 *
 */
