<?php
define('PPMS_MEDIA_URL','sites/default/files' );

/** ppms connection **/ 
$ppms  = array(
        'database'  => 'ppms_for_drupal', 
        'username'  => 'trec_l', 
        'password'  => '', 
        'host'      => 'localhost', 
        'driver'    => 'mysql'
  ); 

Database::addConnectionInfo('ppms', 'default', $ppms); 
?>
