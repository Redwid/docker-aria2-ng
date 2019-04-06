#!/usr/bin/env bash
docker build -t redwid/aria2-ng .
docker run -d -p 80:80 -p 6800:6800 -v /Users/$USER/Downloads:/data redwid/aria2-ng
docker container ls --all