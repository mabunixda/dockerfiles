#!/bin/sh

cvlc -R ${RTSP_URI} --sout "#transcode{vcodec=mjpg,scale=1.0,fps=15,acodec=none}:standard{access=http{mime=multipart/x-mixed-replace;boundary=--7b3cc56e5},mux=mpjpeg,dst=:8080/s0.mjpeg}"

