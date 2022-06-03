#include <vector>
#include <iostream>

int main() {
    std::vector<int> v(10);

    for (int i = 0; i < v.size(); ++i) {
        v[i] = i;
    }
    // out of range
    for (int i = 0; i <= 10; ++i) {
        std::cout << "v[" << i << "] == " << v[i] << std::endl;
    }

    return 0;
}
