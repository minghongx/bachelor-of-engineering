#include "IO.h"

/**
 * Capture console input integer with size limit
 * @param notice: Hint
 */
void inputInt(int* container, int min, int max, char* notice) {
    char buf[13];  /* -2147483648\n\0 */
    char* stopString = NULL;

    do {
        fflush(stdin);
        printf("%s: ", notice);
        fgets(buf, 13, stdin);  /* It stops when maxLen + 1 characters are read*/

        /* Discard \n at the end */
        if (buf[strlen(buf) - 1] == '\n')
            buf[strlen(buf) - 1] = '\0';

        *container = strtol(buf, &stopString, 10);

        /* Input something not integer */
        if (strcmp(stopString, "") != 0) {
            printf("Input something not integer\n");
            continue;
        }

        /* Limit exceed */
        if (*container < min || *container > max) {
            printf("Input should be an integer from %d to %d\n", min, max);
            continue;
        }

        fflush(stdin);
        break;
    } while (ture);
}

/**
 * Capture console input with length limitation
 * @param notice: Hint
 * @param maxLen: Maximum length of input
 * @param minLen: Minimum length of input
 */
void inputBox(char* container, int minLen, int maxLen, char* notice) {
    char* buf = (char*)calloc(maxLen + 2, sizeof(char));  /* Include \n\0 */

    /* If the input limits are not met , re-entry is required */
    do {
        /* Input */
        fflush(stdin);
        printf("%s (%d-%d characters): ", notice, minLen, maxLen);
        fgets(buf, maxLen + 2, stdin);  /* It stops when maxLen + 1 characters are read*/

        /* Discard \n at the end */
        if (buf[strlen(buf) - 1] == '\n')
            buf[strlen(buf) - 1] = '\0';

        /* If a string is too long, discard the unread content */
        fflush(stdin);

        /* Detect if limits are not met */
        if (strlen(buf) < minLen || strlen(buf) > maxLen) {
            printf("Input length limits not met\n");
            continue;
        }

        fflush(stdin);
        break;
    } while (ture);

    strcpy(container, buf);
    free(buf);
}

/**
 * Register
 * @return -3: ID already exist
 *         -2: Fail to open the file which stores accounts' info
 *         -1: Illegal parameter
 *          0: Success
 */
int reg(Accounts* reg) {
    Accounts exist;
    FILE* fp = NULL;

    /* Parameter verification */
    if (strlen(reg->id) > ID_maxLen)
        return -1;
    if (strlen(reg->pwd) > PWD_maxLen)
        return -1;

    fp = fopen(fDir_accounts, "ab+");
    if (!fp) {
        fclose(fp);
        return -2;
    }

    while (ture) {
        /* ID has not been registered yet */
        if (feof(fp))
            break;

        fread(&exist, sizeof(Accounts), 1, fp);

        /* ID already exist */
        if (strcmp(reg->id, exist.id) == 0) {
            fclose(fp);
            return -3;
        }
    }

    fwrite(reg, sizeof(Accounts), 1, fp);

    fclose(fp);
    return SUCCESS;
}

/**
 * Login
 * @return -4: Password mismatch
 *         -3: ID does not exist
 *         -2: Fail to open the file which stores accounts' info
 *         -1: Illegal parameter
 *          0: Success
 */
int login(Accounts* login) {
    Accounts exist;
    FILE* fp = NULL;

    /* Parameter verification */
    if (strlen(login->id) > ID_maxLen)
        return -1;
    if (strlen(login->pwd) > PWD_maxLen)
        return -1;

    fp = fopen(fDir_accounts, "rb");
    if (!fp) {
        fclose(fp);
        return -2;
    }

    while (ture) {
        /* ID does not exist */
        if (feof(fp)) {
            fclose(fp);
            return -3;
        }

        fread(&exist, sizeof(Accounts), 1, fp);

        /* ID mismatch */
        if (strcmp(login->id, exist.id) != 0)
            continue;

        /* Password mismatch */
        if (strcmp(login->pwd, exist.pwd) != 0) {
            fclose(fp);
            return -4;
        }

        break;
    }

    fclose(fp);
    return SUCCESS;
}

/**
 * Append one game history
 * @return -2: Fail to open the file which stores game histories
 *         -1: Illegal parameter
 *          0: Success
 */
int appendGameHistory(GameHistory* gameHistory) {
    FILE* fp = NULL;

    fp = fopen(fDir_gameHistory, "ab");
    if (!fp) {
        fclose(fp);
        return -2;
    }

    fwrite(gameHistory, sizeof(GameHistory), 1, fp);

    fclose(fp);
    return SUCCESS;
}

int printGameHistory(Accounts* user) {
    GameHistory buf;
    FILE* fp = NULL;

    /* Parameter verification */
    if (strlen(user->id) > ID_maxLen)
        return -1;
    if (strlen(user->pwd) > PWD_maxLen)
        return -1;

    fp = fopen(fDir_gameHistory, "rb");
    if (!fp) {
        fclose(fp);
        return -2;
    }

    /* Head Line */
    printf("%-*s | %-*s | %s\n", DATE_maxLen, "Date", 10, "Attempts", "Duration");

    /* Other Line */
    while (ture) {
        fread(&buf, sizeof(GameHistory), 1, fp);

        if (feof(fp))
            break;

        if (strcmp(user->id, buf.id) != 0)
            continue;

        printf("%-*s | %-*d | %f\n", DATE_maxLen, buf.date, 10, buf.attempt, buf.duration);
    }

    fclose(fp);
    return SUCCESS;
}

/**
 * Remove game histories of an account
 * @return -2: Fail to open the file which stores game histories
 *         -1: Illegal parameter
 *          0: Success
 */
int removeGameHistoryofUser(Accounts* user) {
    GameHistory buf;

    FILE* fp = NULL;
    FILE* fpt = NULL;

    /* Parameter verification */
    if (strlen(user->id) > ID_maxLen)
        return -1;
    if (strlen(user->pwd) > PWD_maxLen)
        return -1;

    fp = fopen(fDir_gameHistory, "rb");
    fpt = tmpfile();
    if (!fp || !fpt) {
        fclose(fp);
        fclose(fpt);
        return -2;
    }

    /* Write data into tmpfile() except those to be removed */
    while (ture) {
        fread(&buf, sizeof(GameHistory), 1, fp);

        if (feof(fp))
            break;

        /* Don't write the block when info of ID is matched */
        if (strcmp(user->id, buf.id) == 0)
            continue;

        fwrite(&buf, sizeof(GameHistory), 1, fpt);
        fflush(fpt);
    }

    /* Clear the original data of the file, then write the data in the tmpfile() into it */
    fp = fopen(fDir_gameHistory, "wb");
    rewind(fpt);
    while (ture) {
        fread(&buf, sizeof(GameHistory), 1, fpt);

        if (feof(fpt))
            break;

        fwrite(&buf, sizeof(GameHistory), 1, fp);
        fflush(fp);
    }

    fclose(fp);
    fclose(fpt);
    return SUCCESS;
}

/**
 * Remove an account
 * @return -2: Fail to open the file which stores accounts' info
 *         -1: Illegal parameter
 *          0: Success
 */
static int removeAccount(Accounts* user) {
    Accounts buf;

    FILE* fp = NULL;
    FILE* fpt = NULL;

    /* Parameter verification */
    if (strlen(user->id) > ID_maxLen)
        return -1;
    if (strlen(user->pwd) > PWD_maxLen)
        return -1;

    fp = fopen(fDir_accounts, "rb");
    fpt = tmpfile();
    if (!fp || !fpt) {
        fclose(fp);
        fclose(fpt);
        return -2;
    }

    /* Write data into tmpfile() except those to be removed */
    while (ture) {
        fread(&buf, sizeof(Accounts), 1, fp);

        if (feof(fp))
            break;

        /* Don't write the block when info of ID is matched */
        if (strcmp(user->id, buf.id) == 0)
            continue;

        fwrite(&buf, sizeof(Accounts), 1, fpt);
        fflush(fpt);
    }

    /* Clear the original data of the file, then write the data in the tmpfile() into it */
    fp = fopen(fDir_accounts, "wb");
    rewind(fpt);
    while (ture) {
        fread(&buf, sizeof(Accounts), 1, fpt);

        if (feof(fpt))
            break;

        fwrite(&buf, sizeof(Accounts), 1, fp);
        fflush(fp);
    }

    fclose(fp);
    fclose(fpt);
    return SUCCESS;
}

/**
 * Delete game histories and account
 * @return  0 Success
 */
int destroyAccount(Accounts* user) {
    removeGameHistoryofUser(user);
    removeAccount(user);

    return SUCCESS;
}

/**
 * References
 * 文件结束标识一般由上次的读写操作来设置，当然也可以手动设置。
 * 当文件内部的位置指针指向文件结束时，并不会立即设置 FILE 结构中的文件结束标识，只有再执行一次读文件操作，才会设置结束标志，此后调用 feof () 才会返回为真。
 * 文件结束标识可以由 clearerr ()、rewind ()、fseek ()、fsetpos () 和 freopen () 函数清除；如果这时位置指针未被重置，那么将在下次 I/O 操作时进行设置。
 * https://blog.csdn.net/qq_36221862/article/details/70038246
 *
 * 宏定义最大的好处是 “方便程序的修改”。使用宏定义可以用宏代替一个在程序中经常使用的常量。注意，是 “经常” 使用的。
 * 这样，当需要改变这个常量的值时，就不需要对整个程序一个一个进行修改，只需修改宏定义中的常量即可。
 * 且当常量比较长时，使用宏就可以用较短的有意义的标识符来代替它，这样编程的时候就会更方便，不容易出错。
 * 因此，宏定义的优点就是方便和易于维护。
 * http://c.biancheng.net/view/187.html
 * http://c.biancheng.net/view/446.html
 * 在 C 语言中，const 不是一个真真正正的常量，其代表的含义仅仅是只读。
 * https://www.cnblogs.com/lfri/p/11131871.html
 * const 不叫常量，叫常值变量，其值在运行期间不能改变的变量，当变量看待。
 * 用变量做数组长度，C 不允许。
 * https://zhidao.baidu.com/question/232733515.html
 *
 * Limit input string length
 * http://c.biancheng.net/cpp/html/2821.html
 * https://blog.csdn.net/FY_2018/article/details/103062058
 *
 * The C library function char *fgets(char *str, int n, FILE *stream) reads a line from the specified stream and stores it into the string pointed to by str.
 * It stops when either (n-1) characters are read, the newline character is read, or the end-of-file is reached, whichever comes first.
 * https://www.tutorialspoint.com/c_standard_library/c_function_fgets.htm
 *
 * C 语言中如何优雅地拼接多段字符串？
 * https://www.zhihu.com/question/27803894
 *
 * C 指针传递变量为什么无法修改变量值？
 * [Good] https://www.zhihu.com/question/41476387
 * https://blog.csdn.net/u012037685/article/details/52083892
 */
