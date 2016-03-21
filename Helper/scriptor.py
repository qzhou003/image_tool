# http://stackoverflow.com/questions/3964681/find-all-files-in-directory-with-extension-txt-in-python
import glob, os, sys, getopt
c = 1

image_path = ""
scriptor_path = os.path.dirname(os.path.realpath(__file__))

def parseArg(argv):
	try:
		opts, args = getopt.getopt(argv,"hp:",["image_path="])
	except getopt.GetoptError:
		print 'scriptor.py -p <image_path>'
		sys.exit(2) # command error
	for opt,arg in opts:
		if opt == '-h':
			print "scriptor.py -p <image_path>"
		elif opt in ("-p","--image_path"):
			global image_path
			image_path = arg

def printImagePath():
	print("The folder containing folders of photos is specified as: ")
	print '\t', image_path

def createScriptForOneFolder(sub_dir):
	global scriptor_path
	os.chdir(scriptor_path)
	f = open("images.txt", "a")
	os.chdir(sub_dir)
	global c
	local_c = c
	types = ('*.jpg', '*.JPG','*.png','*.JPEG')
	images_grabbed = []
	for images in types:
		images_grabbed.extend(glob.glob(images))

	for file in images_grabbed:
		image_full_path = os.path.join(sub_dir,file)
		f.write(image_full_path+ '\n')
		c = c+1
	f.close()
	 # print "sub_dir : ", sub_dir
	print "has ", c-local_c, " images"

def createScript():
	for root, dirs, files in os.walk(image_path):
		for name in dirs:
			sub_dir = os.path.join(root, name)
			print sub_dir
			createScriptForOneFolder(sub_dir)

if __name__ == "__main__":
	parseArg(sys.argv[1:])
	printImagePath()
	createScript();
	print "There are total ", c, " iamges written in "+scriptor_path +"/images.txt!"
