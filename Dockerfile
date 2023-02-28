# install python
FROM python:3.10.4-slim

# copy your local files to your
# docker container
# grab the code
COPY . /app

# update your environment to work
# within the folder you copied your 
# files above into
# go into the code's dir
WORKDIR /app

# /opt: reserved for the installation of add-on application software packages.
# We'll use this to create & store our virtual environment

# Create a virtual environment in /opt
RUN python3 -m venv /opt/venv

# Install requirments to new virtual environment
# requirements.txt must have gunicorn & django
# RUN /opt/venv/bin/pip install -r requirements.txt

RUN /opt/venv/bin/pip install pip --upgrade && \
    /opt/venv/bin/pip install -r requirements.txt
    # /opt/venv/bin/pip install mysqlclient && \
    # /opt/venv/bin/pip install mysqlclient && \
    # chmod +x config/entrypoint.sh

# Run our app
# entrypoint.sh to run our gunicorn instance
# CMD [ "/app/config/entrypoint.sh" ]
CMD /opt/venv/bin/gunicorn cfeblog.wsgi:application --bind "0.0.0.0:8000"