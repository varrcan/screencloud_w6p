#!/usr/bin/env bash

curl -F "token=$2" 	-F "UploadForm[imageFile]=@$1" 	https://w6p.ru/site/upload
