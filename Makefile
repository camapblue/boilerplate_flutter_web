ENV ?= dev

setup-env:
	# yarn
	echo "Start setup Environment"
	cp ./environments/$(ENV)/.env .env

build-web:
	make setup-env
	make package
	cp ./assets/fonts/MaterialIcons-Regular.otf ./build/web/assets/fonts/MaterialIcons-Regular.otf

package:
	flutter build web --dart-define env=$$(echo $$(cat .env | tr '\n' '|')) --web-renderer html --release

deploy:
	firebase use $(ENV)
	make build-web
	firebase deploy

run:
	make setup-env
	flutter run --dart-define env=$$(echo $$(cat .env | tr '\n' '|')) -d chrome --web-renderer html --web-port=8080
	