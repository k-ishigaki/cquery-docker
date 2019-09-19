# cquery-docker
`cquery` executable via Docker.

cquery is C++ Language Server: https://github.com/cquery-project/cquery

## Install

1. Build cquery-docker image
```sh
 $ git clone https://github.com/k-ishigaki/cquery-docker.git
 $ cd cquery-docker
 $ docker build .
```
2. Prepare cquery script file
```sh
 $ echo 'docker exec -i --workdir $(pwd) cquery_container cquery $@' > ~/.local/bin/cquery
 $ sudo chmod +x ~/.local/bin/cquery
```
3. Prepare $PATH  
Example of Ubuntu
```sh
 $ echo 'export PATH=$PATH:$HOME/.local/bin' >> ~/.profile
 $ source ~/.profile
```

## Usage

1. Run cquery container in background (Once after reboot)  
note: [host_dir] and [container_mount_dir] must be same.
```sh
 $ docker run -it -d \
   --name cquery_container \
   --mount type=bind,source=[host_dir],target=[container_mount_dir] \
   [image]
```
2. Execute cquery!
```sh
 $ cquery
```
