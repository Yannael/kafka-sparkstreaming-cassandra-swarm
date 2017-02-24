FROM yannael/spark

RUN yum install -y gcc python-devel

#Instal pip
RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
RUN python get-pip.py

#Install Kafka client for Python
RUN pip install kafka-python

#Install Cassandra
ADD datastax.repo /etc/yum.repos.d/datastax.repo
RUN yum install -y datastax-ddc

#Install Jupyter
RUN pip install jupyter

#Add notebooks and script to create demo Cassandra table
ADD notebooks /root/notebooks
ADD init_cassandra.cql /root/init_cassandra.cql

#Makes alias to start notebook more easily
RUN echo "alias notebook=\"jupyter notebook --ip=* --NotebookApp.open_browser=False --NotebookApp.token=''\"" >> /root/.bashrc

