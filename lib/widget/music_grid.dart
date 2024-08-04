import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data.dart';
import '../pages/player_page.dart';
import 'music_card.dart';

class MusicGrid extends StatelessWidget {
  const MusicGrid({super.key, required this.list});

  final RxList<Media> list;

  @override
  Widget build(BuildContext context) {
    final c = Get.find<Controller>();
    return Obx(() {
      return GridView.builder(
        itemCount: list.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 175,
          childAspectRatio: 165 / 220,
        ),
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) => FittedBox(
          child: MusicCard(
            media: list[index],
            onTap: (heroTag) {
              if (!listEquals(c.playlist, list)) c.playlist(list);
              c.playIndex(index);
              Get.to(() => PlayerPage(heroTag));
              c.player.play(c.curMedia.source);
            },
          ),
        ),
      );
    });
  }
}
