import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vernet/main.dart';
import 'package:vernet/models/dark_theme_provider.dart';
import 'package:vernet/ui/adaptive/adaptive_list.dart';
import 'package:vernet/ui/settings_dialog/custom_subnet_dialog.dart';
import 'package:vernet/ui/settings_dialog/first_subnet_dialog.dart';
import 'package:vernet/ui/settings_dialog/last_subnet_dialog.dart';
import 'package:vernet/ui/settings_dialog/ping_count_dialog.dart';
import 'package:vernet/ui/settings_dialog/socket_timeout_dialog.dart';
import 'package:vernet/ui/settings_dialog/theme_dialog.dart';
import 'package:vernet/values/strings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            child: AdaptiveListTile(
              title: const Text('Theme'),
              subtitle: Text(themeChange.themePref.name),
              onTap: () async {
                await showAdaptiveDialog(
                  context: context,
                  builder: (context) => const ThemeDialog(),
                );
                await appSettings.load();
                setState(() {});
              },
            ),
          ),
          Card(
            child: AdaptiveListTile(
              title: const Text('In-App Internet'),
              trailing: Switch(
                value: appSettings.inAppInternet,
                onChanged: (bool? value) async {
                  appSettings.setInAppInternet(value ?? false);
                  await appSettings.load();
                  setState(() {});
                },
              ),
            ),
          ),
          Card(
            child: AdaptiveListTile(
              title: const Text(StringValue.firstSubnet),
              subtitle: const Text(StringValue.firstSubnetDesc),
              trailing: Text(
                '${appSettings.firstSubnet}',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              onTap: () async {
                await showAdaptiveDialog(
                  context: context,
                  builder: (context) => const FirstSubnetDialog(),
                );
                await appSettings.load();
                setState(() {});
              },
            ),
          ),
          Card(
            child: AdaptiveListTile(
              title: const Text(StringValue.lastSubnet),
              subtitle: const Text(StringValue.lastSubnetDesc),
              trailing: Text(
                '${appSettings.lastSubnet}',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              onTap: () async {
                await showAdaptiveDialog(
                  context: context,
                  builder: (context) => const LastSubnetDialog(),
                );
                await appSettings.load();
                setState(() {});
              },
            ),
          ),
          Card(
            child: AdaptiveListTile(
              title: const Text(StringValue.socketTimeout),
              subtitle: const Text(StringValue.socketTimeoutdesc),
              trailing: Text(
                '${appSettings.socketTimeout} ms',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              onTap: () async {
                await showAdaptiveDialog(
                  context: context,
                  builder: (context) => const SocketTimeoutDialog(),
                );
                await appSettings.load();
                setState(() {});
              },
            ),
          ),
          Card(
            child: AdaptiveListTile(
              title: const Text(StringValue.pingCount),
              subtitle: const Text(StringValue.pingCountDesc),
              trailing: Text(
                '${appSettings.pingCount}',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              onTap: () async {
                await showAdaptiveDialog(
                  context: context,
                  builder: (context) => const PingCountDialog(),
                );
                await appSettings.load();
                setState(() {});
              },
            ),
          ),
          Card(
            child: AdaptiveListTile(
              title: const Text(StringValue.customSubnet),
              subtitle: const Text(StringValue.customSubnetDesc),
              trailing: Text(
                appSettings.customSubnet,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              onTap: () async {
                await showAdaptiveDialog(
                  context: context,
                  builder: (context) => const CustomSubnetDialog(),
                );
                await appSettings.load();
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  static const String _srcUrl = 'https://github.com/git-elliot/vernet';
  final String _issueUrl = '$_srcUrl/issues';
  final String _donateUrl = '$_srcUrl#support-and-donate';
}
