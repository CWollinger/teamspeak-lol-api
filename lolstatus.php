<?php

#!/usr/bin/bash
### Version: 1.0
### Author: Christian Wollinger
############### Description ###############
### - LoL Status

$test = file_get_contents('lolstatus.tmp');
    require_once('ts3phpframework/libraries/TeamSpeak3/TeamSpeak3.php');
    $server = array(
        "tsip" => $argv[1],
        "tsport" => $argv[2],
        "ts_query_admin" => $argv[3],
        "ts_query_password" => $argv[4],
        "ts_query_port" => "10011",
        "ts_query_user_nick" => $argv[5]
    );
    try {
        TeamSpeak3::init();
        $ts3_VirtualServer = TeamSpeak3::factory("serverquery://".$server["ts_query_admin"].":".$server["ts_query_password"]."@".$server["tsip"].":".$server["ts_query_port"]."/?server_port=".$server["tsport"]."&nickname=".$server["ts_query_user_nick"]."");

        $client = $ts3_VirtualServer->channelGetByName($argv[6]);
        $properties = array("channel_description" => $test);
        if( $client->modify( $properties ) )
            echo "Done";

    } catch(Exception $e) {
        echo "Fehler!<br/>ErrorID: <b>". $e->getCode() ."</b>; Error Message: <b>". $e->getMessage() ."</b>;";
    }
?>
