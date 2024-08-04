import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../data.dart';
import 'future_container.dart';

class MusicCover extends StatelessWidget {
  const MusicCover({
    super.key,
    required this.media,
    required this.size,
    this.animate = true,
  });

  final Media media;
  final double size;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox.square(
        dimension: size,
        child: FutureContainer(
          media.image,
          builder: (context, value) {
            if (value == null) return const SizedBox.shrink();
            return animate ? value.animate(delay: 0.3.s).fade() : value;
          },
          progressIndicatorType: ProgressIndicatorType.circular,
        ),
      ),
    );
  }
}
