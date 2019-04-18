#!/usr/bin/env bash
#Source: https://lobradov.github.io/Building-docker-multiarch-images/
set -e

arch_array=('amd64' 'arm32v7' 'arm64v8')

echo '[INFO] Clean up'
for docker_arch in "${arch_array[@]}"
do
  rm -f "Dockerfile.${docker_arch}"
done

echo '[INFO] Replace __BASE_IMAGE_ARCH__ to actual arch'
ls -a
for docker_arch in "${arch_array[@]}"
do
  cp -v "Dockerfile" "Dockerfile.${docker_arch}"
  sed -i.bak "s|__BASE_IMAGE_ARCH__|${docker_arch}|g" Dockerfile.${docker_arch}
done

#Login if needed
if [ -z "$DOCKER_EMAIL" ]
then
    echo
else
    echo '[INFO] Login to docker'
    docker login -u $DOCKER_USER -p $DOCKER_PASS
fi

echo '[INFO] Build and push images'
for docker_arch in "${arch_array[@]}"
do
  echo "[INFO] Build image: ${docker_arch}"
  docker build -f Dockerfile.${docker_arch} -t redwid/aria2-ng:${docker_arch} .
  echo "[INFO] Push image: ${docker_arch}"
  docker push redwid/aria2-ng:${docker_arch}
done

echo '[INFO] Create docker and push docker manifest'
docker manifest create redwid/aria2-ng:latest redwid/aria2-ng:amd64 redwid/aria2-ng:arm32v7 redwid/aria2-ng:arm64v8
docker manifest annotate redwid/aria2-ng:latest redwid/aria2-ng:arm32v7 --os linux --arch arm
docker manifest annotate redwid/aria2-ng:latest redwid/aria2-ng:arm64v8 --os linux --arch arm64 --variant armv8
docker manifest push redwid/aria2-ng:latest

echo '[INFO] Done'

