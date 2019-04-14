#!/usr/bin/env bash
#docker build -f Dockerfile.amd64 -t redwid/aria2-ng:amd64 .
docker run -d -p 6801:80 -p 6800:6800 -v /Users/$USER/Downloads:/data redwid/aria2-ng:latest
docker container ls --all
