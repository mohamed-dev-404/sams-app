
import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FilePreviewScreen extends StatefulWidget {
  final String url;
  final String fileName;

  const FilePreviewScreen({
    super.key,
    required this.url,
    required this.fileName,
  });

  @override
  State<FilePreviewScreen> createState() => _FilePreviewScreenState();
}

class _FilePreviewScreenState extends State<FilePreviewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    // Using Google Docs Viewer for In-App Preview
    final String googleDocUrl =
        'https://docs.google.com/gview?embedded=true&url=${widget.url}';

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            if (mounted) setState(() => _isLoading = false);
          },
        ),
      )
      ..loadRequest(Uri.parse(googleDocUrl));
  }

  // Method to launch external applications or browser
  Future<void> _launchExternal(LaunchMode mode) async {
    final Uri uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: mode);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch the file')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.fileName,
          style: AppStyles.mobileTitleSmallSb.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        leading: const BackButton(color: Colors.white),
        actions: [
          IconButton(
            tooltip: 'Open in external app',
            icon: const Icon(Icons.open_in_new_rounded, color: Colors.white),
            onPressed: () => _launchExternal(LaunchMode.externalApplication),
          ),
          IconButton(
            tooltip: 'Download file',
            icon: const Icon(
              Icons.download_for_offline_rounded,
              color: Colors.white,
            ),
            onPressed: () => _launchExternal(LaunchMode.platformDefault),
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
