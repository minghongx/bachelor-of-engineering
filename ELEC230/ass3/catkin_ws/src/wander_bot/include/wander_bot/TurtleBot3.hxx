#pragma once

#include <ros/ros.h>
#include <sensor_msgs/LaserScan.h>
#include <geometry_msgs/Twist.h>
#include <geometry_msgs/Vector3.h>
#include <algorithm>
#include <wander_bot/msg_factory.hxx>

class TurtleBot3 {
public:
    TurtleBot3();
protected:
    ros::NodeHandle node_handle_;
    ros::Publisher cmd_vel_;
    ros::Subscriber laser_scan_;  // TODO: 能不能一个 subscriber sub 多个 callbacks? 不能的话命名和 callback 挂钩比较好.

    /*
    https://answers.ros.org/question/172669/independently-change-angular-and-linear-velocities-cmd_vel/
    TutleBot3's controller does not honor "ignore NaN" convention; 设置 linear.x 为 NAN 会让 TurtleBot3 后退。
    所以不能简单地单独控制线速度与角速度。
    */
    void 
    circumvent(const sensor_msgs::LaserScan::Ptr&);  // TODO: 将控制移动的逻辑从 circumvent 这个识别逻辑中分离出来。
};