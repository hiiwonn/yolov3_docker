#!/bin/bash

# 입력 인자가 없으면 사용법 출력
if [ -z "$1" ]; then
    echo "Usage: docker run your_image_id <IMAGE_URL>"
    exit 1
fi

IMAGE_URL=$1
INPUT_FILENAME="input.jpg"
CONFIG_PATH="cfg/yolov3.cfg"
DATA_PATH="cfg/coco.data"
WEIGHTS_PATH="yolov3.weights"

# 1. 이미지 URL에서 input.jpg로 파일 다운로드
echo "Downloading image from: $IMAGE_URL"
wget -O $INPUT_FILENAME $IMAGE_URL

# 2. 객체 검출 실행 및 결과를 표준 출력으로 표시
# Darknet은 기본적으로 결과를 predictions.jpg에 저장하지만,
# 여기서는 텍스트 출력만 필요하므로 (과제 요구 사항) 실행합니다.
# Darknet은 실행 결과를 stdout으로 출력합니다 (predicted classes and probabilities).
./darknet detector test $DATA_PATH $CONFIG_PATH $WEIGHTS_PATH $INPUT_FILENAME -thresh 0.25 -dont_show