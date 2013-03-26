Steam games OS distribution
===========================

For a given user, it will tell you how many games are supported on each OS.

Usage
-----

First time
```
bundle install
```

Then
```
./steam-games-osdist.rb username
```

The first time it'll take a while since it has to check each game's page,
but the results are cached so it should get better after that.

Example
-------

```
$ ./steam-games-osdist.rb blaquened
Progress: |==================================|
RESULTS:
138 total games
114 with Windows support
63 with OSX support
31 with Linux support
```

To-Do
-----

* Less dependency on gems for the silly stuff.
* Catch exceptions instead of failing miserably.
* Cache invalidation
* Maybe using Steam's API for some of this stuff? [This endpoint](https://developer.valvesoftware.com/wiki/Steam_Web_API#GetOwnedGames_.28v0001.29) might be useful.