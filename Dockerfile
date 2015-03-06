FROM ubuntu
MAINTAINER  kuenstner@gmail.com

RUN apt-get update && apt-get -y install wget zsh unzip vim curl git
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh && \
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

# ES
RUN wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add - && \
    echo "deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main" >> /etc/apt/sources.list && \
    echo "deb http://packages.elasticsearch.org/logstash/1.4/debian stable main" >> /etc/apt/sources.list

RUN apt-get update && apt-get -y install elasticsearch openjdk-7-jre logstash redis-server nginx

RUN /usr/share/elasticsearch/bin/plugin -install elasticsearch/marvel/latest

# Kibana
RUN wget https://download.elasticsearch.org/kibana/kibana/kibana-4.0.1-linux-x64.tar.gz && \
    tar -xvf kibana-4.0.1-linux-x64.tar.gz

# Populate Nginx
RUN wget https://github.com/IronSummitMedia/startbootstrap-stylish-portfolio/archive/v1.0.2.zip && \
    unzip v1.0.2.zip && rm -rf /usr/share/nginx/html/* && \
    mv startbootstrap-stylish-portfolio-1.0.2/* /usr/share/nginx/html/ && \
    rm -rf /startbootstrap-stylish-portfolio-1.0.2

ADD logstash/syslog_shipper.conf /etc/logstash/conf.d/syslog_shipper.conf
ADD logstash/syslog_indexer.conf /etc/logstash/conf.d/syslog_indexer.conf
ADD elasticsearch/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
ADD logstash/nginx /opt/logstash/patterns/nginx
RUN chown logstash:logstash /opt/logstash/patterns/nginx

ADD startup.sh startup.sh
