import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FutureContainer<T> extends StatelessWidget {
  const FutureContainer(
    this.future, {
    super.key,
    required this.builder,
    this.progressIndicatorType = ProgressIndicatorType.linear,
  });
  final Future<T> future;
  final Widget Function(BuildContext context, T value) builder;
  final ProgressIndicatorType progressIndicatorType;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return builder(context, snapshot.data as T);
        } else if (snapshot.hasError) {
          return SelectableText(
              '${'Error'.tr}:\n${snapshot.error}\n\n${'Stack Trace'.tr}:\n${snapshot.stackTrace}');
        }
        if (progressIndicatorType == ProgressIndicatorType.linear) {
          return Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: const LinearProgressIndicator(),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

enum ProgressIndicatorType {
  linear,
  circular,
}
