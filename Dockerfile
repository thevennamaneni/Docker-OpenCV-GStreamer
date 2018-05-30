FROM ubuntu:16.04
MAINTAINER Junjue Wang <junjuew@cs.cmu.edu>

# Install gstreamer and opencv dependencies
RUN \ 
    apt-get update && apt-get upgrade -y && \
    apt-get install -y libgstreamer1.0-0 \
            gstreamer1.0-plugins-base \
            gstreamer1.0-plugins-good \
            gstreamer1.0-plugins-bad \
            gstreamer1.0-plugins-ugly \
            gstreamer1.0-libav \
            gstreamer1.0-doc \
            gstreamer1.0-tools \
            libgstreamer1.0-dev \
            libgstreamer-plugins-base1.0-dev && \

    apt-get install -y \
        wget \
        unzip \
        libtbb2 \
        libtbb-dev && \
    apt-get install -y \
        build-essential \
        cmake \
        git \
        pkg-config \
        libjpeg8-dev \
        libtiff4-dev \
        libjasper-dev \
        libpng12-dev \
        libgtk2.0-dev \
        libavcodec-dev \
        libavformat-dev \
        libswscale-dev \
        libv4l-dev \
        libatlas-base-dev \
        gfortran \
        libhdf5-dev \
        python2.7 \
        python2.7-dev && \

    wget https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    pip install numpy && \

    apt-get autoclean && apt-get clean && \

    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Download OpenCV 3.2.0 and install
RUN \
    cd ~ && \
    wget https://github.com/Itseez/opencv/archive/3.2.0.zip && \
    unzip 3.2.0.zip && \
    mv ~/opencv-3.2.0/ ~/opencv/ && \
    rm -rf ~/3.2.0.zip && \

    cd /root/opencv && \
    mkdir build && \
    cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D INSTALL_C_EXAMPLES=OFF \
        -D INSTALL_PYTHON_EXAMPLES=ON \
        -D BUILD_EXAMPLES=ON .. && \

    cd ~/opencv/build && \
    make -j $(nproc) && \
    make install && \
    ldconfig
