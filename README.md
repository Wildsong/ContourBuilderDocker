# ContourBuilderDocker

Workflow for building topo contours inside a Docker container

**2020-Mar-17 THIS IS A WORK IN PROGRESS EITHER OFFER TO HELP OR COME BACK LATER!!! --Brian**

## Overview 

The goal here is to create a Docker image that can build contours
using GDAL in Python scripts.  Using a Docker is far easier to install
and update than installing GDAL and friends on my Windows Desktop.

Originally I thought I'd just run a simple little gdal command or two
from the bash shell.  That lasted about 1 minute, when I learned my
source data is in several projections.  Then I decided I'd need to use
python scripts, and that means I need a practical way to debug them.

SO, along the way, I am learning how to use Visual Studio Code (VSC)
to edit and debug code that lives inside a running Docker container.

## Starting with Flask, locally

Step one is to get any old Python app running in a Docker.  To do
this, I will first get the app running in the local machine to confirm
it works. Then I will move it into the Docker.

My goal is a web app here, this is just step one. So, just "Hello world". There is a fancier sample here if you want:
https://github.com/microsoft/python-sample-vscode-flask-tutorial/tree/tutorial

My app is based on the excellent https://blog.miguelgrinberg.com/post/the-flask-mega-tutorial-part-i-hello-world

My simple code is in app/. I set up a virtual environment for it to run in.
Refer to https://code.visualstudio.com/docs/python/environments

Open a Terminal in VSC and create and activate the environment.
Set policy so you don't get the policy error. Install other packages

```bash
py -3 -m venv .venv
.venv/Scripts/activate.ps1
py -m pip install -r requirements.txt
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
```
The file launch.json has the configuration for VSC that
tells what will happen in the debugger. It is set (in line 11) to run the module "flask" and environment settings tell flask to run module "app" (line 13).

In the VSC Debugger panel (at the very top) set the project type to
"Python: Flask", and run debugger with F5. The task bar turns from
blue to orange.  Navigate to http://127.0.0.1:5000/ in a browser. It
works in the browser, and you should see feedback in the Terminal:

```bash
127.0.0.1 - - [11/Mar/2020 09:40:02] "GET / HTTP/1.1" 200 -
```

You can test whether it's really running in the debugger by setting a breakpoint
in routes.py at line 7. If you reload in the browser then you should see it print the message in line 6 in your Terminal and it should stop on line 7. The browser should be waiting for a reply and then you can hit F5 to continue execution.

Exit the debugger with shift-F5.

## Move the working Flask app into Docker

Next the app has to run in Docker.
Refer to https://code.visualstudio.com/docs/containers/quickstart-python
and https://code.visualstudio.com/docs/containers/debug-python

If you don't already have it, install the Docker extension (from
Microsoft) in VSC.  There are already Dockerfile and
docker-compose.yml files in this repository, but this is how I created
them.  I typed ctl-shift-P and used "Docker: Add Docker Files To
Workspace". Then I edited them.

This Dockerfile will use the latest GDAL image that includes Python. It
will install any extras I specify in requirements.txt (notably
"flask"), install the python scripts in /app and set /data as a VOLUME
where you can connect a folder containing spatial data from the desktop's drive
using the docker-compose.yml volume setting.

In Terminal you can test it immediately without debugger support by running

```bash
docker build -t contourbuilder .
docker run -it --rm -p 8080:8080 contourbuilder
```
If you are using Docker Compose then this should work the same way
```bash
docker-compose build
docker-compose up
```

Either way you should be able to see "Hello, world" at http:1237.0.0.1:8080/

## Running in Docker, with debugger support

The project should be all set to run app.py.

In the VSC Debugger drop down list I switch from "Python: Flask" to "Docker: Python - General" and then hit F5.

BUT it does not work yet! To be continued.


