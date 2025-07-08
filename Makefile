.PHONY: help build up down restart logs shell clean test

# Default target
.DEFAULT_GOAL := help

# Docker Compose commands
build: ## Build the Docker image
	docker compose build

up: ## Start the application in detached mode
	docker compose up -d

down: ## Stop and remove containers
	docker compose down

restart: ## Restart the application
	docker compose restart

logs: ## Show application logs
	docker compose logs -f app

shell: ## Open a shell in the running container
	docker compose exec app sh

# Development commands
dev: ## Start in development mode with logs
	docker compose up

stop: ## Stop containers without removing them
	docker compose stop

# Cleanup commands
clean: ## Remove containers, networks, and volumes
	docker compose down -v --remove-orphans

clean-all: ## Remove everything including images
	docker compose down -v --remove-orphans --rmi all

# Utility commands
ps: ## Show running containers
	docker compose ps

top: ## Show running processes
	docker compose top

# Bundle commands
bundle-install: ## Install gems in container
	docker compose run --rm app bundle install

bundle-update: ## Update gems in container
	docker compose run --rm app bundle update

# Code quality commands
rubocop: ## Run RuboCop linter
	docker compose run --rm app bundle exec rubocop

rubocop-fix: ## Run RuboCop with auto-fix
	docker compose run --rm app bundle exec rubocop --autocorrect-all

lint: ## Run RuboCop linter (alias for rubocop)
	docker compose run --rm app bundle exec rubocop

lint-fix: ## Run RuboCop with auto-fix (alias for rubocop-fix)
	docker compose run --rm app bundle exec rubocop --autocorrect-all

# Health check
health: ## Check application health
	curl -f http://localhost:4567/apple_music/songs_count || echo "Service not healthy"

# Test endpoints
test-endpoints: ## Test all service endpoints
	@echo "Testing Apple Music..."
	@curl -I http://localhost:4567/apple_music/songs_count
	@echo "\nTesting Spotify..."
	@curl -I http://localhost:4567/spotify/songs_count
	@echo "\nTesting YouTube Music..."
	@curl -I http://localhost:4567/youtube_music/songs_count
	@echo "\nTesting LINE Music..."
	@curl -I http://localhost:4567/line_music/songs_count
	@echo "\nTesting Amazon Music..."
	@curl -I http://localhost:4567/amazon_music/songs_count

# Quick start
quick-start: build up logs ## Build, start, and show logs

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-15s %s\n", $$1, $$2}' $(MAKEFILE_LIST)