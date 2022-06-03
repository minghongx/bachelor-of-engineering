#include <opencv2/highgui.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/imgproc.hpp>

using namespace cv;

int main () {
    Mat original = imread(samples::findFile("../door.jpeg"), IMREAD_COLOR);
    if ( original.empty() ) {
        return EXIT_FAILURE;
    }
    imshow("Original", original);

    Mat smoothed (original.size(), CV_8UC3);
    double sigma = -1;
    while (true) {
        GaussianBlur(original, smoothed, Size(9, 9), sigma, sigma);
        cv::putText(smoothed, format("sigma equals %.1f", sigma), cv::Point(20,40), cv::FONT_HERSHEY_DUPLEX, 1, cv::Scalar(0,255,0));
        imshow("Smoothed", smoothed);

        char key = (char)waitKey(0);
        if (key == 'q') {
            return EXIT_SUCCESS;
        }
        if (key == 's') {
            sigma = sigma == -1 ? 0.2 : -1;
        }
    }
}