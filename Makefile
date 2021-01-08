ENV ?= dev

setup-env:
	# yarn
	echo "Start setup Environment"
	cp ./environments/$(ENV)/env.json env.json

deploy:
	make setup-env
	firebase use $(ENV)
	# configs := $$(echo $$(cat env.json | jq @json))
	# $(eval configs=$(echo $$(cat env.json | jq @json)))
	$(eval configs=$($$(echo $$(cat env.json | jq @json))))
	echo $(configs)
	# @echo "hello world"
	# flutter build web --dart-define env=$(cons)
	# firebase deploy

run:
	make setup-env
	firebase use $(ENV)
	flutter run --dart-define env=$$(echo $$(cat env.json | jq @json)) -d chrome
	