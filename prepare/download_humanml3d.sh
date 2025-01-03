gdown https://drive.google.com/uc?id=1LlkZRMr18F4N_DpghIdyu8iZ5RxbjP3E
unzip ./HumanML3D.zip
mv ./HumanML3D ./dataset
rm ./HumanML3D.zip
unzip ./dataset/HumanML3D/texts.zip -d ./dataset/HumanML3D
rm ./dataset/HumanML3D/texts.zip

mkdir save
mkdir save/condmdi_randomframes
gdown --fuzzy https://drive.google.com/file/d/15mYPp2U0VamWfu1SnwCukUUHczY9RPIP/view?usp=sharing
unzip ./condmdi_random_frames.zip -d ./save/condmdi_randomframes
rm ./condmdi_random_frames.zip

gdown --fuzzy https://drive.google.com/file/d/1BWlzD2kXZeqZpbzMfCS2qZIQa3CZpErc/view?usp=drive_link
unzip "./Archive (1).zip" 
rm -rf "./Archive (1).zip"
mv ./dataset/HumanML3D/new_joints/012314.npy ./new_joints
mv ./dataset/HumanML3D/new_joint_vecs/012314.npy ./new_joint_vecs
rm -rf ./dataset/HumanML3D/new_joints
rm -rf ./dataset/HumanML3D/new_joint_vecs
mv ./new_joints ./dataset/HumanML3D/new_joints
mv ./new_joint_vecs ./dataset/HumanML3D/new_joint_vecs