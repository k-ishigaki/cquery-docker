FROM ubuntu AS builder

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libncurses-dev \
    zlib1g-dev

RUN git clone https://github.com/cquery-project/cquery.git --recursive \
    && cd cquery \
    && git submodule update --init \
    && mkdir build && cd build \
    && cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=release -DCMAKE_EXPORT_COMPILE_COMMANDS=YES \
    && cmake --build . \
    && cmake --build . --target install

FROM ubuntu
LABEL maintainer "Kazuki Ishigaki <k-ishigaki@frontier.hokudai.ac.jp>"

COPY --from=builder /cquery/build/clang+llvm-7.0.0-x86_64-linux-gnu-ubuntu-14.04/ /cquery/build/clang+llvm-7.0.0-x86_64-linux-gnu-ubuntu-14.04/
COPY --from=builder /cquery/build/cquery /cquery/build/cquery

ENV PATH $PATH:/cquery/build
