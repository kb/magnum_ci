An attempt to write a better CI server.

To play around with resque...
1. start redis server --> redis-server /usr/local/etc/redis.conf
2. start a resque --> QUEUE=* rake environment resque:work (the splat can be replaced with any string value)
3. start rails --> script/server
4. start rails/console --> script/console
5. In rails/console --> Resque.enqueue(Job, params = {} )

* Check out the resque window and you'll see "Processed a job!"
* If you go to localhost:3000 you'll see the resque app UI (I know, there's a few bugs... I'm working on it)