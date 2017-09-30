# dcape-config-cli - command line interface for dcape config storage

This Makefile allows to operate with remote dcape server application configs.

## Setup

* git clone git@github.com:dopos/dcape-config-cli.git
* make .env
* [write dcape attributes to .env]

## Usage

* `make get TAG=name` - получить из хранилища конфигурацию для тега `name` и сохранить в файл name.env
* `make set TAG=name` - загрузить файл name.env в хранилище с тегом `name`
* `make del TAG=name` - удалить в хранилище тег `name`

## TODO

* [ ] make update - скачает с сервера все конфиги и положит их файлами
* [ ] make push - сохранить все конфиги из текущего каталога на сервер деплоя
* [ ] make pull - выгрузить в текущий каталог все конфиги с сервера деплоя

## LICENSE

The MIT License (MIT), see [LICENSE](LICENSE).

Copyright (c) 2017 Alexey Kovrizhkin <lekovr+dopos@gmail.com>