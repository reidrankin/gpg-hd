FROM ubuntu:focal

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
    gpg \
    libffi-dev \
    monkeysphere \
    pipenv \
    python-is-python3 \
    scdaemon

WORKDIR /gpg-hd
RUN mkdir -p keys
COPY ./Pipfile ./Pipfile.lock ./
RUN chown -R root:root ./
ENV LANG C
RUN pipenv install --system --deploy
COPY . .
RUN chown -R root:root ./
ENTRYPOINT ["./gpg-hd"]
