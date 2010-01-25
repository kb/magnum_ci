An attempt to write a better CI server.

To play around with resque and resque frontend... (This will be automated at some point)

* start the redis server --> redis-server /usr/local/etc/redis.conf
* start resque --> QUEUE=* rake environment resque:work (the splat can be replaced with any string value)
* start rails/console --> script/console
* In rails/console --> Resque.enqueue(Job, params = {})
* Check out the resque window and you'll see "Processed a job!"
* If you installed the resque gem, fire up resque-web to gain access to the resque frontend

To kick off a build (just clones a git repo for now and isn't threaded yet) send a curl request to builds/new

* Example... curl http://localhost:3000/<name of your project>/builds/new