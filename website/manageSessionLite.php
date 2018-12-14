<?php

require_once($_SERVER['DOCUMENT_ROOT'] . '/../ucfg/dbInclude.php'); 

function sec_session_start() {
    $session_name = 'SotaSTATSLogin';   // Set a custom session name
    /*Sets the session name. 
     *This must come before session_set_cookie_params due to an undocumented bug/feature in PHP. 
     */
    session_name($session_name);
 
    $secure = true;
    // This stops JavaScript being able to access the session id.
    $httponly = true;
    // Forces sessions to only use cookies.
    if (ini_set('session.use_only_cookies', 1) === FALSE) {
        header("Location: ../error.php?err=Could not initiate a safe session (ini_set)");
        exit();
    }
    session_set_cookie_params(18000,
        '/', 
        '', 
        true,
        true);
 
    session_start();            // Start the PHP session 
}

sec_session_start();
?>