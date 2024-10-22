echo -e "Downloading T2M evaluators"
!gdown --fuzzy https://drive.google.com/file/d/1AYsmEG8I3fAAoraT4vau0GnesWBWyeT8/view?usp=drive_link
rm -rf t2m

unzip t2m.zip
echo -e "Cleaning\n"
!tar -xvzf ./t2m.tar.gz 
!rm ./t2m.tar.gz
!mv ./t2m ./t2
!mv ./t2/t2m/t2m .
!mv ./t2/t2m/kit .
!rm -rf ./t2

echo -e "Downloading done!"