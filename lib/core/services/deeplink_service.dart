import 'package:url_launcher/url_launcher.dart';

class DeeplinkService {
  static Future<void> handleDeepLink(String? url) async {
    if (url == null || url.isEmpty) {
      print('No URL provided');
      return;
    }

    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        print('Could not launch URL: $url');
      }
    } catch (e) {
      print('Error launching URL: $url, Error: $e');
    }
  }
}
