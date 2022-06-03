### Setup a X server on the host
```shell
> scoop install vcxsrv
> xlaunch
```
- Default display number is `0.0`.
- Disable access control.

### Setup a ROS1 container
```shell
> docker pull ros:noetic-robot
> docker run --name ros1_elec230 -e DISPLAY=host.docker.internal:0.0 -it ros:noetic-robot  # 0.0 is the port of the X server
> docker exec -it ros1_elec230 <shell>
```

### Switch to fish shell
```shell
> apt-add-repository ppa:fish-shell/release-3  # to get the latest version
> apt install fish
> cat /etc/shells  # Find the absolute path of fish
> chsh path/to/fish  # usually is /usr/bin/fish
```
- Install a prompt such as *starship*.
- Install a plugin mngr such as *fisher*.
- Use the plugin mngr to install bass.

### Switch to Clang-14
```shell
> wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
> apt-add-repository "deb http://apt.llvm.org/focal/ llvm-toolchain-focal-14 main"
> apt install clang-14 lldb-14 lld-14 clangd-14
```