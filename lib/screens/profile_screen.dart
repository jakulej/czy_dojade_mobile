import 'package:flutter/material.dart';
import '../helpers/list_ext.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: theme.primaryColorLight,
        elevation: 4,
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.edit,
              size: 52,
            ),
            title: const Text(
              'Change username',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.key,
              size: 52,
            ),
            title: const Text(
              'Change password',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.star,
              size: 52,
            ),
            title: const Text(
              'Set favourite routes',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.monetization_on,
              size: 52,
            ),
            title: const Text(
              'Buy premium',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.person_off,
              size: 52,
              color: Colors.red,
            ),
            title: const Text(
              'Delete profile',
              style: TextStyle(fontSize: 18, color: Colors.red),
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
