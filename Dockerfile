FROM python:3.4

ENV TOOLHOME=/models

RUN pip install tensorflow pillow lxml jupyter pandas matplotlib
RUN apt-get update && apt-get upgrade -y && apt-get install -y  git protobuf-compiler python-pil python-lxml

RUN cd / && git clone https://github.com/tensorflow/models.git

RUN pip install pip -U \
    && pip install jupyter numpy scipy pandas sklearn matplotlib \
    && rm -r /root/.cache/pip

RUN cd $TOOLHOME/research && protoc ./object_detection/protos/*.proto --python_out=.
ENV PYTHONPATH=$PYTHONPATH:$TOOLHOME/research/object_detection:$TOOLHOME/research/slim

RUN cd $TOOLHOME/research && python ./object_detection/builders/model_builder_test.py

WORKDIR notebooks
CMD jupyter-notebook --ip="*" --no-browser --allow-root