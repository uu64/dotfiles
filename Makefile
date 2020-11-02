.PHONY: all
all:
	make install
	make deploy
	make test

.PHONY: install
install:
	ansible-playbook -K -i inventories/localhost.yml install.yml

.PHONY: deploy
deploy:
	ansible-playbook -i inventories/localhost.yml deploy.yml

.PHONY: lint
lint:
	ansible-lint install.yml -x 401
	ansible-lint deploy.yml -x 401
	ansible-lint roles/* -x 401

.PHONY: test
test:
	bats tests/

.PHONY: docker-build
docker-build:
	docker build -t dotfiles .

.PHONY: docker-test
docker-test:
	docker run --rm -v $(PWD):/usr/src/ -w /usr/src -it dotfiles:latest make all
