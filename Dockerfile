FROM ubuntu:focal

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
    gpg \
    monkeysphere \
    python-is-python2 \
    pipenv

ENV HOME /home/deterministic
RUN useradd -m -s /bin/bash deterministic

WORKDIR /home/deterministic
WORKDIR /home/deterministic/gpg-hd
COPY . .
RUN mkdir -p keys
RUN chown -R deterministic:deterministic /home/deterministic
USER deterministic

ENV LANG C
RUN pipenv install --deploy
ENTRYPOINT ["pipenv", "run", "/home/deterministic/gpg-hd/gpg-hd"]
