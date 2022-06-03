int main()
    try {
        // …
    } catch (out_of_range&) {  // out_of_range exceptions
        cerr << "oops – some vector index out of range" << endl;
    } catch (…) {  // all other exceptions
        cerr << "oops – some exception" << endl;
}
