#!/bin/bash

REPO_DIR=/Users/qizhou/Documents/DownloadImages/image_tool/  #with "/" to the end please
ADM_DIR=/Users/qizhou/Documents/Admobilize_detection/admobilize-detection-manager
cd $REPO_DIR

### params to configure scraper ###

################### Google Search ######################
echo "========================== Querying Images ================================="
## What to querry from google search
# search terms seperated by /
querry_list="test qi zhou fiu/test tennis/test admoblize" 
# Each page has 20 pictures by default, pages =25, means 25*20 images will be saved.
pages=25
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

#python Scraper/config.py -q "$querry_list" -s "$path_to_save_images" -p "$pages"

############# Create script for the images ################
echo "========================== Creating Script ================================="
cd $REPO_DIR 
image_folder=$REPO_DIR$path_to_save_images
if python Helper/scriptor.py -p $image_folder; then
    echo "Exit code of 0, successfully created the script"
else
    echo "ERROR: Failed to run script.py"
    exit 1;
fi


################## Image Selector #########################`qizhou
# echo "========================== Building Image Selector ========================="
# cd $REPO_DIR 
# IMAGE_SELECTOR_BUILD_DIR=Image_Selector/build
# if [ -d $IMAGE_SELECTOR_BUILD_DIR ]; then
#   	echo 'We found build folder: '$IMAGE_SELECTOR_BUILD_DIR
# else 
# 	echo 'We did not find '$IMAGE_SELECTOR_BUILD_DIR 'and we just created one!'
# 	mkdir -p ./Image_Selector/build
# fi

# # Specify the repository of Admobilize detection manager
# if [ -d $ADM_DIR ]; then
#   	echo 'We found admobilize-detection-manager directory: '$ADM_DIR
# else 
# 	echo 'Fatal Error: We did not find '$ADM_DIR 
# 	echo 'Plese clone the repository at: '
# 	echo '   https://QiZhou@bitbucket.org/admobilize/admobilize-detection-manager.git' 
# fi

# cd $IMAGE_SELECTOR_BUILD_DIR
# cmake -DADM_DIR:string=$ADM_DIR ..
# make


echo "========================== Run Image Selector ========================="
Classified_Images=$REPO_DIR'classified_images'
echo $Classified_Images
if [ ! -d $Classified_Images ];then
    mkdir -p $Classified_Images
fi


