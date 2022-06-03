#include <wander_bot/msg_factory.hxx>

geometry_msgs::Twist 
geometry_msgs_Twist(geometry_msgs::Vector3 linear, geometry_msgs::Vector3 angular) {
    geometry_msgs::Twist msg;
    msg.linear = linear;
    msg.angular = angular;
    return msg;    
}

geometry_msgs::Vector3
geometry_msgs_Vector3(double x, double y, double z) {
    geometry_msgs::Vector3 msg;
    msg.x = x;
    msg.y = y;
    msg.z = z;
    return msg;
}
