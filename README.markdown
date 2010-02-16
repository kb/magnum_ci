An attempt to write a better CI server.

Currently somewhere between version -0.0.1 and 0.0.1... To date Magnum C.I. pretty much builds a
project, dumps the standard out to the db, and sets a success flag.

Works only with git. Shells out for the script to run, so use whatever
series of commands you please.

This will be automated at some point, but for now do the following...

* start the redis server --> redis-server /usr/local/etc/redis.conf
* start build resque --> QUEUE=build rake environment resque:work
* start clone resque --> QUEUE=clone rake environment resque:work
* start the app --> script/server
* send a curl request ---> curl http://localhost:3000/::project name::/build (Right now a GET will do, will be a POST in the future)
* start resque front-end to monitor queuing action---> resque-web
