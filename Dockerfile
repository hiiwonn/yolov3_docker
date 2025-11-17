FROM ubuntu:20.04 

# 필요한 종속성 설치
RUN apt-get update && apt-get install -y \
    git \
    make \
    gcc \
    g++ \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Darknet 소스 코드 클론 및 작업 디렉토리 설정
RUN git clone https://github.com/pjreddie/darknet /darknet
WORKDIR /darknet

# OpenCV 사용 끄기 (libopencv-dev 설치 안 했으니까)
RUN sed -i 's/OPENCV=1/OPENCV=0/' Makefile

# YOLOv3 사전 학습된 가중치 파일 다운로드
RUN wget https://data.pjreddie.com/files/yolov3.weights

# Darknet 컴파일 (빌드)
RUN make

# 객체 검출을 실행하는 스크립트 복사 및 권한 설정
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# 컨테이너의 기본 실행 명령 설정
ENTRYPOINT ["/usr/local/bin/run.sh"]
