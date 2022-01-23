# Surfmon

Custom surf alerts

## More Info

Surfmon is a little like IFTTT (If This Then That) for surfing. I wanted a tool for building my own custom surf alerts so that I don't have to monitor the charts. If you've thought "I would love an email for the days that the swell direction is between A and B degrees, the period is C and the swell height is D" then Surfmon might be for you!

## Setup

You'll need:

- Ruby 3.1.0
- PostgreSQL (I'm using 14)

Then you can run to setup:

```sh
bundle
bin/rails db:setup
```

Then you can start your dev environment with:

```sh
bin/rails s
```

## Test

Test things that are important, confusing or complex (or any combination of those). Nothing near 100% coverage is required.

```sh
bin/rails t
```

## Credits

<a href="https://www.flaticon.com/free-icons/surfing" title="surfing icons">Surfing icons created by Creative Stall Premium - Flaticon</a>
