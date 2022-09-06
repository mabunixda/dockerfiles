#!/bin/bash

echo "Content-Type: multipart/x-mixed-replace;boundary=ffmpeg"
echo "Cache-Control: no-cache"
echo ""
ffmpeg -i "$RTSP_URL" -c:v mjpeg -q:v 1 -f mpjpeg -an -
