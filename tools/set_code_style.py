#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#-
# set_code_style.py
#
# Created by vamirio on 2022 Aug 30
#-

import sys
import subprocess
import os

import pylib.base

if not pylib.base.check_args_num(sys.argv, 2):
    exit(1)

project_root = pylib.base.find_project_root(sys.argv[2])
if project_root == "":
    print("Error: can't find the root directory of project, check if a",
            pylib.base.project_root_flag, "file/directory in it.")
    exit(1)

style_file = os.path.join(project_root, ".clang-format")
if os.path.exists(style_file):
    print("Warn:", style_file,
          "is already exists, remove it if you want to reset the code style.")
    exit(1)
subprocess.run(["cp", sys.argv[1], style_file])