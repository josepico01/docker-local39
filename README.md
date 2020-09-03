# eAssessment Moodle and Behat docker

## Requirements

- Docker
- Docker-compose

For Windows users, make sure to do a full clean re-install of the latest Docker and WSL v2.
Install the Ubuntu 20.04LTS image from the Microsoft market place.

Configure Docker and allow integration from the WSL Ubuntu 20.04LTS image installed.
The docker-compose tool can be installed via pip, e.g.
```
    pip install docker-compose
```

## Usage

1. Clone this repository

```
git clone ssh://git@bitbucket.apps.monash.edu:7999/eass/docker-local.git
```

2. Clone Moodle code into siteroot

Prod branch (stable): ```mdl35-monash-eassess```<br>
Uat branch: ```mdl35-monash-eassess-uat```

```
cd docker-local
git clone git@git.catalyst-au.net:monash/moodle-eassess.git -b <branchname> siteroot
```

Alternatively, create a symlink to an existing checkout.
```
cd docker-local
ln -s /path/to/moodle-eassess siteroot
```

Mandatory step - checkout git submodules:
```
cd siteroot
git submodule update --init --recursive
```

3. Copy site config across

There is a working sample within the base of the docker-local repository.
```
cd docker-local
cp config-sample.php siteroot/config.php
```

4. Add additional host overrides
Add into /etc/hosts:
```
127.0.0.1   eass behat-runner
```

5. Build local docker images and run local docker stack

```
cd docker-local
make build
make run
```

The default is to run containers in forground, providing output to console.
If you prefer to run it in background mode:
```
make run OPT=-d
```

See the Makefile for other targets that you can use.

## Logging into eAssessment Moodle

Once the containers have all started up successfully, you will need to configure the site
In a browser:
```http://eass```

## Utility Commands

Use the following command to enter the bash shell of each container.

Enter eass container:

```
./control eass
```

Enter db container:

```
./control db
```

Enter test database container:

```
./control testdb
```

Enter the behat-runner container:

```
./control behat
```

Enter the selenium container:

```
./control selenium
```

## Running phpunit tests

First initialise the database:
```
make init-phpunit
```

To run an individual unit test:
```
./run_phphunit.sh <classname> <php_test_file>
```
e.g.
```
./run_phpunit.sh auth_manual_testcase auth/manual/tests/manual_test.php
```

## Running Behat tests

The initialisation process is automatically ran at bootstrapping of the container.

To run an individual behat feature test:
```
./run_behat.sh <module> <featurefile>
```
e.g.
```
./run_behat.sh calendar calendar
./run_behat.sh blog blog_visibility
```

## Viewing the Selenium Chrome instance

VNC client can be used to connect to the Selenium container (Selenium Chrome Standalone Debugger)

Connect to: ```localhost:5900```<br>
Password: ```secret```

## PHPStorm debugging via xDebug

Set up two PHP Remote Debug configurations in PHPStorm.

### eAssessment Moodle
Tick ```Filter debug connection by IDE key```<br>
Configure server with:
* Server Name: eass-docker
  * Host: localhost
  * Port: 80
  * Debugger: XDebug

Tick ```Use path mappings```<br>
Set absolute path on the server for the Project files to: ```/siteroot```<br>
Set the IDE key to: ```eass-docker```<br>

Save.

### Behat
Tick ```Filter debug connection by IDE key```<br>
Configure server with:
* Server Name: behat-runner-docker
  * Host: localhost
  * Port: 8080
  * Debugger: XDebug

Tick ```Use path mappings```<br>
Set absolute path on the server for the Project files to: ```/siteroot```<br>
Set the IDE key to: ```behat-runner-docker```

Save.

### Running
Run either/both debuggers configured in PHPStorm.<br>
Set any breakpoints in code.<br>
Run PhpUnit or Behat test as per above instructions.<br>
Watch the PHPStorm Debugger/Console/Output window.<br>
Win.
