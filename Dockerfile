FROM ubuntu:20.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    wget \
    sudo

# install python2
RUN apt-get install -y --no-install-recommends python2

# install python3
RUN apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    python3.8 \
    python3-pip \
    python-setuptools

# install repository adding prerequisites
RUN apt-get install -y --no-install-recommends \
    dirmngr \
    gnupg \
    apt-transport-https \
    ca-certificates \
    software-properties-common

# add CRAN repository
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'

# install r
RUN apt-get install -y --no-install-recommends r-base

# install python3 requirements
COPY requirements.txt .
RUN pip3 install -r requirements.txt

WORKDIR /home
RUN R --version