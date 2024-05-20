.DEFAULT_GOAL := help

help: ## Outputs this help screen
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

.PHONY: install
install: ## Install the project
	@mkcert nginx.localhost
	@mv nginx.localhost.pem docker/nginx/ssl/cert.pem
	@mv nginx.localhost-key.pem docker/nginx/ssl/key.pem
	@docker compose build

start: ## Start the container
	@docker compose up -d

stop: ## Stop the container
	@docker compose stop
