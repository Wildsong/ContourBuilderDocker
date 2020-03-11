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

# During debugging, this entry point will be overridden. For more information, refer to https://aka.ms/vscode-docker-python-debug
EXPOSE 5000
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--log-level", "debug", "--timeout", "120", "app:app"]
