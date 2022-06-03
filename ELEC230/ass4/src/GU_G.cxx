#include <opencv2/imgproc.hpp>
#include <opencv2/highgui.hpp>

using namespace cv;

Mat original = imread(samples::findFile("door.jpeg"), IMREAD_COLOR);
Mat smoothed (original.size(), CV_8UC3);

//https://docs.opencv.org/4.x/dc/dd3/tutorial_gausian_median_blur_bilateral_filter.html
static void
gaussian_filter(int /*unused*/, void* /*unused*/) {
    // It is safe to assume values are positive or zero because they are from trackbars
    int ksize  = getTrackbarPos("ksize" , "Gaussian Filter");
    int sigmaX = getTrackbarPos("sigmaX", "Gaussian Filter");
    int sigmaY = getTrackbarPos("sigmaY", "Gaussian Filter");
    // ksize should be odd, or sigmaX should not be zero when ksize is zero
    if ( ksize % 2 == 1 || ( ksize == 0 && sigmaX != 0 ) ) {
        GaussianBlur(original, smoothed, Size(ksize, ksize), sigmaX, sigmaY);
        imshow("Smoothed", smoothed);
    }
}

int main() {

    if ( original.empty() ) {
        return EXIT_FAILURE;
    }
    imshow("Original", original);

    namedWindow("Gaussian Filter", WINDOW_AUTOSIZE);
    createTrackbar("ksize" , "Gaussian Filter", nullptr, 50, gaussian_filter);
    createTrackbar("sigmaX", "Gaussian Filter", nullptr, 15, gaussian_filter);
    createTrackbar("sigmaY", "Gaussian Filter", nullptr, 15, gaussian_filter);
    setTrackbarPos("ksize" , "Gaussian Filter", 3);
    setTrackbarPos("sigmaX", "Gaussian Filter", 0);
    setTrackbarPos("sigmaY", "Gaussian Filter", 0);

    waitKey();
}