#!/usr/bin/env bash
#Source: https://lobradov.github.io/Building-docker-multiarch-images/

arch_array=( amd64 arm32v7 arm64v8 )

#Clean up
for docker_arch in "${arch_array[@]}"
do
  rm Dockerfile.${docker_arch}
done

#Replace __BASE_IMAGE_ARCH__ to actual arch
for docker_arch in "${arch_array[@]}"
do
  cp Dockerfile Dockerfile.${docker_arch}
  sed -i "" "s|__BASE_IMAGE_ARCH__|${docker_arch}|g" Dockerfile.${docker_arch}
done

#build and push image
for docker_arch in "${arch_array[@]}"
do
  docker build -f Dockerfile.${docker_arch} -t redwid/aria2-ng:${docker_arch} .
#  docker push redwid/aria2-ng:${docker_arch}
done

