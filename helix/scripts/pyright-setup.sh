#!/bin/bash

if [[ $VIRTUAL_ENV ]]; then
  python_path="${VIRTUAL_ENV}/bin/python"
else
  python_path="python"
fi

export PYTHONPATH=python_path

pyright-langserver --stdio