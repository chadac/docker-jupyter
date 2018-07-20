FROM python:2.7-stretch

RUN pip install jupyter pipenv

RUN chmod 777 /home
ENV HOME /home

ADD jupyter_notebook_config.py /.jupyter/jupyter_notebook_config.py
ADD entrypoint.sh /entrypoint.sh

VOLUME ["/ws"]
WORKDIR /ws

EXPOSE 8888

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
