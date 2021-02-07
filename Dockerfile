FROM ros:kinetic-ros-base

# install ros tutorials packages
RUN apt-get update && apt-get install -y \
    ros-kinetic-ros-tutorials \
    ros-kinetic-common-tutorials \
    python-pip \
    xvfb=2:1.18.4-0ubuntu0.11 \
	x11-apps=7.7+5+nmu1ubuntu1 \
	netpbm=2:10.0-15.3\
    && rm -rf /var/lib/apt/lists/

# npm is needed by Jupyter ROS
RUN apt-get update && apt-get install -y npm wget
RUN npm install -g n
RUN n stable

RUN pip install --upgrade pip==18.0

# RUN pip install \
#  notebook==5.6.0 \
#  ipywidgets==7.3.0 \
#  ipykernel==4.8.2 \
#  matplotlib==2.2.2 \
#  jupyterlab==0.33.4

RUN pip install notebook ipywidgets ipykernel matplotlib jupyterlab
# Enable extensions in Jupyter Notebooks
RUN jupyter nbextension enable --py widgetsnbextension

# Install Jupyter-ROS dependecies
RUN pip install bqplot pyyaml

# Install Jupyter-ROS extension
# https://github.com/RoboStack/jupyter-ros

# Install the extension for jupyter
RUN pip install jupyros
#RUN jupyter nbextension enable --py labextension

# To install the extension for jupyterlab, you also need to execute the following:
RUN jupyter labextension install jupyter-ros

# Build jupyterlab
RUN jupyter lab build

ENV NB_USER gopigo
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
RUN chown -R ${NB_UID} ${HOME}

USER ${NB_USER}
WORKDIR ${HOME}

CMD ["jupyter", "lab", "--no-browser", "--ip", "0.0.0.0","--allow-root"]
