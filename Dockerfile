FROM ubuntu
MAINTAINER k-ishigaki <k-ishigaki@frontier.hokudai.ac.jp>

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
	libncurses-dev \
	zlib1g-dev \
	&& apt-get clean

RUN git clone https://github.com/cquery-project/cquery.git --recursive \
    && cd cquery \
    && git submodule update --init \
    && mkdir build && cd build \
    && cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=release -DCMAKE_EXPORT_COMPILE_COMMANDS=YES \
    && cmake --build . \
    && cmake --build . --target install

ENTRYPOINT ["/cquery/build/cquery"]
