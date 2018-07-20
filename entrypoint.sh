#!/bin/bash

if [ ! -f Pipfile ]; then
    pipenv --two
fi

pipenv install
pipenv install --dev ipykernel
pipenv run python -m ipykernel install --user --name=python-pipenv

jupyter notebook --config=/.jupyter/jupyter_notebook_config.py
