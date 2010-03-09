An attempt to write a better CI server.

Currently somewhere between version -0.0.1 and 0.0.1... To date Magnum C.I. pretty much builds a
project, dumps the standard out to the db, and sets a success flag.

Works only with git. Shells out for the script to run, so use whatever
series of commands you please.

This will be automated at some point, but for now do the following...

* start the redis server --> redis-server /usr/local/etc/redis.conf
* start build resque --> QUEUE=build rake environment resque:work
* start clone resque --> QUEUE=clone rake environment resque:work
* start delete resque --> QUEUE=delete rake environment resque:work
* start the app --> script/server
* send a json format POST request -> curl -H "Content-Type: application/json" -d "{'payload':{'repository':{'name':'<project name>'}}}" -X POST  http://localhost:3000/build.json -i(Note that the json data sent is the same structure as the one Github sends out (http://help.github.com/post-receive-hooks/))
* start resque front-end to monitor queuing action---> resque-web