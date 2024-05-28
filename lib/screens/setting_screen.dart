import 'package:czy_dojade/helpers/list_ext.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationSwitch = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: theme.primaryColorLight,
        elevation: 4,
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.notifications,
              size: 52,
            ),
            title: const Text(
              'Notifications',
              style: TextStyle(fontSize: 18),
            ),
            trailing: Switch(
              value: notificationSwitch,
              onChanged: (val) {
                setState(() {
                  notificationSwitch = val;
                });
              },
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.language,
              size: 52,
            ),
            title: const Text(
              'Change language',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {},
          ),
        ]..divide(
            divider: Divider(
              height: 2,
              color: theme.primaryColor,
            ),
            dividerAtEnd: true,
          ),
      ),
    );
  }
}
