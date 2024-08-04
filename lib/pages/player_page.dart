import 'package:amc/widget/apple_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

import '../widget/future_container.dart';
import '../data.dart';
import '../widget/music_cover.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage(this.heroTag, {super.key});

  final Object heroTag;

  @override
  Widget build(BuildContext context) {
    return DragToMoveArea(
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: FittedBox(
              child: SizedBox(
                width: 1280,
                height: 720,
                child: Row(
                  children: [
                    LeftInfo(heroTag: heroTag),
                    Expanded(child: Container()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LeftInfo extends StatefulWidget {
  const LeftInfo({super.key, required this.heroTag});

  final Object heroTag;

  @override
  State<LeftInfo> createState() => _LeftInfoState();
}

class _LeftInfoState extends State<LeftInfo> {
  final c = Get.find<Controller>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: SizedBox(
          width: 350,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 8,
                width: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.2)
                      : Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                clipBehavior: Clip.antiAlias,
                child: InkWell(onTap: () => Get.back()),
              ),
              const SizedBox(height: 16),
              Hero(
                tag: widget.heroTag,
                child: Obx(() {
                  return MusicCover(
                    media: c.curMedia,
                    size: 350,
                    animate: false,
                  );
                }),
              ),
              const SizedBox(height: 16),
              Obx(() => MusicInfo(c.curMedia)),
              const SizedBox(height: 16),
              Obx(() {
                return AppleSlider(
                  value: c.position().inMilliseconds.toDouble(),
                  total: c.duration().inMilliseconds.toDouble(),
                  onChange: (value) => c.player.seek(value.ms),
                );
              }),
              const SizedBox(height: 4),
              const PlayCtrl(),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    CupertinoIcons.volume_down,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white.withOpacity(0.6)
                        : Colors.black.withOpacity(0.6),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Obx(() {
                      return AppleSlider(
                        value: c.volume(),
                        onChange: c.volume.call,
                      );
                    }),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    CupertinoIcons.volume_up,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white.withOpacity(0.6)
                        : Colors.black.withOpacity(0.6),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayCtrl extends StatelessWidget {
  const PlayCtrl({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<Controller>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {
            final index = c.playIndex();
            if (index == 0) {
              c.playIndex(c.playlist.length - 1);
            } else {
              c.playIndex(index - 1);
            }
            c.player.play(c.curMedia.source);
          },
          icon: const Icon(CupertinoIcons.backward_fill),
        ),
        IconButton(
          onPressed: () {
            if (c.isPlaying) {
              c.player.pause();
            } else {
              c.player.play(c.curMedia.source);
            }
          },
          iconSize: 36,
          icon: Obx(() => Icon(
                c.isPlaying
                    ? CupertinoIcons.pause_fill
                    : CupertinoIcons.play_fill,
              )),
        ),
        IconButton(
          onPressed: () {
            final index = c.playIndex();
            if (index == c.playlist.length - 1) {
              c.playIndex(0);
            } else {
              c.playIndex(index + 1);
            }
            c.player.play(c.curMedia.source);
          },
          icon: const Icon(CupertinoIcons.forward_fill),
        ),
      ],
    );
  }
}

class MusicInfo extends StatelessWidget {
  const MusicInfo(this.media, {super.key});

  final Media media;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureContainer(
                media.title,
                builder: (context, value) {
                  return Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  );
                },
              ),
              FutureContainer(
                media.artist,
                builder: (context, value) {
                  if (value == null) return const SizedBox.shrink();
                  return Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  );
                },
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.ellipsis),
        )
      ],
    );
  }
}
