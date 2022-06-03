#include <ros/ros.h>
#include <wander_bot/TurtleBot3.hxx>

int main(int argc, char **argv) {
ros::init(argc, argv, "ass3");

TurtleBot3 burger;

ros::Rate rate(10);
while (ros::ok()) {
    ros::spinOnce();
rate.sleep();}

return 0;}