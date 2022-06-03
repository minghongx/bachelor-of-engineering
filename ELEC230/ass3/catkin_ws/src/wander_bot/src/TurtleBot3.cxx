#include <wander_bot/TurtleBot3.hxx>

TurtleBot3::
TurtleBot3() {
    cmd_vel_ = node_handle_.advertise<geometry_msgs::Twist>("cmd_vel", 1);
    laser_scan_ = node_handle_.subscribe("scan", 1, &TurtleBot3::circumvent, this);
}

void TurtleBot3::
circumvent(const sensor_msgs::LaserScan::Ptr& laser_scan) {

    // Rotate the array for laser scan data such that right is 0 degree and left is 180 degrees.
    std::rotate(laser_scan->ranges.rbegin(), laser_scan->ranges.rbegin() + 90, laser_scan->ranges.rend());
    // Get iterator of minimum distance between 60 and 120 degrees.
    auto min_60_120 = std::min_element(laser_scan->ranges.cbegin() + 60, 
                                       laser_scan->ranges.cbegin() + 120);

    // If the minimum distance between 60 and 120 degrees is greater than 0.3, keep moving forward.
    if (*min_60_120 > 0.3) {
        // move forward
        cmd_vel_.publish(
            geometry_msgs_Twist(
                geometry_msgs_Vector3(0.3),
                geometry_msgs_Vector3()));
        return;
    } // The following assume the minimum distance between 60 and 120 degrees is less than or equal to 0.3

    // FIXME: Stuck robot problem; need a recovery behaviour.

    // Get the degree of minimum distance. Note that the degree equals index
    auto degree = std::distance(laser_scan->ranges.cbegin(), min_60_120);
    // 0-90 deg: front-right
    if (0 <= degree && degree < 90) {
        // turn left in place
        cmd_vel_.publish(
            geometry_msgs_Twist(
                geometry_msgs_Vector3(), 
                geometry_msgs_Vector3(0, 0, 1)));
    // 90-180 deg: front-left
    } else if (90 <= degree && degree < 180) {  // FIXME: Assuming turning right when min straight ahead (at 90 degrees).
        // turn right in place
        cmd_vel_.publish(
            geometry_msgs_Twist(
                geometry_msgs_Vector3(), 
                geometry_msgs_Vector3(0, 0, -1)));
    }
}