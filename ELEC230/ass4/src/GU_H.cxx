#include <opencv2/imgproc.hpp>
#include <opencv2/highgui.hpp>
#include <cmath>

using namespace cv;

Mat original = imread(samples::findFile("door.jpeg"), IMREAD_COLOR);
//https://stackoverflow.com/questions/27183946/what-does-cv-8uc3-and-the-other-types-stand-for-in-opencv
Mat smoothed (original.size(), CV_8UC3);
Mat edges    (original.size(), CV_8UC1);

//https://docs.opencv.org/3.4/d6/d10/tutorial_py_houghlines.html
//https://docs.opencv.org/3.4/d9/db0/tutorial_hough_lines.html
static void
houghlines(int /*unused*/, void* /*unused*/) {

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
    }

    int hough_thres = getTrackbarPos("hough_thres", "Trackbars");
    Mat hough; cvtColor(edges, hough, COLOR_GRAY2BGR);
    std::vector<Vec2f> lines;
    HoughLines(edges, lines, 1, CV_PI/180, hough_thres, 0, 0);
    // Draw the lines
    for (auto & line : lines) {  //https://stackoverflow.com/questions/18782873/houghlines-transform-in-opencv
        float rho = line[0];
        float theta = line[1];
        float costheta = std::cos(theta);
        float sintheta = std::sin(theta);
        float line_len = 1000;
        Point pt1 {cvRound(rho*costheta - line_len*sintheta), cvRound(rho*sintheta + line_len*costheta)};
        Point pt2 {cvRound(rho*costheta + line_len*sintheta), cvRound(rho*sintheta - line_len*costheta)};
        cv::line(hough, pt1, pt2, Scalar(0,0,255), 1, LINE_AA); 
    }
    imshow("HoughLines Transform", hough);
}

int main() {

    if ( original.empty() ) {
        return EXIT_FAILURE;
    }
    imshow("Original", original);

    namedWindow("Trackbars", WINDOW_AUTOSIZE);
    createTrackbar("gaussian_ksize" , "Trackbars", nullptr, 50, houghlines);
    createTrackbar("gaussian_sigmaX", "Trackbars", nullptr, 15, houghlines);
    createTrackbar("gaussian_sigmaY", "Trackbars", nullptr, 15, houghlines);
    createTrackbar("canny_lowthres" , "Trackbars", nullptr, 999, houghlines);
    createTrackbar("canny_ksize"    , "Trackbars", nullptr, 7, houghlines);
    createTrackbar("hough_thres"    , "Trackbars", nullptr, 400, houghlines);
    setTrackbarPos("gaussian_ksize" , "Trackbars", 3);
    setTrackbarPos("gaussian_sigmaX", "Trackbars", 0);
    setTrackbarPos("gaussian_sigmaY", "Trackbars", 0);
    setTrackbarPos("canny_lowthres" , "Trackbars", 50);
    // Aperture size should be odd between 3 and 7 in function 'Canny'
    setTrackbarPos("canny_ksize", "Trackbars", 3);
    setTrackbarMin("canny_ksize", "Trackbars", 3);
    setTrackbarMax("canny_ksize", "Trackbars", 7);
    setTrackbarPos("hough_thres", "Trackbars", 200);
    
    waitKey();
}