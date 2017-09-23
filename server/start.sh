#!/bin/bash

export FLASK_APP=/src/app.py
python -m flask run --host=0.0.0.0 &
jupyter-notebook --ip="*" --no-browser --allow-root
