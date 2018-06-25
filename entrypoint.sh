#!/bin/bash

if [ ! -f Pipfile ]; then
    pipenv --three
fi

pipenv install
pipenv install --dev ipykernel
pipenv run python -m ipykernel install --user --name=python3-pipenv

jupyter notebook --config=/.jupyter/jupyter_notebook_config.py
