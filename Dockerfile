FROM openzim/zimwriterfs:latest

# Install jpegoptim
RUN apt-get install -y libjpeg-dev
RUN wget http://www.kokkonen.net/tjko/src/jpegoptim-1.4.4.tar.gz
RUN tar xvf jpegoptim-1.4.4.tar.gz
RUN cd jpegoptim-1.4.4 && ./configure
RUN cd jpegoptim-1.4.4 && make all install

# Install pngquant
RUN apt-get install -y libpng16-dev
RUN wget http://pngquant.org/pngquant-2.9.0-src.tar.gz
RUN tar xvf pngquant-2.9.0-src.tar.gz
RUN cd pngquant-2.9.0 && ./configure
RUN cd pngquant-2.9.0 && make all install

# Install gifsicle
RUN wget https://www.lcdf.org/gifsicle/gifsicle-1.88.tar.gz
RUN tar xvf gifsicle-1.88.tar.gz
RUN cd gifsicle-1.88 && ./configure
RUN cd gifsicle-1.88 && make all install

# Install npm & nodejs
RUN apt-get install -y python
RUN wget https://nodejs.org/dist/v6.10.1/node-v6.10.1.tar.gz
RUN tar xvf node-v6.10.1.tar.gz
RUN cd node-v6.10.1 && ./configure
RUN cd node-v6.10.1 && make all install

# Configure Redis
RUN apt-get install -y redis-server
RUN echo "" >> /etc/redis/redis.conf
RUN echo "unixsocket /dev/shm/redis.sock" >> /etc/redis/redis.conf 
RUN echo "unixsocketperm 777" >> /etc/redis/redis.conf
RUN echo "save \"\"" >> /etc/redis/redis.conf
RUN echo "appendfsync no" >> /etc/redis/redis.conf

# Install mwoffliner
RUN apt-get install -y nscd
RUN apt-get install -y file
RUN apt-get install -y imagemagick
RUN apt-get install -y advancecomp
RUN npm install -g mwoffliner

# Boot commands
CMD service redis-server restart && /bin/bash