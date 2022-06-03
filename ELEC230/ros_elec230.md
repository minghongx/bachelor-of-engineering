## Getting started

Get Docker completion:
- https://docs.docker.com/compose/completion/
- https://www.powershellgallery.com/packages/DockerCompletion/1.2010.1.211002

On host, start VcXsrv and set its diplay number to 0.0, then
```
$ docker run --name ros1_elec230 -e DISPLAY=host.docker.internal:0.0 -it ros:noetic-robot
```
**ref:**
- http://wiki.ros.org/docker/Tutorials/Docker
- https://www.cnblogs.com/larva-zhh/p/10531824.html
- https://github.com/mviereck/x11docker
- https://docs.docker.com/engine/reference/run/#clean-up---rm

## [Turtlesim](http://wiki.ros.org/turtlesim)
Open the second [windows terminal pane](https://docs.microsoft.com/en-us/windows/terminal/panes), install *turtlesim*
```
$ apt install ros-$(rosversion -d)-turtlesim
```
, and run the *turtlesim*
```
$ source ros_entrypoint.sh
$ rosrun turtlesim turtlesim_node
```
Turtlesim GUI will be displayed by the VcXsrv on host. ?[source ros_entrypoint.sh](http://wiki.ros.org/rosbash)

Open the third windows terminal pane, and do
```
$ source ros_entrypoint.sh
$ rosrun turtlesim turtle_teleop_key
```
to get keyarrow control of the *turtlesim*.

Right click the top bar of X window of *turtlesim* and set the window always on top. Finally, focus on the third pane so as to use keyarrows to control the turtle.

## rqt_graph

rqt_graph 是 rqt 的一个 plugin
```
$ apt install ros-noetic-rqt 
$ apt install ros-noetic-rqt-common-plugins
```

```
$ rosrun rqt_graph rqt_graph
```

## Control Turtlebot3

Install Gazebo
```
$ apt install curl
$ curl -sSL http://get.gazebosim.org | sh
```

Install Turtlebot3
```
$ apt install ros-noetic-turtlebot3-gazebo
```

Get package turtlebot3_teleop for keyboard contorl
```
$ apt install ros-noetic-turtlebot3
```

Allow interface with Gazebo, otherwise the package turtlebot3_teleop cannot work
```
$ apt install ros-noetic-gazebo-ros-pkgs ros-noetic-gazebo-ros-control
```

Launch sim env
```
$ export TURTLEBOT3_MODEL=burger
$ roslaunch turtlebot3_gazebo turtlebot3_world.launch
```

Start keyboard control
```
$ export TURTLEBOT3_MODEL=burger
$ roslaunch turtlebot3_teleop turtlebot3_teleop_key.launch
```

## Improving the shell

Install fish
```
$ apt install fish
```

Install [starship](https://github.com/starship/starship) prompt
```
$ sh -c "$(curl -fsSL https://starship.rs/install.sh)"
```

Enable starship prompt in fish

Install fish plugin mngnr [fisher](https://github.com/jorgebucaran/fisher)

Install [bass](https://github.com/edc/bass) which gives fish ability to use bash scripts
```
$ fisher install edc/bass
```

Source ROS in fish automatically
```
~/.config/fish/conf.d/rossetup.fish
-----------------------------------
bass source /opt/ros/$ROS_DISTRO/setup.bash
```

Enable fish support of [rosbash](http://wiki.ros.org/rosbash)

## Mapping

Install gmapping
```
$ apt install ros-noetic-slam-gmapping
```

Install rviz
```
$ apt install ros-noetic-rviz
```

Install map_server
```
$ apt install ros-noetic-map-server
```

## Clangd Language Server for VSCode

安装 C/C++ complier, Clang
```
$ apt install clang-12 --install-suggests
```

安装 C/C++ language server, Clangd
```
$ apt install clangd-12
```

VSCode 中安装 Clangd extension

局部设置 VSCode 使 Clangd extension 能找到 clangd-12
```json
.vscode/settings.json
---------------------
{
    "clangd.path": "/usr/bin/clangd-12",
}
```

或者链接 clangd extension 默认搜索的 `/usr/bin/clang` 到 `/usr/bin/clangd-12`
> 安装后，默认的命令是 clang-12 和 clang++-12，需要使用 update-alternatives 来设置成 clang 和 clang++
```
$ update-alternatives --install /usr/bin/clang clang /usr/bin/clang-12 1 --slave /usr/bin/clang++ clang++ /usr/bin/clang++-12
```

通过设置 fallback flags 让 Clangd 能搜索 ROS1 Noetic distro 与 Catkin workspace 的 include path (ros/ros.h 在 ROS 的 include path 下)
```json
.vscode/settings.json
---------------------
{
    "clangd.path": "/usr/bin/clangd-12",
    "clangd.fallbackFlags": [
        "--include-directory=/opt/ros/noetic/include",
        "--include-directory=/usr/include",
        "--include-directory=/root/catkin_ws/src/hello_world/include",
    ],
}
```
