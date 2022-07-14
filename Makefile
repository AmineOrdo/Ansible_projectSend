ping-all: ## ping server
	ansible -i hosts.yml all -m ping

server_pre_prod:
	ansible-playbook server.yml -i inventory/hosts.yml --vault-password-file ./.vaultPawd -e "env=pre_prod"
	
app_pre_prod:
	ansible-playbook app.yml -i inventory/hosts.yml --vault-password-file ./.vaultPawd -e "env=pre_prod"

server_prod:
	ansible-playbook server.yml -i inventory/hosts.yml --vault-password-file ./.vaultPawd -e "env=prod"

app_prod:
	ansible-playbook app.yml -i inventory/hosts.yml --vault-password-file ./.vaultPawd -e "env=prod"