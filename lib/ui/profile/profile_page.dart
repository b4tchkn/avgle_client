import 'package:avgleclient/error_notifier.dart';
import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/debug/debug_page.dart';
import 'package:avgleclient/ui/profile/profile_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfilePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final error = useProvider(errorNotifierProvider);
    final viewModel = useProvider(profileViewModelNotifierProvider);
    final fetchUser =
        useMemoized(() => viewModel.fetchUser(), [error.peekContent()?.type]);
    useFuture(fetchUser);

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.profileAppBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (viewModel.user != null)
                Text(viewModel.user.toString())
              else
                const Text('ログインしてね'),
              FlatButton(
                child: const Text(Strings.profileSignInWithGoogle),
                color: AppColors.lightGrey,
                onPressed: () {
                  viewModel.signIn();
                },
              ),
              FlatButton(
                child: const Text(Strings.profileSignOut),
                color: AppColors.lightGrey,
                onPressed: () {
                  viewModel.signOut();
                },
              ),
              FlatButton(
                child: const Text('Userとる'),
                color: AppColors.lightGrey,
                onPressed: () {
                  viewModel.fetchUser();
                },
              ),
              const Divider(),
              FlatButton(
                child: const Text(Strings.debugPageTitle),
                color: AppColors.lightGrey,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (_) => DebugPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
