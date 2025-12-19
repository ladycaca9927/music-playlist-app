import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/player/mini_player.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    int index = location.startsWith('/search')
        ? 1
        : location.startsWith('/library')
        ? 2
        : 0;

    return Scaffold(
      body: child,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const MiniPlayer(),
          BottomNavigationBar(
            currentIndex: index,
            backgroundColor: const Color(0xFF121212),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            onTap: (i) {
              if (i == 0) context.go('/');
              if (i == 1) context.go('/search');
              if (i == 2) context.go('/library');
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_music),
                label: 'Library',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
