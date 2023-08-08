# if you want to run the containers in detached mode, provid this argument:
# OPT=-d
# e.g. make run OPT=-d
OPT =

clean:
	docker system prune -f

status:
	docker ps -a

# (re)build the moodle image
build-eass:
	docker build -t eass_moodle:3.9 ./moodle

# run the Moodle eAssessment container/databases
eass:
	HOST_TYPE=$(shell uname) docker-compose -f ./moodle/docker-compose.yml up $(OPT)

# stop the Moodle eAsessment container/databases
stop-eass:
	docker-compose -f ./moodle/docker-compose.yml stop

# restart the Moodle eAsessment container/databases
restart-eass: stop-eass eass

# (re)build the moodle image used to run behat tests
build-behat:
	docker build -t	behat_runner:3.9 ./behat-runner

# run the container for behat testing
behat:
	HOST_TYPE=$(shell uname) docker-compose -f ./behat-runner/docker-compose.yml up $(OPT)

# stop the container for behat testing
stop-behat:
	docker-compose -f ./behat-runner/docker-compose.yml stop

# restart the container for behat testing
restart-behat: stop-behat behat

# build all images
build: build-eass build-behat

# run all containers, must use with OPT=-d
run: eass behat

# stop everything
stop: stop-eass stop-behat

# restart everything, must use with OPT=-d
restart: restart-eass restart-behat

# clean slate, must use with OPT=-d
refresh: stop clean restart-eass restart-behat

# destroy everything docker related
down: stop
	  docker-compose -f ./moodle/docker-compose.yml down
	  docker-compose -f ./behat-runner/docker-compose.yml down

### PHP UNIT stuff
init-phpunit:
	@docker exec \
    	-it \
    	--user root \
    	$(shell docker-compose -f moodle/docker-compose.yml ps -q eass) \
    	sh -c 'php /siteroot/admin/tool/phpunit/cli/init.php'
