import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Bottom Bar Tabs/overview_screen.dart';
import '../models/video_model.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _employeeId = 'User'; // Default value
  final List<VideoModel> agriItems = [
    VideoModel.fromJson({
      "id": "4",
      "title": "BULL GARNDIA",
      "thumbnailUrl": "https://img.jakpost.net/c/2019/09/03/2019_09_03_78912_1567484272._large.jpg",
      "duration": "8:18",
      "uploadTime": "May 9, 2011",
      "views": "24,969,123",
      "author": "T-Series Regional",
      "videoUrl": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
      "description": "Introducing Chromecast...",
      "subscriber": "25254545 Subscribers",
      "isLive": false,
      "image": "assets/AgriProduct/Agribull _IMG 1.png",
    }),
    VideoModel.fromJson({
      "id": "7",
      "title": "BULL GARNDIA",
      "thumbnailUrl": "https://img.jakpost.net/c/2019/09/03/2019_09_03_78912_1567484272._large.jpg",
      "duration": "8:18",
      "uploadTime": "May 9, 2011",
      "views": "24,969,123",
      "author": "T-Series Regional",
      "videoUrl": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
      "description": "Introducing Chromecast...",
      "subscriber": "25254545 Subscribers",
      "isLive": true,
      "image": "assets/AgriProduct/Agribull_IMG 2.png",
    }),
    VideoModel.fromJson({
      "id": "9",
      "title": "BULL GARNDIA",
      "thumbnailUrl": "https://img.jakpost.net/c/2019/09/03/2019_09_03_78912_1567484272._large.jpg",
      "duration": "8:18",
      "uploadTime": "May 9, 2011",
      "views": "24,969,123",
      "author": "T-Series Regional",
      "videoUrl": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
      "description": "Introducing Chromecast...",
      "subscriber": "25254545 Subscribers",
      "isLive": false,
      "image": "assets/AgriProduct/Agribull _IMG 3.png",
    }),
    VideoModel.fromJson({
      "id": "10",
      "title": "Agri Mini Tractor",
      "thumbnailUrl": "https://img.jakpost.net/c/2019/09/03/2019_09_03_78912_1567484272._large.jpg",
      "duration": "8:18",
      "uploadTime": "May 9, 2011",
      "views": "24,969,123",
      "author": "T-Series Regional",
      "videoUrl": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
      "description": "Compact tractor for small farms...",
      "subscriber": "25254545 Subscribers",
      "isLive": false,
      "image": "assets/AgriProduct/Agribull _IMG 4.png",
    }),
    VideoModel.fromJson({
      "id": "11",
      "title": "Agri Grabber",
      "thumbnailUrl": "https://img.jakpost.net/c/2019/09/03/2019_09_03_78912_1567484272._large.jpg",
      "duration": "8:18",
      "uploadTime": "May 9, 2011",
      "views": "24,969,123",
      "author": "T-Series Regional",
      "videoUrl": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
      "description": "Heavy-duty grabber for agriculture...",
      "subscriber": "25254545 Subscribers",
      "isLive": false,
      "image": "assets/AgriProduct/Agribull_IMG 5 .png",
    }),
    VideoModel.fromJson({
      "id": "12",
      "title": "Agri mini Grabber",
      "thumbnailUrl": "https://img.jakpost.net/c/2019/09/03/2019_09_03_78912_1567484272._large.jpg",
      "duration": "8:18",
      "uploadTime": "May 9, 2011",
      "views": "24,969,123",
      "author": "T-Series Regional",
      "videoUrl": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
      "description": "Heavy-duty grabber for agriculture...",
      "subscriber": "25254545 Subscribers",
      "isLive": false,
      "image": "assets/AgriProduct/Agribull _IMG 6.png",
    }),
  ];

  final List<VideoModel> nonAgriItems = [
    VideoModel.fromJson({
      "id": "1",
      "title": "BULL GARNDIA",
      "thumbnailUrl": "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Big_Buck_Bunny_thumbnail_vlc.png/1200px-Big_Buck_Bunny_thumbnail_vlc.png",
      "duration": "8:18",
      "uploadTime": "May 9, 2011",
      "views": "24,969,123",
      "author": "Vlc Media Player",
      "videoUrl": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
      "description": "Big Buck Bunny tells the story of a giant rabbit...",
      "subscriber": "25254545 Subscribers",
      "isLive": true,
      "image": "assets/NonAgriProduct/NonAgribull _IMG 1.png",
    }),
    VideoModel.fromJson({
      "id": "3",
      "title": "BULL GARNDIA",
      "thumbnailUrl": "https://i.ytimg.com/vi/Dr9C2oswZfA/maxresdefault.jpg",
      "duration": "8:18",
      "uploadTime": "May 9, 2011",
      "views": "24,969,123",
      "author": "T-Series Regional",
      "videoUrl": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
      "description": "Song : Raja Raja Kareja Mein Samaja...",
      "subscriber": "25254545 Subscribers",
      "isLive": true,
      "image": "assets/NonAgriProduct/NonAgribull _IMG 2.png",
    }),
    VideoModel.fromJson({
      "id": "2",
      "title": "BULL GARNDIA",
      "thumbnailUrl": "https://i.ytimg.com/vi_webp/gWw23EYM9VM/maxresdefault.webp",
      "duration": "12:18",
      "uploadTime": "May 9, 2011",
      "views": "24,969,123",
      "author": "Blender Inc.",
      "videoUrl": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
      "description": "Song : Raja Raja Kareja Mein Samaja...",
      "subscriber": "25254545 Subscribers",
      "isLive": true,
      "image": "assets/NonAgriProduct/NonAgribull _IMG 3.png",
    }),
  ];

  Map<String, String> localVideoPaths = {};

  @override
  void initState() {
    super.initState();
    _loadEmployeeId();
    _downloadVideos();
  }

  Future<void> _loadEmployeeId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final employeeId = prefs.getString('employeeId') ?? 'User';
      print('Loaded employeeId: $employeeId');
      setState(() {
        _employeeId = employeeId;
      });
    } catch (e) {
      debugPrint('Error loading employeeId: $e');
    }
  }

  Future<void> _downloadVideos() async {
    final directory = await getApplicationDocumentsDirectory();
    final allItems = [...agriItems, ...nonAgriItems];
    for (var item in allItems) {
      final videoUrl = item.videoUrl;
      final fileName = videoUrl.split('/').last;
      final filePath = '${directory.path}/$fileName';
      final file = File(filePath);
      if (!await file.exists()) {
        try {
          final response = await http.get(Uri.parse(videoUrl));
          if (response.statusCode == 200) {
            await file.writeAsBytes(response.bodyBytes);
            setState(() {
              localVideoPaths[videoUrl] = filePath;
            });
            debugPrint('Downloaded: $fileName');
          } else {
            debugPrint('Failed to download $fileName: ${response.statusCode}');
          }
        } catch (e) {
          debugPrint('Error downloading $fileName: $e');
        }
      } else {
        setState(() {
          localVideoPaths[videoUrl] = filePath;
        });
        debugPrint('Already downloaded: $fileName');
      }
    }
  }

  Future<void> _logout() async {
    bool deletionSuccess = true;
    final directory = await getApplicationDocumentsDirectory();
    for (var localPath in localVideoPaths.values) {
      final file = File(localPath);
      if (await file.exists()) {
        try {
          await file.delete();
          debugPrint('Deleted: $localPath');
        } catch (e) {
          debugPrint('Error deleting $localPath: $e');
          deletionSuccess = false;
        }
      }
    }
    setState(() {
      localVideoPaths.clear();
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('employeeId');
      await prefs.remove('isLoggedIn');
      await prefs.remove('language');
      debugPrint('SharedPreferences cleared: employeeId, isLoggedIn, language');
    } catch (e, stackTrace) {
      debugPrint('Error clearing SharedPreferences: $e');
      debugPrint('Stack trace: $stackTrace');
      deletionSuccess = false;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          deletionSuccess
              ? 'Videos and data deleted successfully'
              : 'Error deleting some data',
        ),
        backgroundColor: deletionSuccess ? Colors.green.shade300 : Colors.red,
      ),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Loginscreen()),
          (Route<dynamic> route) => false,
    );
  }

  void _navigateToScreen(BuildContext context, VideoModel item) {
    List<VideoModel> videoList;
    int videoIndex;

    // Determine if the item is Agri or Non-Agri and set the appropriate list and index
    if (agriItems.contains(item)) {
      videoList = agriItems;
      videoIndex = agriItems.indexOf(item);
      debugPrint('Navigating to Agri item: ${item.title}, Index: $videoIndex, List length: ${videoList.length}');
    } else if (nonAgriItems.contains(item)) {
      videoList = nonAgriItems;
      videoIndex = nonAgriItems.indexOf(item);
      debugPrint('Navigating to Non-Agri item: ${item.title}, Index: $videoIndex, List length: ${videoList.length}');
    } else {
      // Fallback to combined list if item not found (shouldn't happen)
      videoList = [...agriItems, ...nonAgriItems];
      videoIndex = videoList.indexOf(item);
      debugPrint('Fallback: Navigating to item: ${item.title}, Index: $videoIndex, List length: ${videoList.length}');
    }

    final localPath = localVideoPaths[item.videoUrl] ?? item.videoUrl;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OverviewScreen(
          videoModel: item,
          localPath: localPath,
          videoIndex: videoIndex,
          videoList: videoList,
          localVideoPaths: localVideoPaths,
          selectedIndex: 0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final bannerHeight = (screenHeight * 0.2).clamp(100.0, 150.0);
    const listViewHeight = 256.0; // Accommodates 240 height + 8.0 top + 8.0 bottom margin
    final spacing = (screenHeight * 0.015).clamp(05.0, 10.0);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/bull-machine-logo 1.png',
          height: 30,
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.login_outlined,
                    color: Colors.black,
                    size: 30,
                  ),
                  tooltip: 'Logout',
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to log out? This will delete all downloaded videos.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel',),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Logout'),
                          ),
                        ],
                      ),
                    );
                    if (confirm == true) {
                      await _logout();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: bannerHeight,
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                margin: EdgeInsets.only(bottom: spacing),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFB92F),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Welcome Rajesh..!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF000000),
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 5),
                    Expanded(
                      child: Text(
                        'This content is loaded in English. To change the language, please Logout and pick a different one.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF000000),
                        ),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5.0),
              const Column(
                children: [
                  Text(
                    '  Agri Products:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF000000)),
                  ),
                ],
              ),
              // SizedBox(height: spacing),
              SizedBox(
                height: listViewHeight,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: agriItems.length,
                  itemBuilder: (context, index) {
                    final item = agriItems[index];
                    final String displayText = item.title;
                    final String imagePath = item.image ?? 'assets/bull_bg_image.png';
                    return GestureDetector(
                      onTap: () => _navigateToScreen(context, item),
                      child: Container(
                        width: 161.84,
                        height: 240,
                        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    imagePath,
                                    width: 145.84,
                                    height: 190,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => const Icon(
                                      Icons.error,
                                      size: 40,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 8,
                                    left: 8,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        displayText,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: spacing),
              const Column(
                children: [
                  Text(
                    '  Non-Agri Products:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF000000)),
                  ),
                ],
              ),
              // SizedBox(height: spacing),
              SizedBox(
                height: listViewHeight,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: nonAgriItems.length,
                  itemBuilder: (context, index) {
                    final item = nonAgriItems[index];
                    final String displayText = item.title;
                    final String imagePath = item.image ?? 'assets/bull_bg_image.png';
                    return GestureDetector(
                      onTap: () => _navigateToScreen(context, item),
                      child: Container(
                        width: 161.84,
                        height: 240,
                        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    imagePath,
                                    width: 145.84,
                                    height: 190,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => const Icon(
                                      Icons.error,
                                      size: 40,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 8,
                                    left: 8,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        displayText,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: spacing),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Explore more products!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}