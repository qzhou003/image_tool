#!/usr/bin/python

import sys, getopt
from imageDownloader import *

### params to configure scraper

# ### What to querry from google search
# query_list = [
#           "people with sunglasses",
#           "asian people",
#           "asian",
#           "sunglasses human",
#           "faces sunglasses",
#           "asian faces",
#           "chinese faces",
#           "smile asian faces",
#         ]

# ### Each page has 20 pictures by default, pages =25, means 25*20 images will be saved.
# pages = 25

# ### where to save the qurried picture, each query in the list will be saved in a different folder
# path_to_save_images = "/Users/qizhou/Documents/DownloadImages/downloadedImages/"

query_list = []
pages = 25
path_to_save_images = "2"

def main(argv):
   try:
      opts, args = getopt.getopt(argv,"hq:s:p:",["querry_list=","path_to_save_images=","pages="])
   except getopt.GetoptError:
      print 'config.py -q <querry_list> -s <path_to_save_images> -p <pages>'
      sys.exit(2)
   for opt, arg in opts:
      if opt == '-h':
         print 'config.py -q <querry_list> -s <path_to_save_images> -p <pages>'
         sys.exit()
      elif opt in ("-q", "--querry_list"):
         query_list = arg.split('/')
      elif opt in ("-s", "--path_to_save_images"):
         path_to_save_images = arg
      elif opt in ("-p", "--pages"):
          pages = arg
   print("############### Config variables ############")
   print "querry_list contains : " 
   for p in query_list: print "\t",p
   print 'path_to_save_images is ', path_to_save_images
   print 'pages : ', pages
   print("############## End of Config ################\n")
   start(query_list,path_to_save_images,int(pages))   


if __name__ == "__main__":
   main(sys.argv[1:])


