import 'package:flutter/material.dart';
import '../../../app_bottom_navigation_bar.dart';
import '../../../models/video_model.dart';
import 'technical_details_screen.dart';
import '../constants.dart';

class TechnicalScreen extends StatefulWidget {
  final VideoModel videoModel;
  final String localPath;
  final int videoIndex;
  final List<VideoModel> videoList;
  final Map<String, String> localVideoPaths;
  final int selectedIndex;

  const TechnicalScreen({
    super.key,
    required this.videoModel,
    required this.localPath,
    required this.videoIndex,
    required this.videoList,
    required this.localVideoPaths,
    required this.selectedIndex,
  });

  @override
  _TechnicalScreenState createState() => _TechnicalScreenState();
}

class _TechnicalScreenState extends State<TechnicalScreen> {
  late VideoModel _videoModel;
  late String _localPath;
  late int _videoIndex;

  @override
  void initState() {
    super.initState();
    // Initialize state with widget values
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

  void _navigateToDetails(String technicalItemName, String iconPath, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TechnicalDetailsScreen(
          technicalItemName: technicalItemName,
          iconPath: iconPath,
          technicalIndex: index,
          videoModel: _videoModel,
          localPath: _localPath,
          videoIndex: _videoIndex,
          videoList: widget.videoList,
          localVideoPaths: widget.localVideoPaths,
          selectedIndex: widget.selectedIndex,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPreviousEnabled = _videoIndex > 0;
    final isNextEnabled = _videoIndex < widget.videoList.length - 1;

    final currentImagePath = _videoModel.image ?? 'assets/bull_bg_image.png';
    final previousImagePath = isPreviousEnabled
        ? widget.videoList[_videoIndex - 1].image ?? 'assets/bull_bg_image.png'
        : null;
    final nextImagePath = isNextEnabled
        ? widget.videoList[_videoIndex + 1].image ?? 'assets/bull_bg_image.png'
        : null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/bull-machine-logo 1.png',
          height: 30,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16.0),
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  const SizedBox(height: 12.0),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Technical Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ),
                  Center(
                    child: Wrap(
                      spacing: 16.0,
                      runSpacing: 16.0,
                      children: technicalOptions.asMap().entries.map((entry) {
                        final index = entry.key;
                        final option = entry.value;
                        return GestureDetector(
                          onTap: () => _navigateToDetails(option['name']!, option['icon']!, index),
                          child: Container(
                            width: 110,
                            height: 85,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  option['icon']!,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) => const Icon(
                                    Icons.error,
                                    size: 40,
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  option['name']!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF000000),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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