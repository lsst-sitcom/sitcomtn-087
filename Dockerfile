# Use the official Python base image
FROM python:3.10-slim-buster

# Upgrade apt, install git
RUN apt-get update  \
    && apt-get upgrade -y \
    && apt-get install -y git

# Upgrade pip
RUN pip install --upgrade pip

# Set the working directory in the container
WORKDIR /app

# Copy the requirements files into the container
COPY requirements.txt ./
COPY milestones/requirements.txt ./milestones-requirements.txt

# Install the Python dependencies
RUN pip install --no-cache-dir  \
    -r requirements.txt  \
    -r milestones-requirements.txt

# Set the python path
ENV PYTHONPATH="/app:/app/milestones:${PYTHONPATH}"

# Copy the rest of the application code to the container
COPY . /app

# Regernerate the lsst bibliography

# Set the command to run when the container starts
CMD [ "python", "bin/generate_report.py" ]