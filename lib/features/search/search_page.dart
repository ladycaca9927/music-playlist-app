import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';

import '../../core/provider/provider.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

class SearchPage extends HookConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);
    final playlists = ref.watch(demoPlaylistsProvider);

    final results = playlists
        .where(
          (p) => p.title.toLowerCase().contains(query.toLowerCase()),
    )
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (v) =>
              ref.read(searchQueryProvider.notifier).state = v,
              decoration: InputDecoration(
                hintText: 'What do you want to listen to?',
                filled: true,
                fillColor: const Color(0xFF282828),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: results.isEmpty
                ? const Center(
              child: Text(
                'No results',
                style: TextStyle(color: Colors.grey),
              ),
            )
                : ListView.builder(
              itemCount: results.length,
              itemBuilder: (_, i) {
                final playlist = results[i];
                return ListTile(
                  leading: Image.network(
                    playlist.coverUrl,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    playlist.title,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
