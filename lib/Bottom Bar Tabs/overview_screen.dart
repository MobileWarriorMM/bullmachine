import 'dart:async';
import 'package:flutter/material.dart';
import '../../app_bottom_navigation_bar.dart';
import '../../models/video_model.dart';

class OverviewScreen extends StatefulWidget {
  final VideoModel videoModel;
  final String localPath;
  final int videoIndex;
  final List<VideoModel> videoList;
  final Map<String, String> localVideoPaths;
  final int selectedIndex;

  const OverviewScreen({
    super.key,
    required this.videoModel,
    required this.localPath,
    required this.videoIndex,
    required this.videoList,
    required this.localVideoPaths,
    required this.selectedIndex,
  });

  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;
  late int _currentVideoIndex;
  late VideoModel _currentVideoModel;
  late String _currentLocalPath;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    // Initialize video state
    _currentVideoIndex = widget.videoIndex;
    _currentVideoModel = widget.videoModel;
    _currentLocalPath = widget.localPath;
    _startAutoSlide();
    print('OverviewScreen init: videoList length=${widget.videoList.length}, Current index=$_currentVideoIndex, Title=${_currentVideoModel.title}');
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_currentPage < 3) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _previousImage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      print('Previous image: Page=$_currentPage');
    }
  }

  void _nextImage() {
    if (_currentPage < 3) {
      setState(() {
        _currentPage++;
      });
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      print('Next image: Page=$_currentPage');
    }
  }

  void _previousVideo() {
    if (_currentVideoIndex > 0) {
      setState(() {
        _currentVideoIndex--;
        _currentVideoModel = widget.videoList[_currentVideoIndex];
        _currentLocalPath = widget.localVideoPaths[_currentVideoModel.videoUrl] ?? _currentVideoModel.videoUrl;
      });
      print('Previous video: ${_currentVideoModel.title}, Index: $_currentVideoIndex, List length: ${widget.videoList.length}');
    }
  }

  void _nextVideo() {
    if (_currentVideoIndex < widget.videoList.length - 1) {
      setState(() {
        _currentVideoIndex++;
        _currentVideoModel = widget.videoList[_currentVideoIndex];
        _currentLocalPath = widget.localVideoPaths[_currentVideoModel.videoUrl] ?? _currentVideoModel.videoUrl;
      });
      print('Next video: ${_currentVideoModel.title}, Index: $_currentVideoIndex, List length: ${widget.videoList.length}');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final isPreviousEnabled = _currentVideoIndex > 0;
    final isNextEnabled = _currentVideoIndex < widget.videoList.length - 1;

    final currentImagePath = _currentVideoModel.image ?? 'assets/bull_bg_image.png';
    final previousImagePath = isPreviousEnabled
        ? widget.videoList[_currentVideoIndex - 1].image ?? 'assets/bull_bg_image.png'
        : null;
    final nextImagePath = isNextEnabled
        ? widget.videoList[_currentVideoIndex + 1].image ?? 'assets/bull_bg_image.png'
        : null;

    final imagePaths = [
      currentImagePath,
      'assets/bull_bg_image.png',
      'assets/overviewBanner1.png',
      'assets/Overviewbanner4.png',
    ];

    // Adjust banner height and width based on device and orientation
    final bannerHeight = isTablet && isLandscape ? 250.0 : screenHeight * 0.2;
    final bannerWidth = double.infinity; // Stretch to full width for all devices
    final bannerFit = BoxFit.fitWidth; // Stretch width, maintain aspect ratio

    print('Building OverviewScreen: Current video=${_currentVideoModel.title}, Index=$_currentVideoIndex, List length=${widget.videoList.length}');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/bull-machine-logo 1.png',
          height: 30,
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Navigation Bar
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Color(0xFFFFB92F),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      _currentVideoModel.title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.keyboard_arrow_left, size: 20),
                        onPressed: isPreviousEnabled ? _previousVideo : null,
                        tooltip: 'Previous',
                      ),
                      const SizedBox(width: 8),
                      if (previousImagePath != null)
                        Opacity(
                          opacity: 0.7,
                          child: ClipOval(
                            child: Image.asset(
                              previousImagePath,
                              width: 30,
                              height: 30,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      if (previousImagePath != null) const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFED3237),
                            width: 2,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            currentImagePath,
                            width: 36,
                            height: 36,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (nextImagePath != null)
                        Opacity(
                          opacity: 0.7,
                          child: ClipOval(
                            child: Image.asset(
                              nextImagePath,
                              width: 30,
                              height: 30,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      if (nextImagePath != null) const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.keyboard_arrow_right, size: 20),
                        onPressed: isNextEnabled ? _nextVideo : null,
                        tooltip: 'Next',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Image Banner
            Container(
              height: bannerHeight,
              width: bannerWidth,
              child: Image.asset(
                'assets/mediabanner.png',
                fit: bannerFit,
                alignment: Alignment.center,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Text(
                    'Error loading image',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
            // Scrollable Image List
            Container(
              height: isTablet && isLandscape ? screenHeight * 0.55 : screenHeight * 0.6,
              color: Colors.white,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: imagePaths.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                        print('PageView changed to: ${imagePaths[index]}, Page: $_currentPage');
                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.asset(
                        imagePaths[index],
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Center(
                          child: Text(
                            'Error loading image',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    left: 10,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: _currentPage > 0 ? _previousImage : null,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Icon(
                              Icons.keyboard_arrow_left,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 16,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: _currentPage < imagePaths.length - 1 ? _nextImage : null,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Icon(
                              Icons.keyboard_arrow_right,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Download Brochure Button
            Center(
              child: SizedBox(
                width: 200,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFED3237),
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: const Text('Download Brochure'),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: widget.selectedIndex,
        videoModel: _currentVideoModel,
        localPath: _currentLocalPath,
        videoIndex: _currentVideoIndex,
        videoList: widget.videoList,
        localVideoPaths: widget.localVideoPaths,
      ),
      backgroundColor: Colors.white,
    );
  }
}