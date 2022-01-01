.PHONY: install docker-test clean

default: install

clean:
	rm -rf *.pyc keys temp

install:
	sudo apt-get install -y \
		gpg \
		monkeysphere \
		python-is-python2 \
		python-crypto \
		python-pexpect \
		python-ptyprocess

docker-test:
	docker build -t gpg-hd .
	mkdir -p keys
	docker run \
		--rm \
		-v "$$PWD/keys:/home/deterministic/gpg-hd/keys" \
		-it gpg-hd -n foo -e bar baz
