#include <iostream>
#include <fstream>
#include <vector>
#include "opencv2/opencv.hpp"
#include <pico/facedetect.hpp>

using namespace std;
using namespace cv;

int main(int argc, char *argv[])
{
	ifstream file("/Users/qizhou/Documents/DownloadImages/image_selection/images.txt", ifstream::in);
	string destination = "/Users/qizhou/Documents/DownloadImages/image_selection/processed_pics";
	string destination_faces = destination + "/photo_with_faces/";
	string destination_no_faces = destination + "/photo_no_faces/";

	if(!file.is_open()) 
	{
		cout << "Error opening file" << endl;
		return 0;
	}

	string imageFullPath;
	Mat image,oriImage;

	string model ="/Users/qizhou/Documents/Admobilize_detection/admobilize-detection-examples/models1/pico/face-March.dat";
	PicoDetector detector(&image, 10,200,10,model);

	while (getline(file,imageFullPath))
	{
		oriImage = imread(imageFullPath);
		if(oriImage.rows ==0) 
		{
			cout << " Can't find " << imageFullPath << endl; continue;
		}
		if (oriImage.channels() == 3 || oriImage.channels() == 4)
        cvtColor(oriImage, image, COLOR_BGR2GRAY);
		vector<Rect> rects; rects.push_back(Rect(0, 0, image.cols, image.rows));
		std::vector<cv::Rect> detections = detector.run_smartscales_in(rects,0.01);
		imshow("images",image);
		cin.get();
		waitKey(10);

		int index = imageFullPath.find_last_of("/");
        int len = imageFullPath.length();
		if(detections.size()>0)
		{
			ofstream outf;
			string filePath = destination + "/withFaces.txt";
			outf.open(filePath,ios_base::app);
			outf << imageFullPath << endl;
			outf.close();	

            string fileName = imageFullPath.substr(index+1,len-1);
           	string imagePath = destination_faces + '/' +fileName;
           	cout << imagePath << endl;
			imwrite(imagePath,image);

		} else {
			ofstream outf1;
			string filePath = destination + "/noFaces.txt";
			outf1.open(filePath,ios_base::app);
			outf1 << imageFullPath << endl;
			outf1.close();	

			string fileName = imageFullPath.substr(index+1,len-1);
           	string imagePath = destination_no_faces + '/' +fileName;
           	cout << imagePath << endl;
			imwrite(imagePath,image);
		}
	}
	file.close();

	return 0;
}