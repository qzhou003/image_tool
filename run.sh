#!/bin/bash

#---------------------------------Variables to be configured------------------------------
# The directory of the image_tool repo
REPO_DIR=/Users/qizhou/Documents/DownloadImages/image_tool/  #with "/" to the end please
# The directory of admobilize detection manager repo
ADM_DIR=/Users/qizhou/Documents/Admobilize_detection/admobilize-detection-manager
# The face model will be used to do face detection for image selection purpose
MODEL=/Users/qizhou/Documents/Admobilize_detection/admobilize-detection-examples/models1/pico/face-March.dat
# To indicate if you want to build the admobilize detection manager or not
BUILD_IMAGE_SELECTOR=1
### params to configure scraper ###
################### Google Search ######################
echo "========================== Querying Images ================================="
cd $REPO_DIR
## What to querry from google search
# search terms seperated by /
querry_list="asians/chinese star/chinese people/asian people/japan faces/korean faces" 
# Each page has 20 pictures by default, pages =25, means 25*20 images will be saved.
pages=20
# The above variables need to be configured before run.
#---------------------------------------end of variable configuration------------------------------------------

# ### pictures will be saved in a folder called Downloaded_Images, each query in the list will be saved in a different folder
path_to_save_images=Downloaded_Images
if [ -d $path_to_save_images ];then
	version=1;
	path_to_save_images+='_';
	while [ -d $path_to_save_images$version ]; do
		((version++))
	done
	path_to_save_images=$path_to_save_images$version'/'
fi
mkdir -p $path_to_save_images
echo $REPO_DIR$path_to_save_images
python Scraper/config.py -q "$querry_list" -s $REPO_DIR$path_to_save_images -p $pages

############# Create script for the images ################
echo "========================== Creating Script ================================="
cd $REPO_DIR 
image_folder=$REPO_DIR$path_to_save_images
if python Helper/scriptor.py -p $image_folder; then
    echo "Exit code of 0, successfully created the script: images.txt "
else
    echo "ERROR: Failed to run script.py"
    exit 1;
fi

################## Image Selector #########################
if $BUILD_IMAGE_SELECTOR; then
	echo "========================== Building Image Selector ========================="
	cd $REPO_DIR 
	IMAGE_SELECTOR_BUILD_DIR=Image_Selector/build
	if [ -d $IMAGE_SELECTOR_BUILD_DIR ]; then
	  	echo 'We found build folder: '$IMAGE_SELECTOR_BUILD_DIR
	else 
		echo 'We did not find '$IMAGE_SELECTOR_BUILD_DIR 'and we just created one!'
		mkdir -p ./Image_Selector/build
	fi

	# Specify the repository of Admobilize detection manager
	if [ -d $ADM_DIR ]; then
	  	echo 'We found admobilize-detection-manager directory: '$ADM_DIR
	else 
		echo 'Fatal Error: We did not find '$ADM_DIR 
		echo 'Plese clone the repository at: '
		echo '   https://QiZhou@bitbucket.org/admobilize/admobilize-detection-manager.git' 
	fi
fi

cd $IMAGE_SELECTOR_BUILD_DIR
cmake -DADM_DIR:string=$ADM_DIR ..
make

echo "========================== Run Image Selector ========================="
cd $REPO_DIR
processed_photo=Classified_Images
echo $Classified_Images
if [ ! -d $processed_photo ];then
    mkdir -p $processed_photo
    mkdir -p $processed_photo'/photo_with_faces/'
    mkdir -p $processed_photo'/photo_no_faces/'
    echo "A folder named "$processed_photo" and two subdirectories were created."
fi

#  Usage: %s <path_of_image_script> <path_to_save_precessed_images>
echo $REPO_DIR'Helper/images.txt'
./Image_Selector/build/face-select $REPO_DIR'Helper/images.txt' $REPO_DIR$processed_photo $MODEL



