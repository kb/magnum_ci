An attempt to write a better CI server.

To play around with resque...

* start redis server --> redis-server /usr/local/etc/redis.conf
* start a resque --> QUEUE=* rake environment resque:work (the splat can be replaced with any string value)
* start rails --> script/server
* start rails/console --> script/console
* In rails/console --> Resque.enqueue(Job, params = {})
* Check out the resque window and you'll see "Processed a job!"
* If you go to localhost:3000 you'll see the resque app UI (I know, there's a few bugs... I'm working on it)