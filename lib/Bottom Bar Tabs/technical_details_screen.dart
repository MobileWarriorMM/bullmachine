import 'package:flutter/material.dart';
import '../../../app_bottom_navigation_bar.dart';
import '../../../models/video_model.dart';
import '../constants.dart';

class TechnicalDetailsScreen extends StatefulWidget {
  final String technicalItemName;
  final String iconPath;
  final int technicalIndex;
  final VideoModel videoModel;
  final String localPath;
  final int videoIndex;
  final List<VideoModel> videoList;
  final Map<String, String> localVideoPaths;
  final int selectedIndex;

  const TechnicalDetailsScreen({
    super.key,
    required this.technicalItemName,
    required this.iconPath,
    required this.technicalIndex,
    required this.videoModel,
    required this.localPath,
    required this.videoIndex,
    required this.videoList,
    required this.localVideoPaths,
    required this.selectedIndex,
  });

  @override
  _TechnicalDetailsScreenState createState() => _TechnicalDetailsScreenState();
}

class _TechnicalDetailsScreenState extends State<TechnicalDetailsScreen> {
  late String _technicalItemName;
  late String _iconPath;
  late int _technicalIndex;
  late VideoModel _videoModel;
  late String _localPath;
  late int _videoIndex;

  @override
  void initState() {
    super.initState();
    // Initialize state with widget values
    _technicalItemName = widget.technicalItemName;
    _iconPath = widget.iconPath;
    _technicalIndex = widget.technicalIndex;
    _videoModel = widget.videoModel;
    _localPath = widget.localPath;
    _videoIndex = widget.videoIndex;
  }

  void _previousVideo() {
    if (_videoIndex > 0) {
      final newIndex = _videoIndex - 1;
      final newVideo = widget.videoList[newIndex];
      final newPath = widget.localVideoPaths[newVideo.videoUrl] ?? newVideo.videoUrl;
      print('Updating to previous video: ${newVideo.title}, Index: $newIndex');
      setState(() {
        _videoIndex = newIndex;
        _videoModel = newVideo;
        _localPath = newPath;
      });
    }
  }

  void _nextVideo() {
    if (_videoIndex < widget.videoList.length - 1) {
      final newIndex = _videoIndex + 1;
      final newVideo = widget.videoList[newIndex];
      final newPath = widget.localVideoPaths[newVideo.videoUrl] ?? newVideo.videoUrl;
      print('Updating to next video: ${newVideo.title}, Index: $newIndex');
      setState(() {
        _videoIndex = newIndex;
        _videoModel = newVideo;
        _localPath = newPath;
      });
    }
  }

  void _previousItem() {
    if (_technicalIndex > 0) {
      final newIndex = _technicalIndex - 1;
      final newItem = technicalOptions[newIndex];
      print('Updating to previous item: ${newItem['name']}, Index: $newIndex');
      setState(() {
        _technicalIndex = newIndex;
        _technicalItemName = newItem['name']!;
        _iconPath = newItem['icon']!;
      });
    }
  }

  void _nextItem() {
    if (_technicalIndex < technicalOptions.length - 1) {
      final newIndex = _technicalIndex + 1;
      final newItem = technicalOptions[newIndex];
      print('Updating to next item: ${newItem['name']}, Index: $newIndex');
      setState(() {
        _technicalIndex = newIndex;
        _technicalItemName = newItem['name']!;
        _iconPath = newItem['icon']!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPreviousVideoEnabled = _videoIndex > 0;
    final isNextVideoEnabled = _videoIndex < widget.videoList.length - 1;
    final isPreviousItemEnabled = _technicalIndex > 0;
    final isNextItemEnabled = _technicalIndex < technicalOptions.length - 1;

    final currentImagePath = _videoModel.image ?? 'assets/bull_bg_image.png';
    final previousImagePath = isPreviousVideoEnabled
        ? widget.videoList[_videoIndex - 1].image ?? 'assets/bull_bg_image.png'
        : null;
    final nextImagePath = isNextVideoEnabled
        ? widget.videoList[_videoIndex + 1].image ?? 'assets/bull_bg_image.png'
        : null;

    // Responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final textSize = isTablet ? 20.0 : 18.0;
    final padding = isTablet ? 16.0 : 8.0;
    final iconSize = isTablet ? 40.0 : 30.0;

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
            // Video Navigation Bar
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
                      _videoModel.title,
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
                        onPressed: isPreviousVideoEnabled ? _previousVideo : null,
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
                        onPressed: isNextVideoEnabled ? _nextVideo : null,
                        tooltip: 'Next Video',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Technical Item Container
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  const Text(
                    'Technical Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000000),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Icon, Name, and Navigation Buttons
                  Row(
                    children: [
                      // Icon
                      Image.asset(
                        _iconPath,
                        width: iconSize,
                        height: iconSize,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          print('Asset error: $error for $_iconPath');
                          return const Icon(Icons.error, size: 30, color: Colors.red);
                        },
                      ),
                      const SizedBox(width: 16.0),
                      // Name
                      Expanded(
                        child: Text(
                          _technicalItemName,
                          style: TextStyle(
                            fontSize: textSize,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF000000),
                          ),
                        ),
                      ),
                      // Navigation Buttons
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left),
                            color: isPreviousItemEnabled ? Colors.black : Colors.grey,
                            iconSize: 28,
                            onPressed: isPreviousItemEnabled ? _previousItem : null,
                            tooltip: 'Previous Item',
                          ),
                          const SizedBox(width: 4),
                          IconButton(
                            icon: const Icon(Icons.chevron_right),
                            color: isNextItemEnabled ? Colors.black : Colors.grey,
                            iconSize: 28,
                            onPressed: isNextItemEnabled ? _nextItem : null,
                            tooltip: 'Next Item',
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: widget.selectedIndex,
        videoModel: _videoModel,
        localPath: _localPath,
        videoIndex: _videoIndex,
        videoList: widget.videoList,
        localVideoPaths: widget.localVideoPaths,
      ),
      backgroundColor: Colors.white,
    );
  }
}