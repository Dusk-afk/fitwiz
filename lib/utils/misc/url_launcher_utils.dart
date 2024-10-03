import 'package:url_launcher/url_launcher_string.dart';

class UrlLauncherUtils {
  static void launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url, mode: LaunchMode.inAppBrowserView);
    } else {
      throw 'Could not launch $url';
    }
  }
}
