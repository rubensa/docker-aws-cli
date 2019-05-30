FROM python:alpine

ARG APP=aws-cli
ARG USER=awscli
ARG GROUP=aws

# Create the home directory for the new app user
RUN mkdir -p /home/$USER

# Create an app user and group so our program doesn't run as root.
RUN addgroup -S $GROUP &&\
    adduser -S -G $GROUP -h /home/$USER -s /sbin/nologin -g "Docker image user" $USER

# Set the home directory to our app user's home
ENV HOME=/home/$USER
ENV APP_HOME=/home/$USER/$APP

# Install requiered software
RUN pip install --no-cache-dir awscli

# Set up the app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Tell docker that all future commands should run as the app user
USER $USER

CMD sh

