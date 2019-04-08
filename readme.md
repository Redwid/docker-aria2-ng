
Aria2 with AriaNG
---
The image with aria2, nginx and AriaNg.
Support architectures: amd64 arm32v7 arm64v8.
  

### Install
I. replace **/DOWNLOAD_DIR** and **/CONFIG_DIR** for save data, and **YOUR_SECRET_CODE** for security. Run command below  
```
sudo docker run -d \
--name aria2-ng \
-p 6801:80 \
-p 6800:6800 \
-v /DOWNLOAD_DIR:/data \
-v /CONFIG_DIR:/conf \
-e SECRET=YOUR_SECRET_CODE \
redwid/aria2-ng:latest
```
  
II. Open `http://serverip:6801/` for aria2-ng

### Build:  
Run build.sh 

### Help commands: 
#### Remove all:
```docker system prune -a```

#### List all containers:
```docker container ls --all```

#### Run {container_id} bash:
```docker exec -it {container_id} /bin/bash```

#### Check container logs:
```docker logs {container_id}```

#### List 6801 listen ports in mac
```sudo lsof -n -i -P | grep ':6801'```


### Link:  
https://github.com/aria2/aria2  
https://github.com/mayswind/AriaNg  

---
