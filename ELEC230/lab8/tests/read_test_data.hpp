#ifndef LAB8_READ_TEST_DATA_HPP
#define LAB8_READ_TEST_DATA_HPP

#include <fstream>
#include <array>
#include <tuple>

auto
read_list_from_the_file() {
    std::ifstream file("tests/Random.txt");  // FIXME: The data file has to be manually copied to the debug folder, otherwise the binaries can find it.

    if (!file.is_open())
        throw std::ios_base::failure("Cannot open Random.txt.");

    using std::string_literals::operator""s;
    using std::tuple;
    std::array<u_int16_t, 200000> list {};
    for (auto [line, it_list] = tuple{""s, list.begin()}; getline(file, line); ++it_list)
        *it_list = std::stoul(line);
// Compare to the above, this will not cause index exceeds array bound if the list size is smaller than 200000.
//    for (auto [line, it_list] = tuple{""s, list.begin()}; it_list != list.end(); ++it_list) {
//        getline(file, line);
//        *it_list = std::stoul(line);
//    }

    return list;
}

#endif //LAB8_READ_TEST_DATA_HPP
