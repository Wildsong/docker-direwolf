# docker-direwolf

[Direwolf](https://github.com/wb2osz/direwolf) connects to a modem
and gates serial data between your computer and a radio.

The "modem" can be a soundcard or it can be a [RTL-SDR USB radio](https://www.rtl-sdr.com).

The purpose of this project is to deploy direwolf in
a Docker container so that I can use either an RTL-SDR radio
or a USB sound card connected to a radio on my Linux server, [Bellman]().

I plan to use the radio to create an [APRS](https://aprs.org) [IGate](http://www.aprs-is.net/IGating.aspx).
An IGate is a connection between the Internet and APRS.

I'd stick with just the SDR receiver, but [I've been told that I would
be a bad citizen]() if I do that; there is an expectation that any iGate be
able to transmit as well as receive. Fair enough; APRS digipeaters are
very thin on the ground here and though I find the concept of an SDR
exciting, I happen to have some HTs that could be pressed into digipeater
service. Possibly also a Tinytrak transceiver? I have a deep closet
full of mysterious abandoned projects to explore.

If I manage to get the full transceiver set up, I am sure I will find
a spot in the closet for the RTL-SDR.

## Project status

2022-02-28 The image will build and run, but I don't have the audio portion (soundcard or RTL-SDR)
set up yet, so it exits immediately.

### Configuration

Currently I put a default direwolf.conf file into the direwolf user's home directory
to make the app happy. I need to customize it and possibly move it into a volume,
so that you can modify it for your site.

### GPS

Time to get GPS working (time ha ha ha).
This will be a separate project to run gpsd.
Damn but I need easy access to my roof.

## Build

```bash
 docker build -t direwolf:latest .
```

## Test

This will start direwolf running and currently you will see its soundcard error messages.
```bash
docker run -ti --rm direwolf:latest
```

## Deploy

In the event of an actual working Docker,
this command will start direwolf running on port 8000
so that you can connect to it from (for example)
xastir and use it to talk to your SDR.

```bash
docker run -d -p 8000:8000 --rm direwolf:latest
```

## Resources

Direwolf official documentation: https://github.com/wb2osz/direwolf/tree/master/doc

Direwolf user guide (2016): https://packet-radio.net/wp-content/uploads/2018/10/Direwolf-User-Guide.pdf

Now I need to figure out the USB, soundcard, RTL-SDR stuff and add appropriate resources for that here too.

Article "Build an APRS IGate": https://wcares.org/special-interests-3/aprs/build-an-aprs-igate/

