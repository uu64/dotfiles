ANSIBLE_INVENTORIES = inventories/localhost.yml
ANSIBLE_SUDO_OPTION = $(shell sudo -n true 2>/dev/null || echo "-K")

# 401: Git checkouts must contain explicit version
ANSIBLE_LINT_SKIP_RULES = 401

IMAGE_NAME = dotfiles
IMAGE_TAG = latest
DOCKER_WORK_DIR = /usr/src/

.PHONY: install
install: install.yml
	ansible-playbook $(ANSIBLE_SUDO_OPTION) -i $(ANSIBLE_INVENTORIES) $^

.PHONY: deploy
deploy: deploy.yml
	ansible-playbook -i $(ANSIBLE_INVENTORIES) $^

.PHONY: test
test:
	bats tests/

.PHONY: docker-build
docker-build:
	docker build -t $(IMAGE_NAME) .

.PHONY: docker-test
docker-test:
	docker run --rm \
		-v $(CURDIR):$(DOCKER_WORK_DIR) \
		-w $(DOCKER_WORK_DIR) \
		-it $(IMAGE_NAME):$(IMAGE_TAG) make all

.PHONY: lint-bats
lint-bats: tests/*
	shellcheck $^

.PHONY: lint-playbook
lint-playbook: install.yml deploy.yml roles/*
	ansible-lint -x $(ANSIBLE_LINT_SKIP_RULES) $^

.PHONY: lint
lint:
	make lint-bats
	make lint-playbook

.PHONY: all
all:
	make install
	make deploy
	make test
	make lint