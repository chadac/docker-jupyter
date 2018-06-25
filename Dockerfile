FROM python:3.6-stretch

RUN pip3 install jupyter pipenv

RUN chmod 777 /home
ENV HOME /home

ADD jupyter_notebook_config.py /.jupyter/jupyter_notebook_config.py
ADD entrypoint.sh /entrypoint.sh

VOLUME ["/ws"]
WORKDIR /ws

EXPOSE 8888

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
