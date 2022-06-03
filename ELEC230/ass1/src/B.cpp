#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>
#include <functional>
#include <memory>

struct Point3d {
    double x {0};
    double y {0};
    double z {0};
};

struct Vector3d {
    double x {0};
    double y {0};
    double z {0};
};

class Polygon3d {  // A class is abstract if it has at least one pure virtual function
public:
    Polygon3d() = delete;  // the class default constructor is not allowed to use

    Polygon3d(std::string name, std::initializer_list<Point3d> const& vertices)
        : name {std::move(name)}
        // monogon and digon are not accepted
        , N {vertices.size() >= 3 ? vertices.size() : throw std::invalid_argument("in this program a polygon should has at least three vertices")}
    {
        /* Mapping one structure to another
         * std::copy is for plain copy without modifying the elements; std::transform allows to apply a transformation to each element.
         * std::bind or lambda expression can be used for transforming
         */
//        std::transform(vertices.begin(), vertices.end(), std::back_inserter(vertex_x_coordinates), std::bind(&Point3d::x, std::placeholders::_1));
        std::transform(vertices.begin(), vertices.end(), std::back_inserter(vertex_x_coordinates), [](Point3d const& point3D){return point3D.x;});
        std::transform(vertices.begin(), vertices.end(), std::back_inserter(vertex_y_coordinates), [](Point3d const& point3D){return point3D.y;});
        std::transform(vertices.begin(), vertices.end(), std::back_inserter(vertex_z_coordinates), [](Point3d const& point3D){return point3D.z;});
    }

    void print_name() const {
        std::cout << name;
    }
    [[maybe_unused]] void print_number_of_vertices() const {
        std::cout << N;
    }
    void print_vertex_coordinates() const {
        auto it_x = vertex_x_coordinates.begin();
        auto it_y = vertex_y_coordinates.begin();
        auto it_z = vertex_z_coordinates.begin();
        for (; it_x != vertex_x_coordinates.end() && it_y != vertex_y_coordinates.end() && it_z != vertex_z_coordinates.end(); ++it_x, ++it_y, ++it_z) {
            std::cout << '(' << *it_x << ", " << *it_y << ", " << *it_z << ") ";
        }
    }

    virtual Polygon3d& translate(Vector3d translation_vector) = 0;

    virtual Polygon3d& rotate(Point3d centre_of_rotation, double angle_in_radian) = 0;

protected:
    std::string name;
    unsigned long N;  // number of vertices
    // fixme: ignore the assmt requirement, I would use a vector, as the sequence container, whose value type is a custom struct called Point3d
    std::vector<double> vertex_x_coordinates;
    std::vector<double> vertex_y_coordinates;
    std::vector<double> vertex_z_coordinates;
};

class Polygon_xy : public Polygon3d {
public:
    using Polygon3d::Polygon3d;

    Polygon3d& translate(Vector3d translation_vector) override {

        auto it_x = vertex_x_coordinates.begin();
        auto it_y = vertex_y_coordinates.begin();
        for (; it_x != vertex_x_coordinates.end() && it_y != vertex_y_coordinates.end(); ++it_x, ++it_y) {
            *it_x += translation_vector.x;
            *it_y += translation_vector.y;
        }

        return *this;
    }

    Polygon3d& rotate(Point3d centre_of_rotation, double angle_in_radian) override {

        auto it_x = vertex_x_coordinates.begin();
        auto it_y = vertex_y_coordinates.begin();
        for (; it_x != vertex_x_coordinates.end() && it_y != vertex_y_coordinates.end(); ++it_x, ++it_y) {
            double x_copy = *it_x;
            double y_copy = *it_y;

            *it_x = cos(angle_in_radian) * (x_copy - centre_of_rotation.x) - sin(angle_in_radian) * (y_copy - centre_of_rotation.y) + centre_of_rotation.x;
            *it_y = sin(angle_in_radian) * (x_copy - centre_of_rotation.x) + cos(angle_in_radian) * (y_copy - centre_of_rotation.y) + centre_of_rotation.y;
        }

        return *this;
    }
};

class Polygon_xz : public Polygon3d {
public:
    using Polygon3d::Polygon3d;

    Polygon3d& translate(Vector3d translation_vector) override {

        auto it_x = vertex_x_coordinates.begin();
        auto it_z = vertex_z_coordinates.begin();
        for (; it_x != vertex_x_coordinates.end() && it_z != vertex_z_coordinates.end(); ++it_x, ++it_z) {
            *it_x += translation_vector.x;
            *it_z += translation_vector.z;
        }

        return *this;
    }

    Polygon3d& rotate(Point3d centre_of_rotation, double angle_in_radian) override {

        auto it_x = vertex_x_coordinates.begin();
        auto it_z = vertex_z_coordinates.begin();
        for (; it_x != vertex_x_coordinates.end() && it_z != vertex_z_coordinates.end(); ++it_x, ++it_z) {
            double x_copy = *it_x;
            double z_copy = *it_z;

            *it_x = cos(angle_in_radian) * (x_copy - centre_of_rotation.x) - sin(angle_in_radian) * (z_copy - centre_of_rotation.z) + centre_of_rotation.x;
            *it_z = sin(angle_in_radian) * (x_copy - centre_of_rotation.x) + cos(angle_in_radian) * (z_copy - centre_of_rotation.z) + centre_of_rotation.z;
        }

        return *this;
    }
};

class Polygon_yz : public Polygon3d {
public:
    using Polygon3d::Polygon3d;

    Polygon3d& translate(Vector3d translation_vector) override {

        auto it_y = vertex_y_coordinates.begin();
        auto it_z = vertex_z_coordinates.begin();
        for (; it_y != vertex_y_coordinates.end() && it_z != vertex_z_coordinates.end(); ++it_y, ++it_z) {
            *it_y += translation_vector.y;
            *it_z += translation_vector.z;
        }

        return *this;
    }

    Polygon3d& rotate(Point3d centre_of_rotation, double angle_in_radian) override {

        auto it_y = vertex_y_coordinates.begin();
        auto it_z = vertex_z_coordinates.begin();
        for (; it_y != vertex_y_coordinates.end() && it_z != vertex_z_coordinates.end(); ++it_y, ++it_z) {
            double y_copy = *it_y;
            double z_copy = *it_z;

            *it_y = cos(angle_in_radian) * (y_copy - centre_of_rotation.y) - sin(angle_in_radian) * (z_copy - centre_of_rotation.z) + centre_of_rotation.y;
            *it_z = sin(angle_in_radian) * (y_copy - centre_of_rotation.y) + cos(angle_in_radian) * (z_copy - centre_of_rotation.z) + centre_of_rotation.z;
        }

        return *this;
    }
};

int main() {

//unit/integration test
    Polygon_xy xy {"XY",
                   {
                       {1,1,0},
                       {1,0,1},
                       {0,1,1}
                   }
    };
    Polygon_xz xz {"XZ",
                   {
                       {1,1,0},
                       {1,0,1},
                       {0,1,1}
                   }
    };
    Polygon_yz yz {"YZ",
                   {
                       {1,1,0},
                       {1,0,1},
                       {0,1,1}
                   }
    };

    // batch-translation
    for (auto polygon3d : std::initializer_list<Polygon3d*>{&xy, &xz, &yz}) {

        std::cout << "Coordinates before translation in its own plane:" << '\n';
        polygon3d->print_name(), std::cout << ": ", polygon3d->print_vertex_coordinates(), std::cout << '\n';

        // test data
        Vector3d translation_vector {2.1, 2.2, 2.3};

        polygon3d->translate(translation_vector);

        std::cout << "Coordinates after translation by " << '(' << translation_vector.x << ", " << translation_vector.y << ", " << translation_vector.z << ')' << " in its own plane:" << '\n';
        polygon3d->print_name(), std::cout << ": ", polygon3d->print_vertex_coordinates(), std::cout << '\n';
    }

    // batch-rotation
    for (auto polygon3d : std::initializer_list<Polygon3d*>{&xy, &xz, &yz}) {

        std::cout << "Coordinates before rotation in its own plane:" << '\n';
        polygon3d->print_name(), std::cout << ": ", polygon3d->print_vertex_coordinates(), std::cout << '\n';

        // test data
        Point3d centre_of_rotation {1,1,1};
        double angle_in_radian = M_PI;

        polygon3d->rotate(centre_of_rotation, angle_in_radian);

        std::cout << "Coordinates after rotation by " << angle_in_radian << " (positive rotation is anticlockwise) around " << '(' << centre_of_rotation.x << ", " << centre_of_rotation.y << ", " << centre_of_rotation.z << ')' << " in its own plane:" << '\n';
        polygon3d->print_name(), std::cout << ": ", polygon3d->print_vertex_coordinates(), std::cout << '\n';
    }

//std::array<std::unique_ptr<Polygon3d>, 3> polygon3d = {
//        std::make_unique<Polygon_xy>("XY", std::array<Point3d, 3>{{{1,2,3}, {4,5,6}, {7,8,9}}}), fixme
//}

//unit/integration test end

    return 0;
}
