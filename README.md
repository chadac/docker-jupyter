# Docker container for Jupyter with Pipenv

For those that need a Docker instance for running local Jupyter
servers. Useful if you have sensitive data on your machine that only
you need to access, and you have comfort using
[docker-compose](https://docs.docker.com/compose/). Also, since the
notebook is containerized and only installs dependencies from your
`Pipfile`, is a great way to track what dependencies are being used
from source control.

I'm working on making the Jupyter container as configurable as
possible.

**NOTE:** This container does change your `Pipfile`! It will install
`ipykernel` (as a dev dependency) in order to link the kernel to
Jupyter.

## Setup

Optionally, you should have [pipenv](https://github.com/pypa/pipenv)
installed.

Initialize a new project in your desired directory with

    pipenv --three

You will also need to export your UID (on Mac) or assign your UID to
your user ID (Linux) in order for the container to write to your local
volume as a non-root user. On Mac, this is:

    export UID

Then, add a `docker-compose.yml` with the following service:

    jupyter:
      image: cacrawford/jupyter
      volumes:
        - .:/ws
      user: $UID
      environment:
        ## needs to be a hashed password
        ## generate with (assuming jupyter is installed)
        ##   from notebook.auth import passwd()
        ##   passwd()
        ## if left empty, the notebook will generate a token which you can find with
        ##   docker-compose logs -f jupyter
        - NOTEBOOK_PASSWORD=YOUR_HASHED_PASSWORD
      ports:
        - "127.0.0.1:8888:8888"           # restricts this notebook to the host machine

If your `Pipfile` has a lot of dependencies, this may take a bit to start up.

## Usage

Make sure that any notebook you have uses the `python3-pipenv` kernel,
otherwise your dependencies won't be included.

In order to install new dependencies on the container, run

    docker-compose exec jupyter pipenv install <packages>

This will update your local pipenv file but only install packages on
the container machine.
