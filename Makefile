# if you want to run the containers in detached mode, provid this argument:
# OPT=-d
# e.g. make run OPT=-d
OPT =

clean:
	docker system prune -f

status:
	docker ps -a

build:
	docker-compose build

run:
	HOST_TYPE=$(shell uname) docker-compose up $(OPT)

stop:
	docker-compose down

restart: stop run

# clean slate
refresh: clean restart

### PHP UNIT stuff
init-phpunit:
	@docker exec \
    	-it \
    	--user root \
    	$(shell docker-compose ps -q eass) \
    	sh -c 'php /siteroot/admin/tool/phpunit/cli/init.php'
