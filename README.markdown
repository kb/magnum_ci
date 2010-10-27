#Magnum CI
A simple Continuous Integration server built on [Rails](http://rubyonrails.org) and [Resque](http://github.com/defunkt/resque) for [git](http://git-scm.org) controlled projects.

**Version 0.5.0**

##Running in Development

1. Start Redis Server
> $ redis-server /usr/local/etc/redis.conf
(this is where I have it on my MBP, it may be different for you)

2. Start Resque Workers
> $ rake workers:magnum_ci

3. Start Rails Server
> $ script/server

##Running in Production

1. Capistrano recipe coming soon
