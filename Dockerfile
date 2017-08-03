FROM ubuntu:16.04
MAINTAINER Rollin Thomas <rcthomas@lbl.gov>

ENV DEBIAN_FRONTEND noninteractive
RUN \
    apt-get update          &&  \
    apt-get --yes upgrade   &&  \
    apt-get --yes install       \
        build-essential         \
        gfortran                \
        wget

# Miniconda installer

RUN \
    wget -q https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -O /tmp/miniconda.sh  &&  \
    bash /tmp/miniconda.sh -f -b -p /opt/miniconda2 &&  \
    rm -rf /tmp/miniconda.sh

# Dependencies via conda tool

ENV PATH /opt/miniconda2/bin:$PATH

RUN \
    conda update --yes conda    &&  \
    conda install --yes             \
        asn1crypto                  \
        astropy                     \
        backports                   \
        certifi                     \
        cffi                        \
        click                       \
        cryptography                \
        cycler                      \
        decorator                   \
        flask                       \
        get_terminal_size           \
        gunicorn                    \
        idna                        \
        ipaddress                   \
        ipython                     \
        ipython_genutils            \
        itsdangerous                \
        jinja2                      \
        markupsafe                  \
        matplotlib                  \
        nose                        \
        numpy                       \
        packaging                   \
        path.py                     \
        pathlib2                    \
        pexpect                     \
        pickleshare                 \
        prompt_toolkit              \
        psycopg2                    \
        ptyprocess                  \
        pycairo                     \
        pycparser                   \
        pycrypto                    \
        pygments                    \
        pymongo                     \
        pyopenssl                   \
        pyqt                        \
        python-dateutil             \
        pytz                        \
        pyyaml                      \
        scipy                       \
        simplegeneric               \
        sip                         \
        traitlets                   \
        wcwidth                     \
        werkzeug

# Further dependencies via pip

RUN \
    pip install         \
        APLpy           \
        Flask-Compress  \
        pySLALIB        \
        rsa

# Confine astropy cache and config to container

ENV \
    XDG_CACHE_HOME=/srv/cache   \
    XDG_CONFIG_HOME=/srv/config

RUN \
    mkdir -p $XDG_CACHE_HOME/astropy    &&  \
    mkdir -p $XDG_CONFIG_HOME/astropy   &&  \
    python -c "import astropy"

# Slurp ATC

COPY atc /opt/atc
WORKDIR /opt/atc/app
