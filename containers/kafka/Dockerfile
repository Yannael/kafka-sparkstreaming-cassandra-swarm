FROM yannael/base-os

#Install Kafka
RUN wget http://apache.belnet.be/kafka/0.10.1.1/kafka_2.11-0.10.1.1.tgz
RUN tar xvzf kafka_2.11-0.10.1.1.tgz
RUN mv kafka_2.11-0.10.1.1 kafka

ENV PATH $HOME/kafka/bin:$PATH

#Startup (start SSH, Kafka)
ADD startup_script.sh /usr/bin/startup_script.sh
RUN chmod +x /usr/bin/startup_script.sh

