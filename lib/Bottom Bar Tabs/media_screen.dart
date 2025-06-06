import 'package:bull_machine/models/video_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../../app_bottom_navigation_bar.dart';

class MediaScreen extends StatefulWidget {
  final VideoModel videoModel;
  final String localPath;
  final int videoIndex;
  final List<VideoModel> videoList;
  final Map<String, String> localVideoPaths;
  final int selectedIndex;

  const MediaScreen({
    super.key,
    required this.videoModel,
    required this.localPath,
    required this.videoIndex,
    required this.videoList,
    required this.localVideoPaths,
    required this.selectedIndex,
  });

  @override
  _MediaScreenState createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  List<VideoModel> forBiggerEscapeVideos = [];
  List<VideoModel> otherVideos = [];

  @override
  void initState() {
    super.initState();
    forBiggerEscapeVideos = widget.videoList.where((video) => video.title == "For Bigger Escape").toList();
    otherVideos = widget.videoList.where((video) => video.title != "For Bigger Escape").toList();
    _initializeVideoPlayer(widget.localPath);
  }

  Future<void> _initializeVideoPlayer(String path) async {
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(path));
    await _videoPlayerController.initialize().then((_) {
      print('Video initialized: ${widget.localPath}');
    }).catchError((e) {
      print('Video init error: $e');
    });
    setState(() {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: false,
        looping: false,
        aspectRatio: _videoPlayerController.value.aspectRatio,
        errorBuilder: (context, errorMessage) {
          print('Video error: $errorMessage');
          return Center(
            child: Text(
              'Error loading video: $errorMessage',
              style: const TextStyle(color: Colors.red),
            ),
          );
        },
      );
    });
  }

  void _previousVideo() {
    final isForBiggerEscape = widget.videoModel.title == "For Bigger Escape";
    final filteredList = isForBiggerEscape ? forBiggerEscapeVideos : otherVideos;
    final currentFilteredIndex = filteredList.indexOf(widget.videoModel);

    if (currentFilteredIndex > 0) {
      final newFilteredIndex = currentFilteredIndex - 1;
      final newVideo = filteredList[newFilteredIndex];
      final newIndex = widget.videoList.indexOf(newVideo);
      final newPath = widget.localVideoPaths[newVideo.videoUrl] ?? newVideo.videoUrl;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MediaScreen(
            videoModel: newVideo,
            localPath: newPath,
            videoIndex: newIndex,
            videoList: widget.videoList,
            localVideoPaths: widget.localVideoPaths,
            selectedIndex: widget.selectedIndex,
          ),
        ),
      );
    }
  }

  void _nextVideo() {
    final isForBiggerEscape = widget.videoModel.title == "For Bigger Escape";
    final filteredList = isForBiggerEscape ? forBiggerEscapeVideos : otherVideos;
    final currentFilteredIndex = filteredList.indexOf(widget.videoModel);

    if (currentFilteredIndex < filteredList.length - 1) {
      final newFilteredIndex = currentFilteredIndex + 1;
      final newVideo = filteredList[newFilteredIndex];
      final newIndex = widget.videoList.indexOf(newVideo);
      final newPath = widget.localVideoPaths[newVideo.videoUrl] ?? newVideo.videoUrl;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MediaScreen(
            videoModel: newVideo,
            localPath: newPath,
            videoIndex: newIndex,
            videoList: widget.videoList,
            localVideoPaths: widget.localVideoPaths,
            selectedIndex: widget.selectedIndex,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final isForBiggerEscape = widget.videoModel.title == "For Bigger Escape";
    final filteredList = isForBiggerEscape ? forBiggerEscapeVideos : otherVideos;
    final currentFilteredIndex = filteredList.indexOf(widget.videoModel);
    final isPreviousEnabled = currentFilteredIndex > 0;
    final isNextEnabled = currentFilteredIndex < filteredList.length - 1;

    final currentImagePath = widget.videoModel.image ?? 'assets/bull_bg_image.png';
    final previousImagePath = isPreviousEnabled
        ? filteredList[currentFilteredIndex - 1].image ?? 'assets/bull_bg_image.png'
        : null;
    final nextImagePath = isNextEnabled
        ? filteredList[currentFilteredIndex + 1].image ?? 'assets/bull_bg_image.png'
        : null;

    // Adjust video player size based on orientation
    final double videoWidth = isLandscape ? screenWidth * 0.9 : 414.0;
    final double videoHeight = isLandscape
        ? (screenWidth * 0.9 / (_chewieController?.videoPlayerController.value.aspectRatio ?? 16 / 9)).clamp(0, screenHeight * 0.5)
        : 249.0;

    // Responsive TAB image sizes
    double firstImageWidth = isTablet && isLandscape ? 1393.0 : 415.75;
    double firstImageHeight = isTablet && isLandscape ? 569.0 : 170.0;
    double otherImageWidth = isTablet && isLandscape ? 558.0 : 222.0;
    double otherImageHeight = isTablet && isLandscape ? 372.0 : 148.0;

    // Scale down if screen width is too small
    final scaleFactor = screenWidth < firstImageWidth + 32 ? screenWidth / (firstImageWidth + 32) : 1.0; // +32 for padding
    if (scaleFactor < 1.0) {
      firstImageWidth *= scaleFactor;
      firstImageHeight *= scaleFactor;
      otherImageWidth *= scaleFactor;
      otherImageHeight *= scaleFactor;
    }

    // Adjust container height to fit text + first image + other images + padding + buffer
    final containerHeight = 28 + 10 + firstImageHeight + 10 + otherImageHeight + 16 + 16 + 8; // Extra 8px buffer

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
                      widget.videoModel.title,
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
                        tooltip: 'Previous Video',
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
                        tooltip: 'Next Video',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 8.0),
              child: Text(
                'Videos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000000),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            // Video Player
            Center(
              child: SizedBox(
                width: videoWidth,
                height: videoHeight,
                child: _chewieController != null
                    ? Chewie(controller: _chewieController!)
                    : const Center(child: CircularProgressIndicator()),
              ),
            ),
            // Image List
            Container(
              height: containerHeight,
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  print('Container constraints: w=${constraints.maxWidth}, h=${constraints.maxHeight}');
                  final imagePaths = [
                    'assets/mediabanner.png',
                    'assets/bull_bg_image.png',
                    'assets/Overviewbanner4.png',
                    'assets/OverviewBanner3_TA variant_.png',
                  ];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Images',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF000000),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Image.asset(
                        imagePaths[0],
                        width: firstImageWidth,
                        height: firstImageHeight,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          print('First image error: $error');
                          return Container(
                            width: firstImageWidth,
                            height: firstImageHeight,
                            color: Colors.grey,
                            child: const Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 40,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const ClampingScrollPhysics(),
                          itemCount: 3, // Second, third, fourth images
                          itemBuilder: (context, index) {
                            final imageIndex = index + 1; // Start at imagePaths[1]
                            print('ListView item $index: Width=${otherImageWidth + 16}, Height=$otherImageHeight');
                            return Container(
                              width: otherImageWidth + 16, // Add margin
                              margin: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Image.asset(
                                imagePaths[imageIndex],
                                width: otherImageWidth,
                                height: otherImageHeight,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  print('Image $imageIndex error: $error');
                                  return Container(
                                    width: otherImageWidth,
                                    height: otherImageHeight,
                                    color: Colors.grey,
                                    child: const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: widget.selectedIndex,
        videoModel: widget.videoModel,
        localPath: widget.localPath,
        videoIndex: widget.videoIndex,
        videoList: widget.videoList,
        localVideoPaths: widget.localVideoPaths,
      ),
      backgroundColor: Colors.white,
    );
  }
}