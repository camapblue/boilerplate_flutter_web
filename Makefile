ENV ?= dev

setup-env:
	# yarn
	echo "Start setup Environment"
	cp ./environments/$(ENV)/env.json env.json

deploy:
	make setup-env
	firebase use $(ENV)
	flutter build web --dart-define env="$$(echo $$(cat env.json | jq @json))"
	firebase deploy

run:
	make setup-env
	firebase use $(ENV)
	flutter run --dart-define env=$$(echo $$(cat env.json | jq @json))
	