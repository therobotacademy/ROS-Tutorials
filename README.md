# Jupyter contrib. extensions
To install the https://github.com/RoboStack/jupyter-ros`jupyter_contrib_nbextensions` package with this command on the terminal window:
```
$ conda install -c conda-forge jupyter_contrib_nbextensions
```
Once the package is installed, we can start jupyter notebook using:
```
$ jupyter notebook
```
Once you go to the home page of your jupyter notebook, you can see that a new tab for `NBExtensions` is created.

# ROS-Tutorials
## ROS Tutorial Jupyter Notebooks

Find updated Binder instance in HERE --> [Click me ![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/therobotacademy/ROS-Tutorials/master)

This is the Binder instance of the original repo ____  [![Binder](https://mybinder.org/badge.svg)](https://mybinder.org/v2/gh/RobInLabUJI/ROS-Tutorials/master?urlpath=lab)

corresponding to repository [Source repo](https://github.com/RobInLabUJI/ROS-Tutorials)

Find the paper describing this methodology for teaching ROS at file `Interactive ROS Tutorials with Jupyter Notebooks.pdf`
or at [CEUR Workshop Proceedings (CEUR-WS.org)](http://ceur-ws.org/Vol-2329/paper-01.pdf)

## Build and run locally
```
$ docker build -t jupyterlab-ros-tutorials --file Dockerfile.init .
$ docker run --rm -it -p 8888:8888 jupyterlab-ros-tutorials:latest
```

# ROS Support for jupyter notebooks
### https://github.com/RoboStack/jupyter-ros
```
$ docker build -t jupyterlab-robostack .
$ docker run --rm -it --name jupyteros -p 8888:8888 jupyterlab-ros-tutorials:latest
```

# TRY THIS DOCKERIZED INSTALLATION

https://github.com/frankzickert/jupyterlab-configuration