#! /usr/bin/env python3
# -*- coding: utf-8 -*-

import setuptools

with open("README.md", "r") as infile:
    long_description = infile.read()

setuptools.setup(
    name="mspelling",
    version="0.0.1",
    author="Mario E. Bermonti Perez",
    author_email="mbermonti1132@gmail.com",
    description="Program to measure spelling skills",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/mario-bermonti/computerized-spelling-measure",
    packages=setuptools.find_packages(),
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: GNU General Public License v3 (GPLv3)",
        "Operating System :: OS Independent",
        "Intended Audience :: Science/Research",
    ],
    install_requires=[
        'pandas',
        'numpy',
        'pygame'
    ],
)
