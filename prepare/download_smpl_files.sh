mkdir -p body_models
cd body_models/

echo -e "The smpl files will be stored in the 'body_models/smpl/' folder\n"
gdown --fuzzy https://drive.google.com/file/d/1eriuZiQO_y-HOxsUtsJ-owR7yCYKdOHv/view?usp=sharing
rm -rf smpl

unzip smpl.zip
echo -e "Cleaning\n"
rm smpl.zip

echo -e "Downloading done!"