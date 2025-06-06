import 'package:flutter/material.dart';
import '../../app_bottom_navigation_bar.dart';
import '../../models/video_model.dart';
import '../constants.dart';

class BucketsDetailScreen extends StatefulWidget {
  final String bucketName;
  final List<String> bucketImages;
  final VideoModel videoModel;
  final String localPath;
  final int videoIndex;
  final List<VideoModel> videoList;
  final Map<String, String> localVideoPaths;
  final int selectedIndex;

  const BucketsDetailScreen({
    super.key,
    required this.bucketName,
    required this.bucketImages,
    required this.videoModel,
    required this.localPath,
    required this.videoIndex,
    required this.videoList,
    required this.localVideoPaths,
    required this.selectedIndex,
  });

  @override
  _BucketsDetailScreenState createState() => _BucketsDetailScreenState();
}

class _BucketsDetailScreenState extends State<BucketsDetailScreen> {
  int _currentImageIndex = 0;
  late String _bucketName;
  late List<String> _bucketImages;
  late int _bucketIndex;
  late int _currentVideoIndex;
  late VideoModel _currentVideoModel;
  late String _currentLocalPath;

  @override
  void initState() {
    super.initState();
    // Initialize bucket state
    _bucketName = widget.bucketName;
    _bucketImages = widget.bucketImages;
    _bucketIndex =
        bucketOptions.indexWhere((bucket) => bucket['name'] == _bucketName);
    if (_bucketIndex == -1) {
      _bucketIndex = 0;
      _bucketName = bucketOptions[0]['name']!;
      _bucketImages = List<String>.from(bucketOptions[0]['images']!);
    }
    // Initialize video state
    _currentVideoIndex = widget.videoIndex;
    _currentVideoModel = widget.videoModel;
    _currentLocalPath = widget.localPath;
    print(
        'BucketsDetailScreen init: videoList length=${widget.videoList.length}, Current video index=$_currentVideoIndex, Title=${_currentVideoModel.title}, Bucket=$_bucketName, BucketIndex=$_bucketIndex');
  }

  void _previousVideo() {
    if (_currentVideoIndex > 0) {
      setState(() {
        _currentVideoIndex--;
        _currentVideoModel = widget.videoList[_currentVideoIndex];
        _currentLocalPath =
            widget.localVideoPaths[_currentVideoModel.videoUrl] ??
                _currentVideoModel.videoUrl;
      });
      print(
          'Previous video: ${_currentVideoModel.title}, Index: $_currentVideoIndex, List length: ${widget.videoList.length}');
    }
  }

  void _nextVideo() {
    if (_currentVideoIndex < widget.videoList.length - 1) {
      setState(() {
        _currentVideoIndex++;
        _currentVideoModel = widget.videoList[_currentVideoIndex];
        _currentLocalPath =
            widget.localVideoPaths[_currentVideoModel.videoUrl] ??
                _currentVideoModel.videoUrl;
      });
      print(
          'Next video: ${_currentVideoModel.title}, Index: $_currentVideoIndex, List length: ${widget.videoList.length}');
    }
  }

  void _previousBucket() {
    if (_bucketIndex > 0) {
      setState(() {
        _bucketIndex--;
        _bucketName = bucketOptions[_bucketIndex]['name']!;
        _bucketImages =
            List<String>.from(bucketOptions[_bucketIndex]['images']!);
        _currentImageIndex = 0;
      });
      print('Previous bucket: $_bucketName, BucketIndex: $_bucketIndex');
    }
  }

  void _nextBucket() {
    if (_bucketIndex < bucketOptions.length - 1) {
      setState(() {
        _bucketIndex++;
        _bucketName = bucketOptions[_bucketIndex]['name']!;
        _bucketImages =
            List<String>.from(bucketOptions[_bucketIndex]['images']!);
        _currentImageIndex = 0;
      });
      print('Next bucket: $_bucketName, BucketIndex: $_bucketIndex');
    }
  }

  void _previousImage() {
    if (_currentImageIndex > 0) {
      setState(() {
        _currentImageIndex--;
      });
      print(
          'Previous image: ${_bucketImages[_currentImageIndex]}, Index: $_currentImageIndex');
    }
  }

  void _nextImage() {
    if (_currentImageIndex < _bucketImages.length - 1) {
      setState(() {
        _currentImageIndex++;
      });
      print(
          'Next image: ${_bucketImages[_currentImageIndex]}, Index: $_currentImageIndex');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPreviousVideoEnabled = _currentVideoIndex > 0;
    final isNextVideoEnabled = _currentVideoIndex < widget.videoList.length - 1;
    final isPreviousImageEnabled = _currentImageIndex > 0;
    final isNextImageEnabled = _currentImageIndex < _bucketImages.length - 1;
    final isPreviousBucketEnabled = _bucketIndex > 0;
    final isNextBucketEnabled = _bucketIndex < bucketOptions.length - 1;

    final currentImagePath =
        _currentVideoModel.image ?? 'assets/bull_bg_image.png';
    final previousImagePath = isPreviousVideoEnabled
        ? widget.videoList[_currentVideoIndex - 1].image ??
            'assets/bull_bg_image.png'
        : null;
    final nextImagePath = isNextVideoEnabled
        ? widget.videoList[_currentVideoIndex + 1].image ??
            'assets/bull_bg_image.png'
        : null;

    // Responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    // Image and table dimensions
    double imageWidth;
    double imageHeight;
    double iconSize = 24.0;
    double descriptionWidth;
    double descriptionPadding = isTablet ? 16.0 : 8.0;
    double descriptionTextSize = isTablet ? 15.0 : 14.0;

    if (isTablet && isLandscape) {
      // Tablet landscape: Side-by-side layout
      imageWidth =
          (screenWidth * 0.45).clamp(354.36, 600.0); // ~45% of screen, capped
      descriptionWidth = (screenWidth * 0.45).clamp(300.0, 600.0);
      imageHeight = (imageWidth / 1.562).clamp(226.87, 384.0);
      iconSize = 28.0;
    } else {
      // Mobile and tablet portrait: Original sizing
      imageWidth = isTablet
          ? (isLandscape ? screenWidth * 0.9 : screenWidth * 0.7)
              .clamp(354.36, screenWidth - 56.0)
          : 354.36;
      descriptionWidth = imageWidth;
      imageHeight = (imageWidth / 1.562).clamp(226.87, 500.0);
      iconSize = isTablet ? 28.0 : 24.0;
    }

    // Get description and specifications
    final description = bucketDescriptions[_bucketName] ??
        'No description available for this bucket.';
    final specs = bucketSpecifications[_bucketName] ?? [];

    // Table columns
    const tableColumns = ['Specification', 'Unit', 'Weight'];

    debugPrint(
        'Building BucketsDetailScreen: Current video=${_currentVideoModel.title}, Index=$_currentVideoIndex, '
        'Bucket=$_bucketName, ImageIndex=$_currentImageIndex, isTablet=$isTablet, isLandscape=$isLandscape, '
        'Image=${imageWidth}x$imageHeight, DescWidth=$descriptionWidth');

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
            /// Previous and Next Video Bar
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
                        onPressed:
                            isPreviousVideoEnabled ? _previousVideo : null,
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

            /// Combined container with title, bucket name, and navigation
            Container(
              // margin: const EdgeInsets.all(12.0),
              //  padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8.0),
                // border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _bucketName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF000000),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left),
                            color: Colors.black,
                            iconSize: 28,
                            onPressed: isPreviousBucketEnabled
                                ? _previousBucket
                                : null,
                            tooltip: 'Previous Bucket',
                          ),
                          const SizedBox(width: 4),
                          IconButton(
                            icon: const Icon(Icons.chevron_right),
                            color: Colors.black,
                            iconSize: 28,
                            onPressed: isNextBucketEnabled ? _nextBucket : null,
                            tooltip: 'Next Bucket',
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),

            /// Bucket content
            LayoutBuilder(
              builder: (context, constraints) {
                print(
                    'Content constraints: w=${constraints.maxWidth}, h=${constraints.maxHeight}');
                if (isTablet && isLandscape) {
                  // Tablet landscape: Side-by-side layout
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left: Image and Table
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: descriptionPadding),
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: imageWidth,
                                    height: imageHeight,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: Image.asset(
                                        _bucketImages[_currentImageIndex],
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Center(
                                          child: Text(
                                            'Image not found',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 8,
                                    child: IconButton(
                                      icon: Icon(Icons.keyboard_arrow_left,
                                          size: iconSize, color: Colors.black),
                                      onPressed: isPreviousImageEnabled
                                          ? _previousImage
                                          : null,
                                      tooltip: 'Previous Image',
                                    ),
                                  ),
                                  Positioned(
                                    right: 8,
                                    child: IconButton(
                                      icon: Icon(Icons.keyboard_arrow_right,
                                          size: iconSize, color: Colors.black),
                                      onPressed: isNextImageEnabled
                                          ? _nextImage
                                          : null,
                                      tooltip: 'Next Image',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              // Specifications Table
                              Container(
                                width: imageWidth,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: specs.isEmpty
                                    ? Padding(
                                        padding:
                                            EdgeInsets.all(descriptionPadding),
                                        child: Text(
                                          'No specifications available.',
                                          style: TextStyle(
                                            fontSize: descriptionTextSize,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      )
                                    : Table(
                                        border: TableBorder.all(
                                          color: Colors.grey.shade300,
                                        ),
                                        columnWidths: const {
                                          0: FlexColumnWidth(2),
                                          1: FlexColumnWidth(1),
                                          2: FlexColumnWidth(1),
                                        },
                                        children: [
                                          TableRow(
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                            ),
                                            children: tableColumns
                                                .map((column) => Padding(
                                                      padding: EdgeInsets.all(
                                                          descriptionPadding),
                                                      child: Text(
                                                        column,
                                                        style: TextStyle(
                                                          fontSize:
                                                              descriptionTextSize,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: const Color(
                                                              0xFF000000),
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ))
                                                .toList(),
                                          ),
                                          ...specs.map((spec) => TableRow(
                                                children: tableColumns
                                                    .map((column) => Padding(
                                                          padding: EdgeInsets.all(
                                                              descriptionPadding),
                                                          child: Text(
                                                            spec[column] ?? '-',
                                                            style: TextStyle(
                                                              fontSize:
                                                                  descriptionTextSize,
                                                              color: const Color(
                                                                  0xFF000000),
                                                            ),
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                        ))
                                                    .toList(),
                                              )),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Right: Description
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: descriptionPadding),
                          child: Container(
                            width: descriptionWidth,
                            padding: EdgeInsets.all(descriptionPadding),
                            child: SingleChildScrollView(
                              child: Text(
                                description,
                                style: TextStyle(
                                  fontSize: descriptionTextSize,
                                  color: const Color(0xFF000000),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  // Mobile and tablet portrait: Original vertical layout
                  return Center(
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: imageWidth,
                              height: imageHeight,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Image.asset(
                                  _bucketImages[_currentImageIndex],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Center(
                                    child: Text(
                                      'Image not found',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 8,
                              child: IconButton(
                                icon: Icon(Icons.keyboard_arrow_left,
                                    size: iconSize, color: Colors.black),
                                onPressed: isPreviousImageEnabled
                                    ? _previousImage
                                    : null,
                                tooltip: 'Previous Image',
                              ),
                            ),
                            Positioned(
                              right: 8,
                              child: IconButton(
                                icon: Icon(Icons.keyboard_arrow_right,
                                    size: iconSize, color: Colors.black),
                                onPressed:
                                    isNextImageEnabled ? _nextImage : null,
                                tooltip: 'Next Image',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          _bucketName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF000000),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16.0),
                        // Bucket Description
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: descriptionPadding),
                          child: Container(
                            width: imageWidth,
                            padding: EdgeInsets.all(descriptionPadding),
                            child: Text(
                              description,
                              style: TextStyle(
                                fontSize: descriptionTextSize,
                                color: const Color(0xFF000000),
                              ),
                              maxLines: 6,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        // Specifications Table
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: descriptionPadding),
                          child: Container(
                            width: imageWidth,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: specs.isEmpty
                                ? Padding(
                                    padding: EdgeInsets.all(descriptionPadding),
                                    child: Text(
                                      'No specifications available.',
                                      style: TextStyle(
                                        fontSize: descriptionTextSize,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )
                                : Table(
                                    border: TableBorder.all(
                                      color: Colors.grey.shade300,
                                    ),
                                    columnWidths: const {
                                      0: FlexColumnWidth(2),
                                      1: FlexColumnWidth(1),
                                      2: FlexColumnWidth(1),
                                    },
                                    children: [
                                      TableRow(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                        ),
                                        children: tableColumns
                                            .map((column) => Padding(
                                                  padding: EdgeInsets.all(
                                                      descriptionPadding),
                                                  child: Text(
                                                    column,
                                                    style: TextStyle(
                                                      fontSize:
                                                          descriptionTextSize,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: const Color(
                                                          0xFF000000),
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                      ...specs.map((spec) => TableRow(
                                            children: tableColumns
                                                .map((column) => Padding(
                                                      padding: EdgeInsets.all(
                                                          descriptionPadding),
                                                      child: Text(
                                                        spec[column] ?? '-',
                                                        style: TextStyle(
                                                          fontSize:
                                                              descriptionTextSize,
                                                          color: const Color(
                                                              0xFF000000),
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ))
                                                .toList(),
                                          )),
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 20.0),
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
