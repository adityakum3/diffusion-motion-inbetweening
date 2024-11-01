echo -e "Downloading glove (in use by the evaluators, not by GMD itself)"
gdown --fuzzy https://drive.google.com/uc?id=1kZIk-4q9lXbkhQPHD5HdiZOO-BF26HC5
rm -rf glove

unzip glove.zip
echo -e "Cleaning\n"
rm glove.zip

echo -e "Downloading done!"