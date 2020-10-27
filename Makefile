.PHONY: install
install:
	ansible-playbook -i localhost.yml playbook/install.yml

.PHONY: deploy
deploy:
	ansible-playbook -i localhost.yml playbook/deploy.yml

.PHONY: docker-build
docker-build:
	docker build -t dotfiles .

.PHONY: docker-test
docker-test:
	docker run --rm -v $(PWD):/usr/src/ -w /usr/src -it dotfiles:latest make install
