FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /slotcontrast

# Install Python 3.8 and other dependencies
# We update the apt package list, install Python 3.8, pip, compilers and other necessary tools.
# After installing, we clean up the apt cache and remove unnecessary lists to save space.
RUN apt-get update && \
    apt-get install -y \
    python3.10 python3.10-dev python3-pip \
    gcc g++ swig git \
    libgl1-mesa-glx libglib2.0-0 \
    libegl1 libgles2 libgl1 libglvnd0 libglx0 \
    libosmesa6 libxrender1 libxext6 libsm6 \
    mesa-utils libopengl0 \
    libgl1-mesa-dev libglu1-mesa libglu1-mesa-dev \
    libosmesa6-dev freeglut3-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a symbolic link for Python and pip
# This makes it easy to call python and pip from any location in the container.
RUN ln -s /usr/bin/python3.10 /usr/local/bin/python && \
    ln -s /usr/bin/pip3 /usr/local/bin/pip

# Update pip and setuptools to the latest version
# This step ensures that we have the latest tools for installing Python packages.
RUN python -m pip install --upgrade pip setuptools