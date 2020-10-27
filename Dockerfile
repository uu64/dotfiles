FROM ubuntu:20.04

RUN apt update && apt install -y \
  aptitude \
  make \
  python3.8 \
  python3-apt \
  python3-pip \
&& rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./
RUN python3 -m pip install -r requirements.txt
