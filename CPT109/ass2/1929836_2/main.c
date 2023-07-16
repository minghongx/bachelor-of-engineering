#include "main.h"

int main() {
    setbuf(stdout, NULL);

    Accounts* account;

    while (ture) {
        /* Login Menu */
        account = Menu_login();
        if (!account)
            break;
        
        /* Main Menu */
        if (Menu_main(account) == -1)
            break;
    }

    return 0;
}
