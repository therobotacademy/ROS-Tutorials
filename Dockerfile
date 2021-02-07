FROM ros:melodic-ros-base

# install ros tutorials packages
RUN apt-get update && apt-get install -y \
    ros-melodic-ros-tutorials \
    ros-melodic-common-tutorials \
    python-pip \
    xvfb=2:1.19.6-1ubuntu4.8 \
	x11-apps=7.7+6ubuntu1 \
	netpbm=2:10.0-15.3build1\
    && rm -rf /var/lib/apt/lists/

# npm is needed by Jupyter ROS
RUN apt-get update && apt-get install -y \
    libssl1.0-dev \
    node-gyp\
    nodejs-dev \
    npm \
    wget
RUN npm install -g n
RUN n stable

RUN pip install --upgrade pip

# RUN pip install \
#  notebook==5.6.0 \
#  ipywidgets==7.3.0 \
#  ipykernel==4.8.2 \
#  matplotlib==2.2.2 \
#  jupyterlab==0.33.4

RUN pip install \
  notebook \
  ipywidgets \
  ipykernel \
  matplotlib \
  jupyterlab
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
