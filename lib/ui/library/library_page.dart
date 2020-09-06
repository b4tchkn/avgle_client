import 'package:avgleclient/data/provider/user_stream_provider.dart';
import 'package:avgleclient/ui/library/widgets/library_page_singed_in.dart';
import 'package:avgleclient/ui/library/widgets/library_page_singned_out.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LibraryPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: useProvider(userStreamProvider),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return LibraryPageSignedOut();
          } else {
            return LibraryPageSignedIn();
          }
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
