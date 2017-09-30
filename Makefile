SHELL        = /bin/bash
CFG          =.env

# Login of admin user in CIR restricted areas
CIS_AREA_LOGIN     ?= admin
# Password of admin user in CIS restricted areas
CIS_AREA_PASS      ?= set me from CIS config

# Config store url
ENFIST_URL   ?= http://enfist:8080/rpc

-include $(CFG)
export

# ------------------------------------------------------------------------------
# .env file store

## get env tag from store, `make get TAG=app--config--tag[.env]`
get:
	@[[ "$(TAG)" ]] || { echo "Error: Tag value required" ; exit 1 ;}
	@echo "Getting env into $(TAG)" \
	  && tag=$${TAG%.env} \
	  && curl -gs -u "$${CIS_AREA_LOGIN}:$${CIS_AREA_PASS}" "$${ENFIST_URL}/tag_vars?a_code=$$tag" \
	    | jq -r '.result[0].tag_vars' > $${tag}.env

## set env tag in store, `make set TAG=app--config--tag[.env]`
set:
	@[[ "$(TAG)" ]] || { echo "Error: Tag value required" ; exit 1 ;}
	@echo "Setting $(TAG) from file" \
	  && tag=$${TAG%.env} \
	  && jq -R -sc ". | {\"a_code\":\"$$tag\",\"a_data\":.}" < $${tag}.env \
	    | curl -gsd @- -u "$${CIS_AREA_LOGIN}:$${CIS_AREA_PASS}" "$${ENFIST_URL}/tag_set"

## del env tag from store, `make del TAG=app--config--tag[.env]`
del:
	@[[ "$(TAG)" ]] || { echo "Error: Tag value required" ; exit 1 ;}
	@echo "Deleting $(TAG)" \
	  && tag=$${TAG%.env} \
	  && curl -gs -u "$${CIS_AREA_LOGIN}:$${CIS_AREA_PASS}" "$${ENFIST_URL}/tag_del?a_code=$$tag"

define CONFIG_DEF
# dcape-app-config config file, generated by make init

# dcape CIS restricted area credentials
CIS_AREA_LOGIN=$(CIS_AREA_LOGIN)
CIS_AREA_PASS=$(CIS_AREA_PASS)

# dcape CIS enfist site
ENFIST_URL=$(ENFIST_URL)

endef
export CONFIG_DEF

$(CFG):
	@echo "*** $@ ***"
	@[ -f $@ ] || { echo "$$CONFIG_DEF" > $@ ; echo >&2 "Created default $@" ; }
