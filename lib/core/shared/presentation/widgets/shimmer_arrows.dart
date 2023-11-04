import 'package:flutter/material.dart';

import '../../../theme/sh_icons.dart';

enum ShimmerArrowDirection { up, right, down, left }

class ShimmerArrows extends StatefulWidget {
  const ShimmerArrows({
    super.key,
    required this.direction,
  });

  final ShimmerArrowDirection direction;

  @override
  State<ShimmerArrows> createState() => _ShimmerArrowsState();
}

class _ShimmerArrowsState extends State<ShimmerArrows>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController.unbounded(vsync: this)
      ..repeat(
        min: -0.5,
        max: 1.5,
        period: const Duration(seconds: 1),
      );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: widget.direction.index,
      child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: const [Colors.white10, Colors.white, Colors.white10],
                  stops: const [0.0, 0.3, 1],
                  transform: _SlideGradientTransition(
                    percent: _controller.value,
                  ),
                ).createShader(bounds),
                child: child,
              ),
          child: const Column(
            children: [
              Align(heightFactor: .4, child: Icon(SHIcons.arrowUp)),
              Align(heightFactor: .4, child: Icon(SHIcons.arrowUp)),
              Align(heightFactor: .4, child: Icon(SHIcons.arrowUp)),
            ],
          )),
    );
  }
}

class _SlideGradientTransition extends GradientTransform {
  final double percent;

  const _SlideGradientTransition({required this.percent});
  @override
  Matrix4? transform(Rect bound, {TextDirection? textDirection}) {
    return Matrix4.translationValues(0, -bound.height * percent, 0);
  }
}
