import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/home_page.dart';
import '../../features/library/library_page.dart';
import '../../features/main_scaffold.dart';
import '../../features/player/player_page.dart';
import '../../features/playlist/playlist_page.dart';
import '../../features/search/search_page.dart';
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return MainScaffold(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (_, __) => const HomePage(),
          ),
          GoRoute(
            path: '/search',
            builder: (_, __) => const SearchPage(),
          ),
          GoRoute(
            path: '/library',
            builder: (_, __) => const LibraryPage(),
          ),
        ],
      ),
      GoRoute(
        path: '/playlist',
        builder: (_, __) => const PlaylistPage(),
      ),
      GoRoute(
        path: '/player',
        builder: (_, __) => const PlayerPage(),
      ),
    ],
  );
});

