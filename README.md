# Jetson Nano Docker OpenCV CUDA
- Clone repo :
```
cd ~
mkdir -p Github
cd Github
git clone https://github.com/Muhammad-Yunus/Jetson-Nano-Docker-OpenCV-CUDA.git
cd ~
```
- Build image,
```
docker build --pull --rm -f "Github/Jetson-Nano-Docker-OpenCV-CUDA/Dockerfile" -t jetson-opencv-cuda:latest "Github/Jetson-Nano-Docker-OpenCV-CUDA/"
```
- **Or**, Pull image from Docker Hub :
```
docker pull yunusdev/jetson-opencv-cuda
```
- Run Image using NVIDIA Container Runtime,
```
sudo docker run --rm --net=host --runtime nvidia  jetson-opencv-cuda:latest
```