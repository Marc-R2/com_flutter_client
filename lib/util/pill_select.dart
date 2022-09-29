import 'package:flutter/material.dart';

class PillSelect extends StatelessWidget {
  const PillSelect({
    super.key,
    this.selected = true,
    this.onChanged,
    this.child,
    this.color = Colors.blue,
    this.duration,
    this.radius = 128,
    this.innerPadding,
    this.outerPadding,
  });

  final bool selected;
  final Color color;
  final void Function(bool)? onChanged;
  final Widget? child;
  final Duration? duration;
  final double radius;
  final EdgeInsets? innerPadding;
  final EdgeInsets? outerPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: outerPadding ?? const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: () => onChanged?.call(!selected),
        borderRadius: BorderRadius.circular(radius),
        child: AnimatedContainer(
          padding: innerPadding ?? const EdgeInsets.all(8),
          duration: duration ?? const Duration(milliseconds: 256),
          decoration: BoxDecoration(
            color: selected ? color : Colors.transparent,
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(radius),
          ),
          child: child,
        ),
      ),
    );
  }
}
