// ignore: file_names
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationBar extends StatelessWidget {
  const BottomNavigationBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('BottomNavigationBar'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: navigationShell),
      bottomNavigationBar: NavigationBar(destinations: [
        NavigationDestination(
          icon: Icon(Icons.home),
         label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.map),
          label: 'Map',
        ),
        NavigationDestination(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: (int tappedIndex) => navigationShell.goBranch(tappedIndex)
      ),
    );
  }
}