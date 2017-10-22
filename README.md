# dcape-config-cli

[![GitHub Release][1]][2] [![GitHub code size in bytes][3]]() [![GitHub license][4]][5]

[1]: https://img.shields.io/github/release/dopos/dcape-app-mattermost.svg
[2]: https://github.com/dopos/dcape-app-mattermost/releases
[3]: https://img.shields.io/github/languages/code-size/dopos/dcape-app-mattermost.svg
[4]: https://img.shields.io/github/license/dopos/dcape-app-mattermost.svg
[5]: LICENSE

Command line interface for [dcape](https://github.com/dopos/dcape) config storage [enfist](https://github.com/pgrpc/pgrpc-sql-enfist).

This Makefile allows to operate with dcape server application configs which served via [enfist](https://github.com/pgrpc/pgrpc-sql-enfist) RPC.

## Docker image used

* none (used connect to remote dcape server)

## Requirements

* linux (git, make, curl, jq)

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

## License

The MIT License (MIT), see [LICENSE](LICENSE).

Copyright (c) 2017 Alexey Kovrizhkin <lekovr+dopos@gmail.com>
