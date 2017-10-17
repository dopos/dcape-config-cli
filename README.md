# dcape-config-cli - command line interface for dcape config storage

This Makefile allows to operate with dcape server application configs which served via [enfist](https://github.com/pgrpc/pgrpc-sql-enfist) RPC.

## Setup

* git clone https://github.com/dopos/dcape-config-cli.git
* make .env 
* [write dcape attributes to .env]

`CIS access token` доступен на сервере CIS после авторизации (для авторизации открыть ссылку "Config store" и обновить страницу)

## Usage

* `make ls` - получить список конфигураций на сервере
* `make cat TAG=name` - получить из хранилища конфигурацию для тега `name` и вывести на STDOUT
* `make get TAG=name` - получить из хранилища конфигурацию для тега `name` и сохранить в файл name.env
* `make set TAG=name` - загрузить файл name.env в хранилище с тегом `name` (возвращает `true` если создан новый конфиг)
* `make del TAG=name` - удалить в хранилище тег `name` (возвращает `true` если конфиг удален)

## TODO

* [ ] make push - сохранить все конфиги из текущего каталога на сервер деплоя
* [ ] make pull - выгрузить в текущий каталог все конфиги с сервера деплоя

## LICENSE

The MIT License (MIT), see [LICENSE](LICENSE).

Copyright (c) 2017 Alexey Kovrizhkin <lekovr+dopos@gmail.com>
