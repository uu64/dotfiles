FROM python:3.8
USER root

RUN apt update && apt install -y \
  aptitude \
  make \
  python3-aptitude \
&& rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./
