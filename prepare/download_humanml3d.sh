!gdown https://drive.google.com/uc?id=1LlkZRMr18F4N_DpghIdyu8iZ5RxbjP3E
!unzip ./HumanML3D.zip
!mv ./HumanML3D ./dataset
!rm ./HumanML3D.zip
!unzip ./dataset/HumanML3D/texts.zip -d ./dataset/HumanML3D
!rm ./dataset/HumanML3D/texts.zip
gdown --fuzzy https://drive.google.com/file/d/1aP-z1JxSCTcUHhMqqdL2wbwQJUZWHT2j/view?usp=sharing
unzip ./condmdi_random_joints.zip -d ./save/condmdi_random_joints
rm ./condmdi_random_joints.zip

gdown --fuzzy https://drive.google.com/file/d/15mYPp2U0VamWfu1SnwCukUUHczY9RPIP/view?usp=sharing
unzip ./condmdi_random_frames.zip -d ./save/condmdi_randomframes
rm ./condmdi_random_frames.zip

gdown --fuzzy https://drive.google.com/file/d/1B0PYpmCXXwV0a5mhkgea_J2pOwhYy-k5/view?usp=sharing
unzip ./condmdi_uncond.zip -d ./save/condmdi_uncond
rm ./condmdi_uncond.zip
!rm ./HumanML3D.zip