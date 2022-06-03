#ifndef ASS_2_GLOBAL_H
#define ASS_2_GLOBAL_H

#define SUCCESS 0
#define ID_maxLen 20
#define PWD_maxLen 18
#define DATE_maxLen 19

enum bool {
    false = 0,
    ture = 1,
};

typedef struct {
    char id[ID_maxLen + 1];
    char pwd[PWD_maxLen + 1];
} Accounts;

typedef struct {
    char id[ID_maxLen + 1];
    char date[DATE_maxLen + 1];
    int attempt;
    double duration;

} GameHistory;

#endif
