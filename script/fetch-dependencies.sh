#!/bin/sh

# serverless-chrome
wget https://github.com/adieuadieu/serverless-chrome/releases/download/v1.0.0-37/stable-headless-chromium-amazonlinux-2017-03.zip
unzip stable-headless-chromium-amazonlinux-2017-03.zip -d scraper/bin/
rm stable-headless-chromium-amazonlinux-2017-03.zip

# chromedriver
wget https://chromedriver.storage.googleapis.com/2.37/chromedriver_linux64.zip
unzip chromedriver_linux64.zip -d scraper/bin/
rm chromedriver_linux64.zip
