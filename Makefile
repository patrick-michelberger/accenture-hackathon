APPNAME=theapp

it: build_image run_container

build_image:
	docker image build -t $(APPNAME) .

run_container:
	docker container run $(APPNAME)
