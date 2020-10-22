.PHONY: install
install:
	ansible-playbook -i localhost.yml playbook/install.yml

.PHONY: deploy
deploy:
	ansible-playbook -i localhost.yml playbook/deploy.yml