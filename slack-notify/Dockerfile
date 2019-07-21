FROM python:3.8-alpine AS build

RUN \
 apk add --no-cache --virtual=build-dependencies \
    autoconf \
    automake \
    g++ \
    gcc \
    linux-headers \
    make \
    openssl-dev \
    zlib-dev

RUN mkdir /install
WORKDIR /install

COPY requirements.txt /requirements.txt
RUN pip install --install-option="--prefix=/install" -r requirements.txt

FROM python:3.8-alpine

COPY --from=base /install /usr/local
COPY notify.py notify.py

ENTRYPOINT ["python", "/notify.py"]