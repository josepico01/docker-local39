<?php  // Moodle configuration file

unset($CFG);
global $CFG;
$CFG = new stdClass();

$CFG->dbtype    = 'pgsql';
$CFG->dblibrary = 'native';
$CFG->dbhost    = 'db';
$CFG->dbname    = 'moodle';
$CFG->dbuser    = 'moodle_user';
$CFG->dbpass    = 'L0c4l_P4ssW0rd';
$CFG->prefix    = 'mdl_';
$CFG->dboptions = array (
  'dbpersist' => 0,
  'dbport' => '',
  'dbsocket' => '',
);

$CFG->phpunit_dbtype    = 'pgsql';
$CFG->phpunit_dblibrary = 'native';
$CFG->phpunit_dbhost    = 'test-db';
$CFG->phpunit_dbname    = 'moodle';
$CFG->phpunit_dbuser    = 'moodle_user';
$CFG->phpunit_dbpass    = 'L0c4l_P4ssW0rd';
$CFG->phpunit_prefix    = 'phpu_';
$CFG->phpunit_dataroot = '/var/lib/testsitedata';

$CFG->wwwroot   = 'http://eass';
$CFG->dataroot  = '/var/lib/sitedata';
$CFG->admin     = 'admin';


// behat stuff
$CFG->behat_wwwroot   = 'http://behat-runner:8080';
$CFG->behat_dataroot  = '/var/www/behatdata';
$CFG->behat_prefix = 'bht_';
$CFG->behat_profiles = array(
    'default' => array(
        'browser' => 'chrome',
	'wd_host' => 'http://selenium:4444/wd/hub'
    ),
);
$CFG->behat_increasetimeout = 3;
$CFG->behat_faildump_path = '/var/www/behatfaildumps';


if (true) {
    // Force a debugging mode regardless the settings in the site administration
    @error_reporting(E_ALL | E_STRICT); // NOT FOR PRODUCTION SERVERS!
    @ini_set('display_errors', '1');    // NOT FOR PRODUCTION SERVERS!
    $CFG->debug = (E_ALL | E_STRICT);   // === DEBUG_DEVELOPER - NOT FOR PRODUCTION SERVERS!
    $CFG->debugdisplay = 1;             // NOT FOR PRODUCTION SERVERS!
    // Allow any type of password
    $CFG->passwordpolicy = false;
    $CFG->cachejs = false;
    $CFG->isremote = true;
}
$CFG->theme = 'monasheass';
// $CFG->theme = 'monash';
$CFG->cookiesecure = false;
$CFG->custom_context_classes = [
    90 => 'local_questionbank\context'
];
$CFG->local_envbar_prodwwwroot = 'monash.edu';
$CFG->local_envbar_items = [
    [
        'id'           => 'dev',
        'matchpattern' => 'http://(127.0.0.1|eass)',
        'showtext'     => 'DEV environment',
        'colourbg'     => 'orange',
        'colourtext'   => 'white',
        'lastrefresh'  => 0,
    ],
];

$CFG->noemailever = true;
$CFG->directorypermissions = 0777;

require_once(dirname(__FILE__) . '/lib/setup.php');

// There is no php closing tag in this file,
// it is intentional because it prevents trailing whitespace problems!
