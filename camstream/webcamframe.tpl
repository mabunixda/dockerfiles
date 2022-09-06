#!/bin/bash

echo "Content-Type: image/jpeg"
echo "Cache-Control: no-cache"
echo ""
ffmpeg -i "$RTSP_URL" -vframes 1 -f image2pipe -an -
