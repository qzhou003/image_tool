#include "face_detect.hpp"

// #include <data-helpers.h>
// #include <dataset.h>

#include <opencv2/highgui/highgui.hpp>
#include <string>
#include <iostream>


extern void usage(const std::string &app_name);


void face_detect(int argc, char *argv[])
{
// 	std::string dataset_folder = "/Users/qizhou/Documents/Admobilize_detection/Dataset/";
// 	std::string action;
// 	std::string exp_dataset_file;
// 	if (argc > 1)
// 		action = argv[1];
// 	if (argc > 2)
// 		exp_dataset_file = argv[2];

// 	printf("assuming dataset in '%s'\n", dataset_folder.c_str());

// 	if (action == "pico-detect")
// 	{
// 		if (exp_dataset_file.empty())
// 		{
// 			printf("Ground truth file is not specified\n");
// 			return;
// 		}

// 		int early_stop = INT_MAX;
//         int early_stop_index = 3;
// #ifdef __APPLE__
//         early_stop_index = 4;
// #endif
//         if(argc>early_stop_index)
//             early_stop = atoi(argv[early_stop_index]);
    

// 		int line_no = 0;
// 		std::vector<std::string> lines = gt_file_to_lines(
// 				exp_dataset_file, dataset_folder, line_no);

// 		int lines_total = line_no + int(lines.size());
// 		int samples_total = 0;
// 		int samples_detected = 0;
// 		for (const auto &data_record: lines)
// 		{
// 			auto vals = split(data_record, "\t ");
// 			if (vals.size() != 7)
// 			{
// 				printf("Assuming %d values in line '%s', got %d\n", 7,
// 						data_record.c_str(), int(vals.size()));
// 				continue;
// 			}

// 			print_progress(line_no++, lines_total, 1);
// 			std::string image_name = dataset_folder + "/" + vals[0];
// 			cv::Mat image = cv::imread(image_name, cv::IMREAD_GRAYSCALE);
// 			if (image.empty())
// 			{
// 				printf("Can't read image '%s'\n", vals[0].c_str());
// 				continue;
// 			}
            
//                 PicoDetector detector(&image, 30, 300, 10);
//                 detector.load_cascade("/Users/qizhou/Documents/Admobilize_detection/admobilize-detection-examples/models1/pico/face.dat");
//                 std::vector<cv::Rect> detections = detector.run_smartscales_in(
//                                                                                { cv::Rect(0, 0, image.cols, image.rows) });
//                 //			std::vector<cv::Rect> detections = detector.detect_multiscale(
//                 //					DET_FACE_FRONTAL,
//                 //					cv::Rect(0, 0, image.cols, image.rows),
//                 //					40, 0.1, 0.2);
                
//                 if (detections.size() > 0)
//                     ++ samples_detected;
// 			++samples_total;
// 			if (samples_total >= early_stop)
// 				break;
// 		}
// 		print_percent("TPR: ", samples_detected, samples_total);
// 	}
// 	else
// 	{
// 		printf("unknown action '%s'\n", action.c_str());
// 		usage(argv[0]);
// 	}

	return;
}
