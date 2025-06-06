import 'package:flutter/material.dart';
import '../../app_bottom_navigation_bar.dart';
import '../../models/video_model.dart';

class DottedDivider extends StatelessWidget {
  final Color color;
  final double thickness;
  final double dashWidth;
  final double dashGap;
  final double width;

  const DottedDivider({
    super.key,
    this.color = Colors.black,
    this.thickness = 1.0,
    this.dashWidth = 3.0,
    this.dashGap = 3.0,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, thickness),
      painter: DashPainter(
        color: color,
        dashWidth: dashWidth,
        dashGap: dashGap,
        thickness: thickness,
      ),
    );
  }
}

class DashPainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashGap;
  final double thickness;

  DashPainter({
    required this.color,
    required this.dashWidth,
    required this.dashGap,
    required this.thickness,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    double startX = 0.0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashGap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class TestimonialsScreen extends StatefulWidget {
  final VideoModel videoModel;
  final String localPath;
  final int videoIndex;
  final List<VideoModel> videoList;
  final Map<String, String> localVideoPaths;
  final int selectedIndex;

  const TestimonialsScreen({
    super.key,
    required this.videoModel,
    required this.localPath,
    required this.videoIndex,
    required this.videoList,
    required this.localVideoPaths,
    required this.selectedIndex,
  });

  @override
  _TestimonialsScreenState createState() => _TestimonialsScreenState();
}

class _TestimonialsScreenState extends State<TestimonialsScreen> {
  late int _currentVideoIndex;
  late VideoModel _currentVideoModel;
  late String _currentLocalPath;

  @override
  void initState() {
    super.initState();
    _currentVideoIndex = widget.videoIndex;
    _currentVideoModel = widget.videoModel;
    _currentLocalPath = widget.localPath;
    print('TestimonialsScreen init: videoList length=${widget.videoList.length}, Current index=$_currentVideoIndex, Title=${_currentVideoModel.title}');
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
  Widget build(BuildContext context) {
    final isPreviousEnabled = _currentVideoIndex > 0;
    final isNextEnabled = _currentVideoIndex < widget.videoList.length - 1;

    final currentImagePath = _currentVideoModel.image ?? 'assets/bull_bg_image.png';
    final previousImagePath = isPreviousEnabled
        ? widget.videoList[_currentVideoIndex - 1].image ?? 'assets/bull_bg_image.png'
        : null;
    final nextImagePath = isNextEnabled
        ? widget.videoList[_currentVideoIndex + 1].image ?? 'assets/bull_bg_image.png'
        : null;

    // Calculate container width to fit small screens
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth - 32.0 < 351.0 ? screenWidth - 32.0 : 351.0;

    // Generate 5 containers using videoList
    final List<Widget> testimonialWidgets = [];
    for (int index = 0; index < 5; index++) {
      final itemIndex = (_currentVideoIndex + index) % widget.videoList.length;
      final item = widget.videoList[itemIndex];
      final imagePath = item.image ?? 'assets/bull_bg_image.png';
      final description = item.description;

      testimonialWidgets.add(
        Container(
          width: containerWidth,
          height: 190,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    imagePath,
                    width: 140.03,
                    height: 160,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.error,
                      size: 40,
                      color: Colors.red,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF000000),
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      // Add divider except after the last container
      if (index < 4) {
        testimonialWidgets.add(
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 7.5),
            child: Center(
              child: DottedDivider(
                width: 250.0,
                color: Colors.black,
                thickness: 1.0,
                dashWidth: 3.0,
                dashGap: 3.0,
              ),
            ),
          ),
        );
      }
    }

    print('Building TestimonialsScreen: Current video=${_currentVideoModel.title}, Index=$_currentVideoIndex, List length=${widget.videoList.length}');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/bull-machine-logo 1.png',
          height: 30,
        ),
      ),
      body: SingleChildScrollView(
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Testimonials',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            ...testimonialWidgets,
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