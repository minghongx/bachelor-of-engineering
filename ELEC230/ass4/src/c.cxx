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
    // blur(original, smoothed, Size(7, 7));
    GaussianBlur(original, smoothed, Size(7, 7), 0);

    Mat grayscale;
    cvtColor(smoothed, grayscale, COLOR_BGR2GRAY);

    Mat edges (original.size(), CV_8UC1);
    Sobel(grayscale, edges, CV_64F, 1, 1, 7);
    imshow("Sobel", edges);

    waitKey(0);
}