import 'package:avgleclient/ui/developer/developer_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeveloperPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Material(
                shape: const CircleBorder(),
                clipBehavior: Clip.hardEdge,
                child: Image.asset(
                  'assets/images/usagi.png',
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'batch',
                style: TextStyle(fontSize: 24),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text('I love developing Android and Flutter apps.'),
            ),
            GestureDetector(
              onTap: () {
                final viewModel = DeveloperViewModel();
                const url = 'twitter://user?screen_name=b4tchkn';
                const secondUrl = 'https://twitter.com/b4tchkn';
                viewModel.launchTwitter(url, secondUrl);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/icon_twitter.png',
                    height: 24,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Text('@b4tchkn'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
