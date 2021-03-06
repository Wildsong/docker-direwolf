# docker-direwolf

[Direwolf](https://github.com/wb2osz/direwolf) connects to a modem
and gates serial data between your computer and a radio.

The "modem" can be a soundcard or it can be a [RTL-SDR USB radio](https://www.rtl-sdr.com).

The purpose of this project is to deploy direwolf in
a Docker container so that I can use either an RTL-SDR radio
or a USB sound card connected to a radio on my Linux server, [Bellman]().

I plan to use the radio to create an [APRS](https://aprs.org) [IGate](http://www.aprs-is.net/IGating.aspx).
An IGate is a connection between the Internet and APRS.

I'd stick with just the SDR receiver, but I've read I would be a bad
citizen if I do that; there is an expectation that any iGate be able
to transmit as well as receive. Fair enough; APRS digipeaters are very
thin on the ground here and though I find the concept of an SDR
exciting, I have some HTs that could be pressed into digipeater
service. With a full digipeater, my new Kenwood TH-D74A would have
someplace to connect!  Possibly also a Tinytrak transceiver? I have a
deep closet full of mysterious abandoned projects to explore.

If I manage to get the full transceiver set up, I am sure I will find
a spot in the closet for the RTL-SDR.

## Project status

2022-03-02 Oh the container registry saga, I loved when Docker would automatically
get updated via a link to Github, then they made that a fee service so I stopped using
hub.docker.com. Then I learned I can push the build from github instead and that github
now has their own container registry. Great! I will use that instead. ONLY, there is a
limit of 500MB, well okay, I can probably live with that, this is a hobby after all.
Then I pushed a container up and it would not let me make it public! That makes no
sense. So I deleted it and went back to using the Docker Hub as the storage medium.
Great, I just have to figure out the best path forward for that now, then I can write
it up. I could run my own or use Google Container Registry or AWS ECR or all of them!!

2022-03-01 I added the action.yml and .github/workflows/build.yml files
to (attempt to) implement CI/CD.
This triggers a Docker build on Github and lets me see the output
whenever I do a push. I get a detailed email if the build fails.

I removed the CMD from the Dockerfile because it could not find the direwolf.conf file. It said it was looking in /github/home/direwolf/direwolf.conf. With no CMD it was exiting cleanly.


2022-02-28 The image will build and run, but I don't have the audio portion (soundcard or RTL-SDR)
set up yet, so it exits immediately.

### GPS

Time to get GPS working. This will be a separate project to run gpsd.
Damn but I need easy access to my roof. Yes, some people think about
GPS as a positioning system but for me, it's a hobby in itself so
having a GPS reference station is valuable too.

### Configuration

I copied the direwolf.conf file from the build and then checked it in here.
To keep things as simple as possible I will try to edit that file and just
make it part of the Docker build. If it needs to be more flexible I will
put it in a volume instead. For now, edit it and then build.

## Build

Test the build locally. When changes are pushed to the repo, 
the build will happen and get pushed to Docker Hub.

```bash
 docker buildx build -t docker.io/wildsong/direwolf .
```
You can also test the push to Docker Hub.

```bash
 docker push docker.io/wildsong/direwolf --all-tags
```

## Github Actions

Th workflow in .github/workflows/build.yml will kick off a build
at Github which culimnates in a new image push to Docker Hub.

For login, see https://github.com/docker/login-action

For build and push, see https://github.com/mr-smithers-excellent/docker-build-push

The README.Docker.md file will be copied to Docker Hub in the workflow.
See https://github.com/peter-evans/dockerhub-description

## Test

This will start direwolf running and currently you will see its soundcard error messages.
```bash
docker run -ti --rm wildsong/direwolf:latest
```

## Deploy

In the event of an actual working Docker,
this command will start direwolf running on port 8000
so that you can connect to it from (for example)
xastir and use it to talk to your SDR.

```bash
docker run -d -p 8000:8000 --rm wildsong/direwolf:latest
```

## Resources

Direwolf official documentation: https://github.com/wb2osz/direwolf/tree/master/doc

Direwolf user guide (2016): https://packet-radio.net/wp-content/uploads/2018/10/Direwolf-User-Guide.pdf

Now I need to figure out the USB, soundcard, RTL-SDR stuff and add appropriate resources for that here too.

Article "Build an APRS IGate": https://wcares.org/special-interests-3/aprs/build-an-aprs-igate/

