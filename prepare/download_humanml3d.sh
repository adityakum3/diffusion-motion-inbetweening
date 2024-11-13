gdown https://drive.google.com/uc?id=1LlkZRMr18F4N_DpghIdyu8iZ5RxbjP3E
unzip ./HumanML3D.zip
mv ./HumanML3D ./dataset
rm ./HumanML3D.zip
unzip ./dataset/HumanML3D/texts.zip -d ./dataset/HumanML3D
rm ./dataset/HumanML3D/texts.zip

mkdir save/condmdi_randomframes
gdown --fuzzy https://drive.google.com/file/d/15mYPp2U0VamWfu1SnwCukUUHczY9RPIP/view?usp=sharing
unzip ./condmdi_random_frames.zip -d ./save/condmdi_randomframes
rm ./condmdi_random_frames.zip

