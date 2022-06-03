void f(int a, int& r, const int& cr) { ++a; ++r; ++cr; }  // error: cr is const
void g(int a, int& r, const int& cr) { ++a; ++r; int x = cr; ++x; }  //ok

int main() {
    int x = 0;
    int y = 0;
    int z = 0;
    g(x, y, z);
    g(1, 2, 3);  // error: reference argument r needs a variable to refer to
    g(1, y ,3);  // ok: since cr is const, we can pass "a temporary"
    // const references are very useful for passing large objects
}
