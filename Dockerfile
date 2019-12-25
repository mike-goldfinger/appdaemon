FROM balenalib/armv7hf-debian-python:latest-buster-run

# Environment vars we can configure against
# But these are optional. So we won't define them now
#ENV HA_URL http://hass:8123
#ENV HA_KEY secret_key
#ENV DASH_URL http://hass:5050
#ENV EXTRA_CMD -D DEBUG

# API Port
EXPOSE 5050 

# Mountpoints for configuration & certificates
VOLUME /conf
VOLUME /certs

# Copy appdaemon into image
WORKDIR /usr/src/app
COPY . .

RUN install_packages python3-dev \
	curl \
	tzdata \
	gcc \
	libffi-dev \
	python3-pip \
	python3-setuptools

# Fix for current dev branch
RUN pip3 install --no-cache-dir python-dateutil

# Install dependencies
#RUN apt-get install gcc libffi-dev \
RUN pip3 install --no-cache-dir .

# Install additional packages
#RUN apt-get install curl

# Start script
RUN chmod +x /usr/src/app/dockerStart.sh
ENTRYPOINT ["./dockerStart.sh"]
