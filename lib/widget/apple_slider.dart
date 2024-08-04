import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class AppleSlider extends StatefulWidget {
  const AppleSlider({
    super.key,
    required this.value,
    this.total = 1,
    this.unfocusHeight = 10,
    this.focusHeight = 20,
    this.duration = const Duration(milliseconds: 300),
    this.onInput,
    this.onChange,
  });

  final double value;
  final double total;
  final double unfocusHeight;
  final double focusHeight;
  final Duration duration;
  final void Function(double value)? onInput;
  final FutureOr<void> Function(double value)? onChange;

  @override
  State<AppleSlider> createState() => _AppleSliderState();
}

class _AppleSliderState extends State<AppleSlider> {
  var isFocus = false;
  var value = 0.0;

  @override
  Widget build(BuildContext context) {
    if (!isFocus) value = widget.value;
    return LayoutBuilder(builder: (context, con) {
      final width = value / widget.total * con.maxWidth;
      return SizedBox(
        height: widget.focusHeight,
        width: double.infinity,
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.focusHeight),
            child: GestureDetector(
              onHorizontalDragStart: (_) {
                if (widget.total == 0) return;
                setState(() => isFocus = true);
              },
              onHorizontalDragEnd: (_) async {
                if (widget.onChange != null) await widget.onChange!(value);
                setState(() => isFocus = false);
              },
              onHorizontalDragCancel: () async {
                if (widget.onChange != null) await widget.onChange!(value);
                setState(() => isFocus = false);
              },
              onHorizontalDragUpdate: (event) {
                if (widget.total == 0) return;
                final dx = event.delta.dx;
                final w = con.maxWidth;
                setState(() {
                  value =
                      min(max(value + dx / w * widget.total, 0), widget.total);
                });
                widget.onInput?.call(value);
              },
              child: AnimatedContainer(
                duration: widget.duration,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white.withOpacity(0.3)
                    : Colors.black.withOpacity(0.1),
                curve: Curves.ease,
                height: isFocus ? widget.focusHeight : widget.unfocusHeight,
                width: double.infinity,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: width.isNaN ? 0 : width,
                    height: double.infinity,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white.withOpacity(0.6)
                        : Colors.black.withOpacity(0.2),
                    child: const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
