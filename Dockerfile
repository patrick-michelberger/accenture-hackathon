FROM python:3.4

ENV TOOLHOME=/models

RUN pip install tensorflow pillow lxml jupyter matplotlib
RUN apt-get update && apt-get upgrade -y && apt-get install -y  git protobuf-compiler python-pil python-lxml

RUN cd / && git clone https://github.com/tensorflow/models.git

RUN cd $TOOLHOME/research && protoc ./object_detection/protos/*.proto --python_out=.
ENV PYTHONPATH=$PYTHONPATH:$TOOLHOME/research/object_detection:$TOOLHOME/research/slim

RUN cd $TOOLHOME/research && python ./object_detection/builders/model_builder_test.py


### Setup flask
RUN pip install flask
COPY src /src/
EXPOSE 5000 
ENTRYPOINT ["python", "/src/app.py"]
