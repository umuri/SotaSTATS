This will walk you through the basics of setting up the poller

The three files above run the database poller/propagator

You will need to setup two cron jobs on the server that hosts the poller

The first will be for the end of day calculations, i run this at 2:39 or so to ensure all polls are caught up to the day at least:

cd ~/PATH/TO/APILoad/

php loadEndOfDay.php


The second will be for the normal poller which runs every 10 minutes

cd ~/PATH/TO/APILoad/

php loadSceneBased.php



Don't forget to update dbIncludeLoad.php with your database login information site/user/pass

You'll need to create everything in the schema.sql dump
