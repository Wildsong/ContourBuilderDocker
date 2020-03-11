# ContourBuilderDocker
Workflow for building topo contours inside a Docker container 

== Overview 

The goal here is to create a Docker image that can build contours using GDAL in Python scripts.
I do this because it's far easier to update a Docker image than to install GDAL on my Windows Desktop.

Originally I thought I'd just run a simple little gdal command or two from the bash shell. That lasted about 1 minute,
at which point I learned my source data is in several projections.

Along the way, I am learning how to use Visual Studio Code (VSC) to edit and debug code that lives inside a running Docker container.

== Flask

Step one is to get any old app running in a Docker. 
To do this, I get the app running in the local machine to confirm it works. 

I am not doing a web app here, this is just step one. So, no fancy Javascript please! Just "Hello world". There is a fancier sample here if you want:
https://github.com/microsoft/python-sample-vscode-flask-tutorial/tree/tutorial

My simple code is in app.py. I set up a virtual environment for it to run in.
Refer to https://code.visualstudio.com/docs/python/environments

Open a Terminal in VSC and create the environment.

   py -3 -m venv .venv
   py -m pip install flask

Set policy so you don't get the policy error

   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process

In the VSC Debugger panel (at the very top) I set the project type to 
"Python: Flask", and run debugger with F5. The task bar turns from blue to orange.
I navigate to http://127.0.0.1:5000/ in a browser. It works in the browser, and I get feedback in the Terminal:

   127.0.0.1 - - [11/Mar/2020 09:40:02] "GET / HTTP/1.1" 200 -
   127.0.0.1 - - [11/Mar/2020 09:40:02] "GET /favicon.ico HTTP/1.1" 404 -

I do shift-F5 to exit the debugger.

==Flask in Docker

Now I need the app to run in Docker. 
Refer to https://code.visualstudio.com/docs/containers/quickstart-python
and https://code.visualstudio.com/docs/containers/debug-python

I installed the Docker extension in VSC, so I can create the files with ctl-shift-P and "Docker: Add Docker Files" to workspace to create Dockerfile and docker-compose.yml. Then I edit those.

My Dockerfile will use the latest GDAL image that includes Python. It will install any extras I specify in requirements.txt (notably "flask"), install the python scripts in /app and set /data as a VOLUME where I will connect up my spatial data from the desktop's drive.

It should be all set to run app.py. 

In the VSC Debugger drop down list I switch from "Python: Flask" to "Docker: Python - Generalower" and then hit F5.


