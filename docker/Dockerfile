# build step
ARG L4T_VERSION=32.4.3
FROM nvcr.io/nvidia/l4t-base:r${L4T_VERSION}

ARG DEBIAN_FRONTEND=noninteractive 

RUN apt-get update -y

RUN apt-get install -y \
                tzdata \
                build-essential \
                cmake  \
                gcc \
                git \ 
                sudo \
                python3-pip
# compile OpenCV CUDA 
WORKDIR /tmp

COPY build_opencv.sh /tmp
RUN ./build_opencv.sh

RUN mkdir /opt/OpenCV-Test
WORKDIR /opt/OpenCV-Test

ADD opencv-info.py /opt/OpenCV-Test

# runtime command
CMD ["python3", "opencv-info.py"]
