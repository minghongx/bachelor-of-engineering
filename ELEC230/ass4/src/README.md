Generate auxiliary files
```shell
> cmake . -Bbuild
```

Compile
```shell
> cd build
> make <target>
```

Move the targets to the dir contains inputs.

Direct the display to the X server on the host since I use WSL
```shell
> export DISPLAY=$(ip route|awk '/^default/{print $3}'):0.0
```
