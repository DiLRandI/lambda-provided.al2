.PHONY: build clean deploy
ARCH?=amd64

build:
	env GOARCH=$(ARCH) GOOS=linux CGO_ENABLED=0 go build -tags lambda.norpc -trimpath -ldflags="-s -w" -o bin/hello/hello hello/main.go
	make write-bootstrap OUTPUT=hello APP_NAME=hello
	env GOARCH=$(ARCH) GOOS=linux CGO_ENABLED=0 go build -tags lambda.norpc -trimpath -ldflags="-s -w" -o bin/world/world world/main.go
	make write-bootstrap OUTPUT=world APP_NAME=world

zip:
	zip -j bin/hello.zip bin/hello/*
	zip -j bin/world.zip bin/world/*

clean:
	rm -rf ./bin

deploy: clean build zip
	./node_modules/.bin/serverless -c serverless.$(ARCH).yml deploy --verbose

write-bootstrap:
	echo "#!/bin/sh\n./$(APP_NAME)" > bin/$(OUTPUT)/bootstrap