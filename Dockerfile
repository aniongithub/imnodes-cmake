FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

# nvidia docker runtime env
ENV NVIDIA_VISIBLE_DEVICES \
        ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
        ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics,compat32,utility

RUN apt-get update &&\
    apt-get install -y \
        build-essential \
        cmake \
        gdb \
        git \
        libsdl2-dev \
        xorg-dev \
        apt-utils \
        dialog \
        x11-apps

# Install imgui-cmake so cmake can find the imgui components we need
WORKDIR /usr/local/src/imgui-cmake
RUN cd /usr/local/src/ &&\
    git clone https://github.com/aniongithub/imgui-cmake.git &&\
    cd /usr/local/src/imgui-cmake &&\
    git checkout update-imgui &&\
    git submodule update --init --recursive &&\
    mkdir build && cd build &&\
    cmake -DIMGUI_GLLOADER=gl3w -DIMGUI_GLFW_IMPL=OFF -DBUILD_GLFW_OPENGL3_SAMPLE=OFF -DBUILD_SDL2_OPENGL3_SAMPLE=OFF .. &&\
    make && make install