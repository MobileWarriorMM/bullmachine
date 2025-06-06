import 'package:flutter/material.dart';
import '../models/video_model.dart';
import 'Bottom Bar Tabs/buckets_screen.dart';
import 'Bottom Bar Tabs/media_screen.dart';
import 'Bottom Bar Tabs/overview_screen.dart';
import 'Bottom Bar Tabs/technical_screen.dart';
import 'Bottom Bar Tabs/testimonials_screen.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final VideoModel videoModel;
  final String localPath;
  final int videoIndex;
  final List<VideoModel> videoList;
  final Map<String, String> localVideoPaths;

  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.videoModel,
    required this.localPath,
    required this.videoIndex,
    required this.videoList,
    required this.localVideoPaths,
  });

  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) return;
    Widget newScreen;
    switch (index) {
      case 0:
        newScreen = OverviewScreen(
          videoModel: videoModel,
          localPath: localPath,
          videoIndex: videoIndex,
          videoList: videoList,
          localVideoPaths: localVideoPaths,
          selectedIndex: index,
        );
        break;
      case 1:
        newScreen = MediaScreen(
          videoModel: videoModel,
          localPath: localPath,
          videoIndex: videoIndex,
          videoList: videoList,
          localVideoPaths: localVideoPaths,
          selectedIndex: index,
        );
        break;
      case 2:
        newScreen = BucketsScreen(
          videoModel: videoModel,
          localPath: localPath,
          videoIndex: videoIndex,
          videoList: videoList,
          localVideoPaths: localVideoPaths,
          selectedIndex: index,
        );
        break;
      case 3:
        newScreen = TechnicalScreen(
          videoModel: videoModel,
          localPath: localPath,
          videoIndex: videoIndex,
          videoList: videoList,
          localVideoPaths: localVideoPaths,
          selectedIndex: index,
        );
        break;
      case 4:
        newScreen = TestimonialsScreen(
          videoModel: videoModel,
          localPath: localPath,
          videoIndex: videoIndex,
          videoList: videoList,
          localVideoPaths: localVideoPaths,
          selectedIndex: index,
        );
        break;
      default:
        return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => newScreen),
    );
  }


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/overview.png',
            width: 24,
            height: 24,
            color: currentIndex == 0 ? const Color(0xFFED3237) : const Color(0xFF000000),
          ),
          label: 'Overview',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/media.png',
            width: 24,
            height: 24,
            color: currentIndex == 1 ? const Color(0xFFED3237) : const Color(0xFF000000),
          ),
          label: 'Media',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/buckets.png',
            width: 24,
            height: 24,
            color: currentIndex == 2 ? const Color(0xFFED3237) : const Color(0xFF000000),
          ),
          label: 'Buckets',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/techinal.png',
            width: 24,
            height: 24,
            color: currentIndex == 3 ? const Color(0xFFED3237) : const Color(0xFF000000),
          ),
          label: 'Technical',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/testimonals.png',
            width: 24,
            height: 24,
            color: currentIndex == 4 ? const Color(0xFFED3237) : const Color(0xFF000000),
          ),
          label: 'Testimonials',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: const Color(0xFFED3237),
      unselectedItemColor: const Color(0xFF000000),
      onTap: (index) => _onTap(context, index),
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFFF0F0F0),
    );
  }


}