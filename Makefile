# AWS
AWS_ACCESS_KEY_ID?=AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY?=AWS_SECRET_ACCESS_KEY
AWS_REGION?=AWS_REGION

# Modifiable Variabls
BUCKET_NAME=tdk-slides.io

# Variables
FLUTTER_SDK_BIN=/opt/tk/flutter/bin/cache/dart-sdk/bin
FLUTTER_WEBDEV_PATH=/opt/tk/flutter/.pub-cache/bin/webdev
FLUTTER_WEBDEV=export PATH=$(FLUTTER_SDK_BIN):$$PATH; $(FLUTTER_WEBDEV_PATH)
AWSCLI_RUN_CMD=docker run -it --rm -e AWS_REGION=$(AWS_REGION) -e AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID) -e AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY) -v $$PWD/build:/tmp/build --workdir /tmp/build awscli

serve:
	$(FLUTTER_WEBDEV) serve --auto restart

# TODO - tests only working for dart tests - not for widget tests
# 	Failed to load "test/routes/widget_test.dart":
#  	Unable to spawn isolate: test/routes/widget_test.dart:7:8: Error: Not found: 'dart:html'
	#  import 'dart:html';
unit-test:
	#flutter test
	#export PATH=$(FLUTTER_SDK_BIN):$$PATH; flutter pub run test test/routes/widget_test.dart
	flutter pub run test

build-awscli:
	docker build -f Dockerfile_awscli -t awscli .

run-awscli:
	$(AWSCLI_RUN_CMD) /bin/bash

destroy-bucket:
	$(AWSCLI_RUN_CMD) aws s3 rm s3://$(BUCKET_NAME) --recursive
	$(AWSCLI_RUN_CMD) aws s3api delete-bucket --bucket $(BUCKET_NAME) --region $(AWS_REGION)

create-bucket:
	$(AWSCLI_RUN_CMD) aws s3api create-bucket --bucket $(BUCKET_NAME) --region $(AWS_REGION) --acl public-read
	$(AWSCLI_RUN_CMD) aws s3 website s3://$(BUCKET_NAME)/ --index-document index.html --error-document error.html

sync-bucket: build
	$(AWSCLI_RUN_CMD) aws s3 sync . s3://$(BUCKET_NAME) --acl public-read

clean:
	rm -rf build/
	rm -rf .dart_tool/build

build: clean	
	$(FLUTTER_WEBDEV) build

deploy: build create-bucket sync-bucket

redeploy: build sync-bucket
