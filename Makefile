.PHONY: all
all:
	make install
	make deploy

.PHONY: install
install:
	ansible-playbook -i inventories/localhost.yml install.yml

.PHONY: deploy
deploy:
	ansible-playbook -i inventories/localhost.yml deploy.yml

.PHONY: test
test:
	bats tests/

.PHONY: docker-build
docker-build:
	docker build -t dotfiles .

.PHONY: docker-test
docker-test:
	docker run --rm -v $(PWD):/usr/src/ -w /usr/src -it dotfiles:latest \
	make all && make test
