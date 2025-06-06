import 'package:flutter/material.dart';
import '../../app_bottom_navigation_bar.dart';
import '../../models/video_model.dart';
import 'buckets_detail_screen.dart';

class BucketsScreen extends StatefulWidget {
  final VideoModel videoModel;
  final String localPath;
  final int videoIndex;
  final List<VideoModel> videoList;
  final Map<String, String> localVideoPaths;
  final int selectedIndex;

  const BucketsScreen({
    super.key,
    required this.videoModel,
    required this.localPath,
    required this.videoIndex,
    required this.videoList,
    required this.localVideoPaths,
    required this.selectedIndex,

  });

  @override
  _BucketsScreenState createState() => _BucketsScreenState();
}

class _BucketsScreenState extends State<BucketsScreen> {
  // Define bucket options with multiple images
  static const List<Map<String, dynamic>> bucketOptions = <Map<String, dynamic>>[
    {
      'name': 'Standard Bucket',
      'images': [
        'assets/Buckets_items/fa0d04b2501bfb64af930056b1d44b20fb5de7ba.png',
        'assets/Buckets_items/49fc2c52cc71b4cfa202ed5b920905180fc7b265.png',
        'assets/Buckets_items/d9a6311a5589c0ab6ff2923201fabca78dbe22d1.png',
      ],
    },
    {
      'name': 'Heavy Duty Bucket',
      'images': [
        'assets/Buckets_items/49fc2c52cc71b4cfa202ed5b920905180fc7b265.png',
        'assets/Buckets_items/d9a6311a5589c0ab6ff2923201fabca78dbe22d1.png',
      ],
    },
    {
      'name': 'Rock Bucket',
      'images': [
        'assets/Buckets_items/d9a6311a5589c0ab6ff2923201fabca78dbe22d1.png',
        'assets/Buckets_items/49fc2c52cc71b4cfa202ed5b920905180fc7b265.png',
      ],
    },
    {
      'name': 'Multi-Purpose Bucket',
      'images': [
        'assets/Buckets_items/ef751c2946ec9aef31f736278688e527bcbf3c92.png',
        'assets/Buckets_items/d9a6311a5589c0ab6ff2923201fabca78dbe22d1.png',
      ],
    },
    {
      'name': 'Multi-Purpose Bucket',
      'images': [
        'assets/Buckets_items/f23320b76f04cb97e31ef08630860c6e9d5d80ee.png',
        'assets/Buckets_items/ef751c2946ec9aef31f736278688e527bcbf3c92.png',
      ],
    },
    {
      'name': 'Multi-Purpose Bucket',
      'images': [
        'assets/Buckets_items/fa0d04b2501bfb64af930056b1d44b20fb5de7ba.png',
        'assets/Buckets_items/multi_purpose_3_2.png',
      ],
    },
    {
      'name': '14 FEET EXT BALE',
      'images': [
        'assets/Buckets_items/3ad530d3dd56226fac05ed7950790d79368c0608.jpg',
        'assets/Buckets_items/multi_purpose_4_2.jpg',
      ],
    },
  ];

  late int _currentVideoIndex;
  late VideoModel _currentVideoModel;
  late String _currentLocalPath;

  @override
  void initState() {
    super.initState();
    _currentVideoIndex = widget.videoIndex;
    _currentVideoModel = widget.videoModel;
    _currentLocalPath = widget.localPath;
    debugPrint('BucketsScreen init: videoList length=${widget.videoList.length}, Current index= :<|>.currentVideoIndex, Title=${_currentVideoModel.title}');
  }

  void _previousVideo() {
    if (_currentVideoIndex > 0) {
      setState(() {
        _currentVideoIndex--;
        _currentVideoModel = widget.videoList[_currentVideoIndex];
        _currentLocalPath = widget.localVideoPaths[_currentVideoModel.videoUrl] ?? _currentVideoModel.videoUrl;
      });
      debugPrint('Previous video: ${_currentVideoModel.title}, Index: $_currentVideoIndex, List length: ${widget.videoList.length}');
    }
  }

  void _nextVideo() {
    if (_currentVideoIndex < widget.videoList.length - 1) {
      setState(() {
        _currentVideoIndex++;
        _currentVideoModel = widget.videoList[_currentVideoIndex];
        _currentLocalPath = widget.localVideoPaths[_currentVideoModel.videoUrl] ?? _currentVideoModel.videoUrl;
      });
      debugPrint('Next video: ${_currentVideoModel.title}, Index: $_currentVideoIndex, List length: ${widget.videoList.length}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isPreviousEnabled = _currentVideoIndex > 0;
    final isNextEnabled = _currentVideoIndex < widget.videoList.length - 1;

    final currentImagePath = _currentVideoModel.image ?? 'assets/bull_bg_image.png';
    final previousImagePath = isPreviousEnabled
        ? widget.videoList[_currentVideoIndex - 1].image ?? 'assets/bull_bg_image.png'
        : null;
    final nextImagePath = isNextEnabled
        ? widget.videoList[_currentVideoIndex + 1].image ?? 'assets/bull_bg_image.png'
        : null;

    // Container sizes
    double containerWidth = isTablet ? 127.0 : 166.62;
    double containerHeight = isTablet ? 125.0 : 163.52;
    double childAspectRatio = containerWidth / containerHeight;
    int crossAxisCount = isTablet ? 4 : 2;

    // Scale down if screen width is too small
    final minGridWidth = crossAxisCount * containerWidth + (crossAxisCount - 1) * 16 + crossAxisCount * 16; // containers + spacing + padding
    final scaleFactor = screenWidth < minGridWidth ? screenWidth / minGridWidth : 1.0;
    if (scaleFactor < 1.0) {
      containerWidth *= scaleFactor;
      containerHeight *= scaleFactor;
    }

    debugPrint('Building BucketsScreen: Current video=${_currentVideoModel.title}, Index=$_currentVideoIndex, '
        'List length=${widget.videoList.length}, isTablet=$isTablet, '
        'Container=${containerWidth}x$containerHeight, Scale=$scaleFactor, Columns=$crossAxisCount');

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
            /// Previous and Next Item Bar
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
            const SizedBox(height: 16.0),

            // Bucket Option Text
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Bucket Options',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000000),
                ),
              ),
            ),
            // GridView for bucket options
            LayoutBuilder(
              builder: (context, constraints) {
                debugPrint('GridView constraints: w=${constraints.maxWidth}, h=${constraints.maxHeight}');
                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemCount: bucketOptions.length,
                  itemBuilder: (context, index) {
                    final bucket = bucketOptions[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BucketsDetailScreen(
                                bucketName: bucket['name']!,
                                bucketImages: List<String>.from(bucket['images']!),
                                videoModel: _currentVideoModel,
                                localPath: _currentLocalPath,
                                videoIndex: _currentVideoIndex,
                                videoList: widget.videoList,
                                localVideoPaths: widget.localVideoPaths,
                                selectedIndex: widget.selectedIndex,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: containerWidth,
                          height: containerHeight,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xFFFFB92F),
                                offset: Offset(0, 2),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Image.asset(
                                    bucket['images']![0], // Display first image
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      debugPrint('Image error for ${bucket['name']}: $error');
                                      return const Center(
                                        child: Text(
                                          'Image not found',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  bucket['name']!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
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