import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class PDFViewerScreen extends StatefulWidget {
  final String pdfPath;

  const PDFViewerScreen({required this.pdfPath});

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  String? _filePath;

  @override
  void initState() {
    super.initState();
    print('Initializing PDFViewerScreen with path: ${widget.pdfPath}');
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      // Load the asset as bytes
      print('Loading PDF asset from: ${widget.pdfPath}');
      final byteData = await rootBundle.load(widget.pdfPath);
      final bytes = byteData.buffer.asUint8List();

      // Write to a temporary file
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/sample_pdf1.pdf');
      print('Writing PDF to temporary file: ${tempFile.path}');
      await tempFile.writeAsBytes(bytes);

      setState(() {
        _filePath = tempFile.path;
        print('PDF file path set to: $_filePath');
      });
    } catch (e) {
      // Enhanced error logging
      print('Error loading PDF asset: $e');
      print('Error type: ${e.runtimeType}');
      print('Stack trace: ${StackTrace.current}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading PDF: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Building PDFViewerScreen - PDF path received: ${widget.pdfPath}');
    print('Current file path to load: $_filePath');
    return Scaffold(
      appBar: AppBar(title: const Text('PDF Viewer')),
      body: _filePath == null
          ? const Center(child: CircularProgressIndicator())
          : PDFView(
        filePath: _filePath!,
        onError: (error) {
          // Detailed error logging for PDFView
          print('PDF Loading Error: $error');
          print('Error type: ${error.runtimeType}');
          print('Stack trace: ${StackTrace.current}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $error')),
          );
        },
        onPageError: (page, error) {
          // Detailed error logging for page-specific issues
          print('PDF Page $page Error: $error');
          print('Error type: ${error.runtimeType}');
          print('Stack trace: ${StackTrace.current}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Page $page Error: $error')),
          );
        },
        onRender: (pages) {
          print('PDF rendered successfully with $pages pages');
        },
      ),
    );
  }
}