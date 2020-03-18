# For more information, please refer to https://aka.ms/vscode-docker-python
FROM osgeo/gdal:alpine-normal-latest

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE 1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED 1

# Install pip requirements
ADD requirements.txt .
RUN python -m pip install -r requirements.txt

WORKDIR /app
ADD . /app

VOLUME /data

# Start a Waitress server to run the app, and set the port as desired.
EXPOSE 8080

# During debugging, this entry point will be overridden. For more information, refer to https://aka.ms/vscode-docker-python-debug
# CMD ["gunicorn", "--bind", "0.0.0.0:8080", "start_flask:app"]
