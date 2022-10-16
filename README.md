# Jetson Docker OpenCV CUDA
---
- Added support Jetpact 4.6
- Build tested on **Jetson Nano** & **Jetson Xavier**
---
- Set `nvidia` as default Docker runtime,
```
sudo nano /etc/docker/daemon.json
```
- Change `daemon.json` to look like this,
```
{
    "runtimes": {
        "nvidia": {
            "path": "/usr/bin/nvidia-container-runtime",
            "runtimeArgs": []
         } 
    },
    "default-runtime": "nvidia" 
}
```
- Restart Docker Service,
```
sudo systemctl restart docker
``` 
<br><br>
- Clone repo :
```
cd ~
mkdir -p Github
cd Github
git clone https://github.com/Muhammad-Yunus/Jetson-Docker-OpenCV-CUDA.git
cd ~
```
- Build image,
```
docker build --pull --rm -f "Github/Jetson-Docker-OpenCV-CUDA/Dockerfile" -t jetson-opencv-cuda:latest "Github/Jetson-Docker-OpenCV-CUDA/"
```
- Run Image using NVIDIA Container Runtime,
```
sudo docker run --rm --net=host --runtime nvidia  jetson-opencv-cuda:latest
```
<br><br>
- **Or**, Pull image from Docker Hub :
```
docker pull yunusdev/jetson-opencv-cuda
```
- Run Image using NVIDIA Container Runtime,
```
sudo docker run --rm --net=host --runtime nvidia  yunusdev/jetson-opencv-cuda:latest
```
