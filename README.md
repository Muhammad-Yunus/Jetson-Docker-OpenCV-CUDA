# Jetson Nano Docker OpenCV CUDA
- Clone repo :
```
cd ~
mkdir -p Github
cd Github
git clone 
cd ~
```
- Build image,
```
docker build --pull --rm -f "Github/Jetson-Nano-Docker-OpenCV-CUDA/Dockerfile" -t jetson-opencv-cuda:latest "Github/Jetson-Nano-Docker-OpenCV-CUDA/"
```

- Run Image using NVIDIA Container Runtime,
```
sudo docker run --rm --net=host --runtime nvidia  jetson-opencv-cuda:latest
```