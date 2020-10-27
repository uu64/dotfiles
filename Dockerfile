FROM ubuntu:20.04

RUN apt update && apt install -y \
  aptitude \
  git \
  make \
  python3.8 \
  python3-apt \
  python3-pip \
&& rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/sstephenson/bats.git \
&& bats/install.sh /usr/local \
&& rm -rf bats

COPY requirements.txt ./
RUN python3 -m pip install -r requirements.txt
