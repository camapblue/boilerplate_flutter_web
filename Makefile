ENV ?= dev

setup-env:
	# yarn
	echo "Start setup Environment"
	cp ./environments/$(ENV)/.env .env

build-web:
	make setup-env
	flutter build web --dart-define env=$$(echo $$(cat .env | tr '\n' '|')) --web-renderer html --release --tree-shake-icons

deploy:
	firebase use $(ENV)
	make build-web
	firebase deploy

run:
	make setup-env
	firebase use $(ENV)
	flutter run --dart-define env=$$(echo $$(cat .env | tr '\n' '|')) -d chrome --web-renderer html
	