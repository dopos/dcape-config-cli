# dcape-config-cli Makefile

SHELL        = /bin/bash
CFG          = .env

# CIS access token
CIS_TOKEN   ?= set_from_cis_site_data

# Config store url
ENFIST_URL  ?= http://cis.dev.lan/conf/api

-include $(CFG)
export

.PHONY: all help ls cat get set del

all: help

# ------------------------------------------------------------------------------

## get env tag list store, `make ls`
ls:
	@echo -e "** Configs at server $${ENFIST_URL}:\n" ; \
	curl -gs -H "X-narra-token:$$CIS_TOKEN" "$${ENFIST_URL}/tag/" | jq -r '.[].code'

## cat data of env tag from store, `make cat TAG=app--config--tag[.env]`
cat:
	@[[ "$(TAG)" ]] || { echo "Error: Tag value required" ; exit 1 ;}
	@echo "Getting env into $(TAG)" \
	  && tag=$${TAG%.env} \
	  && curl -gs -H "X-narra-token:$$CIS_TOKEN" "$${ENFIST_URL}/tag_vars/?code=$$tag" | jq -r '.'

## get env tag from store, `make get TAG=app--config--tag[.env]`
get:
	@[[ "$(TAG)" ]] || { echo "Error: Tag value required" ; exit 1 ;}
	@echo "Getting env into $(TAG)" \
	  && tag=$${TAG%.env} \
	  && curl -gs -H "X-narra-token:$$CIS_TOKEN" "$${ENFIST_URL}/tag_vars/?code=$$tag" \
	    | jq -r '.' > $${tag}.env

## set env tag in store, `make set TAG=app--config--tag[.env]`
set:
	@[[ "$(TAG)" ]] || { echo "Error: Tag value required" ; exit 1 ;}
	@echo "Setting $(TAG) from file" \
	  && tag=$${TAG%.env} \
	  && jq -R -sc ". | {\"code\":\"$$tag\",\"data\":.}" < $${tag}.env \
	    | curl -gsd @- -H "X-narra-token:$$CIS_TOKEN" "$${ENFIST_URL}/tag_set/" | jq '.'

## del env tag from store, `make del TAG=app--config--tag[.env]`
del:
	@[[ "$(TAG)" ]] || { echo "Error: Tag value required" ; exit 1 ;}
	@echo "Deleting $(TAG)" \
	  && tag=$${TAG%.env} \
	  && curl -gs -H "X-narra-token:$$CIS_TOKEN" "$${ENFIST_URL}/tag_del/?code=$$tag" | jq '.'

define CONFIG_DEF
# dcape-app-config config file, generated by make init

# CIS access token
# from gitea's /user/settings/applications
CIS_TOKEN=$(CIS_TOKEN)

# Config store url
ENFIST_URL=$(ENFIST_URL)

endef
export CONFIG_DEF

## create .env file
$(CFG):
	@echo "*** $@ ***"
	@[ -f $@ ] || { echo "$$CONFIG_DEF" > $@ ; echo >&2 "Created default $@" ; }

help:
	@grep -A 1 "^##" Makefile | less

##
## Press 'q' for exit
##
