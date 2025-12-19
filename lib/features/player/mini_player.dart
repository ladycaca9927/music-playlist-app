import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/provider/provider.dart';

class MiniPlayer extends HookConsumerWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final song = ref.watch(currentSongProvider);
    final player = ref.watch(audioPlayerProvider);

    final isPlaying = useStream(player.playingStream, initialData: false).data ?? false;

    if (song == null) return const SizedBox.shrink();

    return SafeArea(
      top: false,
      child: GestureDetector(
        onTap: () {
          if (!context.mounted) return;
          context.push('/player');
        },
        child: Container(
          height: 72, // 🔥 Bigger height
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF282828),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, -2))],
          ),
          child: Row(
            children: [
              // Album art
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(song.coverUrl, width: 48, height: 48, fit: BoxFit.cover),
              ),

              const SizedBox(width: 12),

              // Song info
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      song.title,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      song.artist,
                      style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Play / Pause
              IconButton(
                iconSize: 32,
                icon: Icon(isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill, color: Colors.white),
                onPressed: () {
                  isPlaying ? player.pause() : player.play();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
