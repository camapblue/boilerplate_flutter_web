ENV ?= dev

deploy:
	firebase use $(ENV)
	flutter build web
	firebase deploy