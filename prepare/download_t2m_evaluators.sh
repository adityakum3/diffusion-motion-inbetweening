echo -e "Downloading T2M evaluators"
gdown --fuzzy https://drive.google.com/file/d/1AYsmEG8I3fAAoraT4vau0GnesWBWyeT8/view?usp=drive_link
rm -rf t2m

unzip t2m.zip
echo -e "Cleaning\n"
tar -xvzf ./t2m.tar.gz 
rm ./t2m.tar.gz
mv ./t2m ./t2
mv ./t2/t2m/t2m .
mv ./t2/t2m/kit .
rm -rf ./t2

gdown --fuzzy https://drive.google.com/file/d/1aP-z1JxSCTcUHhMqqdL2wbwQJUZWHT2j/view?usp=sharing
unzip ./condmdi_random_joints.zip -d ./save/condmdi_random_joints
rm ./condmdi_random_joints.zip

gdown --fuzzy https://drive.google.com/file/d/15mYPp2U0VamWfu1SnwCukUUHczY9RPIP/view?usp=sharing
unzip ./condmdi_random_frames.zip -d ./save/condmdi_randomframes
rm ./condmdi_random_frames.zip

gdown --fuzzy https://drive.google.com/file/d/1B0PYpmCXXwV0a5mhkgea_J2pOwhYy-k5/view?usp=sharing
unzip ./condmdi_uncond.zip -d ./save/condmdi_uncond
rm ./condmdi_uncond.zip

echo -e "Downloading done!"