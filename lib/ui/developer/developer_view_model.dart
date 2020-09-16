import 'package:url_launcher/url_launcher.dart';

class DeveloperViewModel {
  Future<void> launchTwitter(String url, String secondUrl) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      await launch(secondUrl);
    }
  }
}
