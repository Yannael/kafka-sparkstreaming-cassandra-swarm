FROM yannael/base-os

#Install Anaconda Python distribution
#RUN wget https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh
#RUN bash Anaconda3-4.2.0-Linux-x86_64.sh -b
#ENV PATH $HOME/anaconda3/bin:$PATH

# Fix the value of PYTHONHASHSEED
# Note: this is needed when you use Python 3.3 or greater
#ENV PYTHONHASHSEED 1

RUN wget http://d3kbcqa49mib13.cloudfront.net/spark-2.1.0-bin-hadoop2.6.tgz \
      && tar -xvzf spark-2.1.0-bin-hadoop2.6.tgz \
      && mv spark-2.1.0-bin-hadoop2.6 spark \
      && rm spark-2.1.0-bin-hadoop2.6.tgz

ENV SPARK_HOME $HOME/spark
ENV PYTHONPATH $SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.4-src.zip:$PYTHON_PATH

ENV PATH $SPARK_HOME/bin:$SPARK_HOME/sbin:$PATH

#ENV PYSPARK_PYTHON=$HOME/anaconda3/bin/python


