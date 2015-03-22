# FlickrWatch

An Apple Watch WatchKit app that displays the current time using random single-digit photos from Flickr.

---

Both Objective-C and Swift implementations are provided. I am still
learning Swift, so it may be less than stellar, but I tried to do a
pretty straight-forward port of the Objective-C code.

Also, please note the performance on an actual watch would probably be
terrible as it is transfering a lot of image data from the phone to
the watch.

For entertainment/educational purposes only.

### NOTES

This app uses the [FlickrKit](https://github.com/devedup/FlickrKit)
project to talk to the Flickr API. If you clone this repo it will
definitely not compile unless you also clone the FlickrKit repo as a
sibling to this repo. You will also need to register your own Flickr
Developer App to get your own OAuth keys to use in the watch app. This
repo is mostly provided as a code/storyboard reference, but with some
effort you can also get it working in your simulator.

### Screenshots

![watch 12hr](https://pbs.twimg.com/media/CAK7bt4U8AA9k1S.png)

![watch 24hr](https://pbs.twimg.com/media/CAK7bueUcAAEm9n.png)

![settings](https://pbs.twimg.com/media/CAKtkTdUkAAAq1W.png)
