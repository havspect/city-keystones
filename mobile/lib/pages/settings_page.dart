import 'package:city_keystones/state/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final user = ref.watch(fetchUserProvider);
    
    return user.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
      data: (userData) => Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Column(
          children: [
            ListTile(
              title: const Text('Name'),
              subtitle: Text(userData.name),
            ),
            ListTile(
              title: const Text('Email'),
              subtitle: Text(userData.email),
            ),
          ],
        ),
      ),
    );
  }
}