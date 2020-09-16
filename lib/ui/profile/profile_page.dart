import 'package:avgleclient/error_notifier.dart';
import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/debug/debug_page.dart';
import 'package:avgleclient/ui/developer/developer_page.dart';
import 'package:avgleclient/ui/profile/profile_view_model.dart';
import 'package:avgleclient/ui/profile/widgets/profile_top_signed_in.dart';
import 'package:avgleclient/ui/profile/widgets/profile_top_signed_out.dart';
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
                ProfileTopSignedIn(
                  viewModel: viewModel,
                )
              else
                ProfileTopSignedOut(
                  viewModel: viewModel,
                ),
              const Divider(),
              ListTile(
                title: const Text(Strings.profileLicense),
                onTap: () {
                  showLicensePage(
                      context: context,
                      applicationName: 'Avgle',
                      applicationVersion: Strings.appVersion,
                      applicationLegalese: 'developed by batch(@b4tchkn).');
                },
              ),
              ListTile(
                title: const Text(Strings.profileDeveloper),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (_) => DeveloperPage()),
                  );
                },
              ),
              const ListTile(
                title: Text(Strings.profileAppVersion),
                trailing: Text(Strings.appVersion),
              ),
              // const Divider(),
              // FlatButton(
              //   child: const Text(Strings.debugPageTitle),
              //   color: AppColors.lightGrey,
              //   onPressed: () {
              //     Navigator.of(context).push(
              //       MaterialPageRoute<void>(builder: (_) => DebugPage()),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
