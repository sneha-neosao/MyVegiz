import 'package:flutter/material.dart';

/// common gradient app loading widget
class AnimatedGradientCircularProgress extends StatefulWidget {
  final List<Color> colors;
  final double size;
  final double strokeWidth;

  const AnimatedGradientCircularProgress({
    super.key,
    required this.colors,
    this.size = 40.0,
    this.strokeWidth = 4.0,
  });

  @override
  State<AnimatedGradientCircularProgress> createState() =>
      _AnimatedGradientCircularProgressState();
}

class _AnimatedGradientCircularProgressState
    extends State<AnimatedGradientCircularProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Add some padding to prevent clipping from stroke
    final double effectiveSize = widget.size + widget.strokeWidth;

    return SizedBox(
      width: effectiveSize,
      height: effectiveSize,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 6.28319, // 2 * pi
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return SweepGradient(
                  colors: widget.colors,
                  startAngle: 0.0,
                  endAngle: 3.14 * 2,
                  tileMode: TileMode.clamp,
                ).createShader(bounds);
              },
              blendMode: BlendMode.srcIn,
              child: Padding(
                padding: EdgeInsets.all(widget.strokeWidth / 2),
                child: CircularProgressIndicator(
                  strokeWidth: widget.strokeWidth,
                  valueColor:
                  const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
