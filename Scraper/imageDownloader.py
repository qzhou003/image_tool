from bs4 import BeautifulSoup
import requests
import re
import urllib2
import os
from timeout import timeout


def get_soup(url,header):
    return BeautifulSoup(urllib2.urlopen(urllib2.Request(url,headers=header)),"lxml")

image_type = ""

@timeout(5)
def readURL(img):
	return urllib2.urlopen(img).read();


def start(query_list,path_to_save_images,pages):
	print("starting downloading")
	for ori_query in query_list:
		print "=========================="
		print "Now querying : ", ori_query
		print "=========================="
		query = ori_query;
		query= query.split()
		query='+'.join(query)
		for iteration in range(0,pages):
			paginate = 20*iteration
			url=url="https://www.google.co.in/search?q="+query+"&source=lnms&tbm=isch&start="+str(paginate);
			print ("page = %d" %iteration)
			header = {'User-Agent': 'Mozilla/5.0'} 
			soup = get_soup(url,header)
			images = [a['src'] for a in soup.find_all("img", {"src": re.compile("gstatic.com")})]
			#print images
			for img in images:
			  raw_img = readURL(img) 
			  #add the directory for your image here 
			  ori_query = ori_query.replace (" ", "_")
			  DIR=path_to_save_images+ori_query+"/";
			  if not os.path.exists(DIR):
		   			 os.makedirs(DIR)
			  cntr = len([i for i in os.listdir(DIR) if image_type in i]) + 1
			  thres = pages*20
			  if cntr > thres: continue
			  try:
			  		f = open(DIR + ori_query + "_"+ str(cntr)+".jpg", 'wb')
			  except ValueError:
			  		print "Ooops! Cannot not open" + DIR + ori_query + "_"+ str(cntr)+".jpg"
			  f.write(raw_img)
			  f.close()