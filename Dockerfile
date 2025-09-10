FROM continuumio/miniconda3:latest

# Install all packages
RUN apt update 

RUN apt-get install nodejs npm python3 python3-pip git nano --yes

RUN npm install -g configurable-http-proxy

RUN apt-get install gcc python3-dev --yes

RUN python3 -m pip install pip --upgrade

RUN conda install -c conda-forge jupyterhub

RUN conda install -c conda-forge jupyterlab

RUN conda install -c conda-forge notebook

RUN conda install -c conda-forge scikit-learn

RUN conda install -c conda-forge scikit-image

RUN conda install -c conda-forge scipy

RUN conda install -c conda-forge numpy

RUN conda install -c conda-forge nbgrader

RUN conda install -c conda-forge fuzzywuzzy

RUN python3 -m pip install jupyterhub-nativeauthenticator

RUN python3 -m pip install RISE

RUN python3 -m pip install nbgrader

RUN jupyter nbextension install --sys-prefix --py nbgrader --overwrite
RUN jupyter nbextension enable --sys-prefix --py nbgrader
RUN jupyter serverextension enable --sys-prefix --py nbgrader
RUN jupyter nbextension disable --sys-prefix course_list/main --section=tree
RUN jupyter serverextension disable --sys-prefix nbgrader.server_extensions.course_list

RUN mkdir -p /srv/jupyterhub/

# Copy the JupyterHub configuration in the container
COPY jupyterhub_config.py /srv/jupyterhub

WORKDIR /srv/jupyterhub/

CMD ["jupyterhub", "-f", "/srv/jupyterhub/jupyterhub_config.py"]