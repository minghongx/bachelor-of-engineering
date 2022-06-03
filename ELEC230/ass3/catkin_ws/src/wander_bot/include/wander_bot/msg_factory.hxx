/*
直接在 funtion call operator, (), 中初始化数据结构对 code readability 十分有益.

尝试使用 C++20 designated initializer (aggregate initialization) 在 .publish() 中初始化一个 ROS1 message
<ros::Publisher>.publish(geometry_msgs::Twist {.linear = velocity});
Clangd-12 提示没有匹配的构造器.

ROS1 message 本质是带有构造器的 struct. 带有构造器的 struct 是 non-aggregate.
https://stackoverflow.com/questions/64770166/why-i-can-not-use-designated-initalizers-with-structs-that-are-not-aggregates
这篇回答说 cannot use designated initalizers with structs that are not aggregates,
所以 designated initializer 无法实现在 funtion call operator 中初始化 ROS1 message.
https://en.cppreference.com/w/cpp/language/aggregate_initialization

roscpp: message constructors with values for fields (ros ticket #2723)
https://github.com/ros/ros_comm/issues/148#issuecomment-334227731
中建议用 factory function.
这份源文件采用这个方法, 实现在 function call operator 中初始化 ROS1 message 的功能.

BTW, 
rospy 支持简洁的初始化 (实际上是实例化, 因为 Python 中一切皆对象)
http://wiki.ros.org/rospy/Overview/Messages
designated initializer 还可以嵌套
https://www.cppstories.com/2021/designated-init-cpp20/#examples
*/
#pragma once

#include <geometry_msgs/Vector3.h>
#include <geometry_msgs/Twist.h>

geometry_msgs::Twist 
geometry_msgs_Twist(
    geometry_msgs::Vector3 linear = geometry_msgs::Vector3(), 
    geometry_msgs::Vector3 angular = geometry_msgs::Vector3());

geometry_msgs::Vector3
geometry_msgs_Vector3(
    double x = 0., 
    double y = 0., 
    double z = 0.);