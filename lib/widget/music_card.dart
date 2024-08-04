import 'package:flutter/material.dart';

import '../data.dart';
import 'future_container.dart';
import 'music_cover.dart';

class MusicCard extends StatefulWidget {
  const MusicCard({super.key, required this.media, this.onTap});
  final Media media;
  final void Function(UniqueKey heroTag)? onTap;

  @override
  State<MusicCard> createState() => _MusicCardState();
}

class _MusicCardState extends State<MusicCard> {
  var elevation = 1.0;
  final heroTag = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      width: 165,
      child: Card(
        elevation: elevation,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            widget.onTap?.call(heroTag);
          },
          onTapDown: (_) => setState(() => elevation = 8),
          onTapUp: (_) => setState(() => elevation = 1),
          onTapCancel: () => setState(() => elevation = 1),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: Hero(
                tag: heroTag,
                child: MusicCover(media: widget.media, size: 149),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Center(
                  child: FutureContainer(
                    widget.media.title,
                    builder: (context, value) => Text(
                      value,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
