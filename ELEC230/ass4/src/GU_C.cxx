#include <opencv2/imgproc.hpp>
#include <opencv2/highgui.hpp>

using namespace cv;

Mat original = imread(samples::findFile("door.jpeg"), IMREAD_COLOR);
Mat smoothed (original.size(), CV_8UC3);
Mat edges    (original.size(), CV_8UC1);

//https://docs.opencv.org/3.4/da/d5c/tutorial_canny_detector.html
static void
canny(int /*unused*/, void* /*unused*/) {

    // It is safe to assume values are positive or zero because they are from trackbars.
    int gaussian_ksize  = getTrackbarPos("gaussian_ksize" , "Trackbars");
    int gaussian_sigmaX = getTrackbarPos("gaussian_sigmaX", "Trackbars");
    int gaussian_sigmaY = getTrackbarPos("gaussian_sigmaY", "Trackbars");
    // ksize should be odd, or sigmaX should not be zero when ksize is zero
    if ( gaussian_ksize % 2 == 1 || (gaussian_ksize == 0 && gaussian_sigmaX != 0) ) {
        GaussianBlur(original, smoothed, Size(gaussian_ksize, gaussian_ksize), gaussian_sigmaX, gaussian_sigmaY);
    }

    Mat grayscale;
    cvtColor(smoothed, grayscale, COLOR_BGR2GRAY);

    int canny_ksize    = getTrackbarPos("canny_ksize"   , "Trackbars");
    int canny_lowthres = getTrackbarPos("canny_lowthres", "Trackbars");
    // aperture size should be odd between 3 and 7, and ksize should be odd
    if ( 3 <= canny_ksize && canny_ksize <= 7 && canny_ksize % 2 == 1 ) {
        Canny(grayscale, edges, canny_lowthres, 3*canny_lowthres, canny_ksize);
        imshow("Canny Edge Detection", edges);
    }
}

int main() {

    if ( original.empty() ) {
        return EXIT_FAILURE;
    }
    imshow("Original", original);

    namedWindow("Trackbars", WINDOW_AUTOSIZE);
    createTrackbar("gaussian_ksize" , "Trackbars", nullptr, 50, canny);
    createTrackbar("gaussian_sigmaX", "Trackbars", nullptr, 15, canny);
    createTrackbar("gaussian_sigmaY", "Trackbars", nullptr, 15, canny);
    createTrackbar("canny_lowthres" , "Trackbars", nullptr, 999, canny);
    createTrackbar("canny_ksize"    , "Trackbars", nullptr, 7, canny);
    setTrackbarPos("gaussian_ksize" , "Trackbars", 3);
    setTrackbarPos("gaussian_sigmaX", "Trackbars", 0);
    setTrackbarPos("gaussian_sigmaY", "Trackbars", 0);
    setTrackbarPos("canny_lowthres" , "Trackbars", 50);
    // Aperture size should be odd between 3 and 7 in function 'Canny'
    setTrackbarPos("canny_ksize", "Trackbars", 3);
    setTrackbarMin("canny_ksize", "Trackbars", 3);
    setTrackbarMax("canny_ksize", "Trackbars", 7);
    
    waitKey();
}