FROM mattsch/fedora-rpmfusion:latest
MAINTAINER Matthew Schick <matthew.schick@gmail.com>

# Install required packages
RUN dnf install -yq gcc \
                    git \
                    pyOpenSSL \
                    python-paramiko \
                    python-pillow \
                    python-devel \
                    python-pip \
                    procps-ng \
                    smartmontools \
                    zlib-devel && \
    dnf clean all

# Set uid/gid (override with the '-e' flag), 1000/1000 used since it's the
# default first uid/gid on a fresh Fedora install
ENV LUID=1000 LGID=1000

# Create the htpc user/group
RUN groupadd -g $LGID htpc && \
    useradd -c 'HTPC User' -s /bin/bash -m -d /opt/htpc -g $LGID -u $LUID htpc
    
# Grab the installer, do the thing
RUN git clone -q https://github.com/Hellowlol/HTPC-Manager.git /opt/htpc/app && \
    chown -R htpc:htpc /opt/htpc

RUN cd /opt/htpc/app && pip install -r requirements.txt

# Need a config and storage volume, expose proper port
VOLUME /config /storage
EXPOSE 5050

# Add script to copy default config if one isn't there and start htpc
COPY run-htpc.sh /bin/run-htpc.sh
 
# Run our script
CMD ["/bin/run-htpc.sh"]


