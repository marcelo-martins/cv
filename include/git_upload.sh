#!/bin/sh

set - e # Exit on first error

# ===============================
# Upload file to GitHub
# Author: Marcelo Martins
# Usage: This script automates pushing a file (in this case, a PDF) to a GitHub repository.
# Environment Variables:
#   - FILE_NAME: The LaTeX/PDF file name (without extension)
#   - TIMEZONE: The timezone for timestamps
#   - GIT_REPO: The GitHub repository URL
#   - GIT_EMAIL: GitHub email for commits
# ===============================

PDF_PATH=latex/output/$FILE_NAME.pdf
TIMESTAMP=$(TZ="$TIMEZONE" date +"%Y-%m-%d %H:%M:%S")

echo "Starting the upload to github"

mkdir /tmp/repocv
cd /tmp/repocv

echo "Cloning Repository $GIT_REPO"
git clone $GIT_REPO .
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to clone repository. Exiting..."
    exit 1
fi

git config --global user.email "$GIT_EMAIL"
git config --global user.name 'Airflow Bot'
cp /usr/local/airflow/$PDF_PATH /tmp/repocv
git add $FILE_NAME.pdf
git commit -m "Updated CV from Airflow on $TIMESTAMP"
git push origin main
rm /usr/local/airflow/$PDF_PATH
rm -rf /tmp/repocv