# ===============================
# Dockerfile for the Airflow conteiners
# Author: Marcelo Martins
# Usage: This script creates the image that will be used in the main Airflow componentes (scheduler, webserver, etc.)
# ===============================

# Default image for Astro CLI
FROM quay.io/astronomer/astro-runtime:12.6.0

# Change to root to allow the git installation
USER root

# Git installation
RUN apt-get update && apt-get install -y git && apt-get clean

# Default user for Astro CLI
USER astro