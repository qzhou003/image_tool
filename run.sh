#!/bin/bash


### params to configure scraper ###

################### Google Search ######################
## What to querry from google search
# search terms seperated by /
querry_list="test qi zhou fiu/test tennis/test admoblize" 

# Each page has 20 pictures by default, pages =25, means 25*20 images will be saved.
pages=25

# ### where to save the qurried picture, each query in the list will be saved in a different folder
path_to_save_images="/Users/qizhou/Documents/DownloadImages/downloadedImages/"

#python Scraper/config.py -q "$querry_list" -s "$path_to_save_images" -p "$pages"



################## To run image selector ###############
IMAGE_SELECTOR_BUILD_DIR=Image_Selector/build
if [ -d "$IMAGE_SELECTOR_BUILD_DIR" ]; then
  	echo 'We found build folder: '"$IMAGE_SELECTOR_BUILD_DIR"
else 
	echo 'We did not find '"$IMAGE_SELECTOR_BUILD_DIR" 'and we just created one!'
	mkdir -p ./Image_Selector/build
fi

# Specify the repository of Admobilize detection manager
ADM_DIR="/Users/qizhou/Documents/Admobilize_detection/admobilize-detection-manager"
if [ -d "$ADM_DIR" ]; then
  	echo 'We found admobilize-detection-manager directory: '"$ADM_DIR"
else 
	echo 'Fatal Error: We did not find '"$ADM_DIR"! 
	echo 'Plese clone the repository at: '
	echo '   https://QiZhou@bitbucket.org/admobilize/admobilize-detection-manager.git' 
fi

cd "$IMAGE_SELECTOR_BUILD_DIR"
cmake -DADM_DIR:string="$ADM_DIR" ..
