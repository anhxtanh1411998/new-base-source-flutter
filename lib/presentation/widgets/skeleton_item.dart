import 'package:flutter/material.dart';

/// A customizable skeleton loading widget that can be used for list items.
///
/// This widget displays a placeholder UI while content is loading.
class SkeletonItem extends StatelessWidget {
  /// The width of the skeleton item
  final double? width;

  /// The height of the skeleton item
  final double? height;

  /// The border radius of the skeleton item
  final double borderRadius;

  /// The color of the skeleton item
  final Color? color;

  /// Whether to show the shimmer effect
  final bool isShimmerEffect;

  /// The duration of the shimmer effect animation
  final Duration shimmerDuration;

  /// The child widget to display
  final Widget? child;

  /// The padding around the skeleton item
  final EdgeInsetsGeometry? padding;

  /// Creates a [SkeletonItem].
  const SkeletonItem({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 8.0,
    this.color,
    this.isShimmerEffect = true,
    this.shimmerDuration = const Duration(milliseconds: 1500),
    this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = color ?? theme.colorScheme.surfaceContainerHighest;

    Widget content;

    if (child != null) {
      content = child!;
    } else {
      content = Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: effectiveColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      );
    }

    if (padding != null) {
      content = Padding(
        padding: padding!,
        child: content,
      );
    }

    if (!isShimmerEffect) {
      return content;
    }

    return _ShimmerEffect(
      duration: shimmerDuration,
      child: content,
    );
  }

  /// Creates a skeleton item for a list tile.
  static Widget listTile({
    Key? key,
    double height = 80.0,
    bool hasLeading = true,
    bool hasTrailing = false,
    double borderRadius = 8.0,
    Color? color,
    bool isShimmerEffect = true,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  }) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          if (hasLeading) ...[
            SkeletonItem(
              width: 48.0,
              height: 48.0,
              borderRadius: 24.0,
              color: color,
              isShimmerEffect: isShimmerEffect,
            ),
            const SizedBox(width: 16.0),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SkeletonItem(
                  width: double.infinity,
                  height: 16.0,
                  borderRadius: borderRadius,
                  color: color,
                  isShimmerEffect: isShimmerEffect,
                ),
                const SizedBox(height: 8.0),
                SkeletonItem(
                  width: 150.0,
                  height: 12.0,
                  borderRadius: borderRadius,
                  color: color,
                  isShimmerEffect: isShimmerEffect,
                ),
              ],
            ),
          ),
          if (hasTrailing) ...[
            const SizedBox(width: 16.0),
            SkeletonItem(
              width: 24.0,
              height: 24.0,
              borderRadius: borderRadius,
              color: color,
              isShimmerEffect: isShimmerEffect,
            ),
          ],
        ],
      ),
    );
  }

  /// Creates a skeleton item for a grid tile.
  static Widget gridTile({
    Key? key,
    double width = 150.0,
    double height = 200.0,
    double borderRadius = 8.0,
    Color? color,
    bool isShimmerEffect = true,
    EdgeInsetsGeometry padding = const EdgeInsets.all(8.0),
  }) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonItem(
            width: width,
            height: height * 0.7,
            borderRadius: borderRadius,
            color: color,
            isShimmerEffect: isShimmerEffect,
          ),
          const SizedBox(height: 8.0),
          SkeletonItem(
            width: width,
            height: 16.0,
            borderRadius: borderRadius,
            color: color,
            isShimmerEffect: isShimmerEffect,
          ),
          const SizedBox(height: 4.0),
          SkeletonItem(
            width: width * 0.7,
            height: 12.0,
            borderRadius: borderRadius,
            color: color,
            isShimmerEffect: isShimmerEffect,
          ),
        ],
      ),
    );
  }
}

/// A widget that applies a shimmer effect to its child.
class _ShimmerEffect extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const _ShimmerEffect({
    required this.child,
    required this.duration,
  });

  @override
  _ShimmerEffectState createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<_ShimmerEffect> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween<double>(begin: -2.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutSine,
      ),
    );

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: const [
                Color(0x00FFFFFF),
                Color(0x66FFFFFF),
                Color(0x00FFFFFF),
              ],
              stops: [
                0.0 + ((_animation.value + 2) / 4),
                0.5 + ((_animation.value + 2) / 4),
                1.0 + ((_animation.value + 2) / 4),
              ],
            ).createShader(bounds);
          },
          child: child,
        );
      },
    );
  }
}
