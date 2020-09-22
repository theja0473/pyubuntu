FROM ubuntu:18.04

# set environmental variables
ENV PYENV_ROOT="/root/.pyenv" \
	PATH="/root/.pyenv/shims:/root/.pyenv/bin:${PATH}" \
	PIPENV_YES=1 \
	PIPENV_DONT_LOAD_ENV=1 \
	LC_ALL="C.UTF-8" \
	LANG="en_US.UTF-8"

# install pyenv
RUN apt-get update && \
    apt-get install -y git mercurial build-essential libssl-dev libbz2-dev zlib1g-dev libffi-dev libreadline-dev libsqlite3-dev curl && \
curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash

# install python 3.7.0 system wide
RUN pyenv install 3.7.0
RUN pyenv global 3.7.0
RUN pyenv rehash

# install pipenv
RUN pip install pipenv

COPY . /app
WORKDIR /app

RUN pipenv install --deploy --ignore-pipfile

EXPOSE 8000
