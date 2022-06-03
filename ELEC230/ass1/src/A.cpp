#include <iostream>
#include <vector>
#include <cmath>

struct Point2d {
    double x {0};
    double y {0};
};

struct Vector2d {
    double x {0};
    double y {0};
};

class Polygon {
public:
    Polygon() = delete;  // the class default constructor is not allowed to use

    Polygon(std::string name, unsigned int number_of_vertices, double circumradius)  // todo: specify the centroid
        : name {std::move(name)}
        , r {circumradius > 0 ? circumradius : throw std::invalid_argument("must be positive")}
        // monogon and digon are not accepted
        , N {number_of_vertices >= 3 ? number_of_vertices : throw std::invalid_argument("in this program a regular polygon should has at least three vertices")}
    {
        double angle_in_radian = 2 * M_PI / number_of_vertices;  // fixme: find a better name that can describe what angle of polygon it represents

        // To ensure the base lies horizontal, the right point of the baseline is calculated first
        vertex_x_coordinates.push_back(cos(angle_in_radian / 2) * 0 - sin(angle_in_radian / 2) * -r);
        vertex_y_coordinates.push_back(sin(angle_in_radian / 2) * 0 + cos(angle_in_radian / 2) * -r);

        // Deduce other points based on the above point
        for (int i = 2; i <= number_of_vertices; ++i) {
            double last_x = vertex_x_coordinates.back();
            double last_y = vertex_y_coordinates.back();

            vertex_x_coordinates.push_back(cos(angle_in_radian) * last_x - sin(angle_in_radian) * last_y);
            vertex_y_coordinates.push_back(sin(angle_in_radian) * last_x + cos(angle_in_radian) * last_y);
        }
    }

    Polygon& translate(Vector2d translation_vector) {

        // print certain trivial info, which is required for this assmt, for test purpose
        std::cout << "Coordinates before translation:" << '\n';
        print_name(), std::cout << ": ", print_vertex_coordinates();

        // translate each point by adding the given translation vector
        auto it_x = vertex_x_coordinates.begin();
        auto it_y = vertex_y_coordinates.begin();
        for (; it_x != vertex_x_coordinates.end() && it_y != vertex_y_coordinates.end(); ++it_x, ++it_y) {
            *it_x += translation_vector.x;
            *it_y += translation_vector.y;
        }

        // print certain trivial info, which is required for this assmt, for test purpose
        std::cout << "Coordinates after translation by " << '(' << translation_vector.x << ", " << translation_vector.y << ')' << ":" << '\n';
        print_name(), std::cout << ": ", print_vertex_coordinates();

        return *this;
    }

    Polygon& rotate(Point2d centre_of_rotation, double angle_in_radian) {

        // print certain trivial info, which is required for this assmt, for test purpose
        std::cout << "Coordinates before rotation:" << '\n';
        print_name(), std::cout << ": ", print_vertex_coordinates();

        // rotate each point around the given centre of rotation for the given radian via a rotation matrix
        auto it_x = vertex_x_coordinates.begin();
        auto it_y = vertex_y_coordinates.begin();
        for (; it_x != vertex_x_coordinates.end() && it_y != vertex_y_coordinates.end(); ++it_x, ++it_y) {
            double x_copy = *it_x;
            double y_copy = *it_y;

            *it_x = cos(angle_in_radian) * (x_copy - centre_of_rotation.x) - sin(angle_in_radian) * (y_copy - centre_of_rotation.y) + centre_of_rotation.x;
            *it_y = sin(angle_in_radian) * (x_copy - centre_of_rotation.x) + cos(angle_in_radian) * (y_copy - centre_of_rotation.y) + centre_of_rotation.y;
        }

        // print certain trivial info, which is required for this assmt, for test purpose
        std::cout << "Coordinates after rotation by radian " << angle_in_radian << " (positive rotation is anticlockwise) around " << '(' << centre_of_rotation.x << ", " << centre_of_rotation.y << ')' << ":" << '\n';
        print_name(), std::cout << ": ", print_vertex_coordinates();

        return *this;
    }

private:
    std::string name;
    double r;  // radius
    unsigned int N;  // number of vertices
    // fixme: ignore the assmt requirement, I would use a vector, as the sequence container, whose value type is a custom struct called Point2d
    std::vector<double> vertex_x_coordinates;
    std::vector<double> vertex_y_coordinates;

    // custom print functions required for this assmt
    void print_name() const {
        std::cout << name;
    }
    [[maybe_unused]] void print_number_of_vertices() const {
        std::cout << N;
    }
    void print_vertex_coordinates() const {
        auto it_x = vertex_x_coordinates.begin();
        auto it_y = vertex_y_coordinates.begin();
        for (; it_x != vertex_x_coordinates.end() && it_y != vertex_y_coordinates.end(); ++it_x, ++it_y) {
            std::cout << '(' << *it_x << ", " << *it_y << ") ";
        }
        std::cout << '\n';
    }
};


int main() {

//unit/integration test
    std::cout << '\n';
    Polygon triangle {"Triangle", 3, 1};
    triangle.rotate({0, 1}, M_PI).translate({0, -1});  // chain methods

    std::cout << '\n';
    Polygon square {"Square", 4, 2.71828};
    square.rotate({0, 1}, M_PI).translate({20.3, 30.4});

    std::cout << '\n';
    Polygon XCIX {"XCIX-gon", 99, 3.14159};
    XCIX.rotate({-40.1, -50.2}, M_PI/3).translate({20.3, 30.4});
//unit/integration test end

    return 0;
}
