.PHONY: install docker-test clean

default: install

clean:
	rm -rf *.pyc keys temp

install:
	sudo apt-get install -y \
		gpg \
    libffi-dev \
    monkeysphere \
    pipenv \
    python-is-python3 \
    scdaemon

# using the test mnemonic from https://github.com/ethankosakovsky/bip85/blob/435a0589746c1036735d0a5081167e08abfa7413/bip85/tests/test_bip85rsa.py#L30
docker-test:
	docker build -t gpg-hd .
	mkdir -p keys
	docker run \
		--rm \
		-v "$$PWD/keys:/gpg-hd/keys" \
		-it gpg-hd -n foobar -e bazbar --sign-with-master "install scatter logic circle pencil average fall shoe quantum disease suspect usage"
