import 'package:flutter/material.dart';

/// A customizable loading indicator widget that can be used throughout the application.
///
/// This loading indicator supports different styles and sizes.
class LoadingIndicator extends StatelessWidget {
  /// The type of loading indicator to display
  final LoadingIndicatorType type;

  /// The color of the loading indicator
  final Color? color;

  /// The size of the loading indicator
  final double size;

  /// The stroke width of the loading indicator (for circular and linear types)
  final double strokeWidth;

  /// The background color of the loading indicator (for linear type)
  final Color? backgroundColor;

  /// The value of the loading indicator (0.0 to 1.0) for determinate progress
  final double? value;

  /// The text to display below the loading indicator
  final String? text;

  /// The text style for the loading text
  final TextStyle? textStyle;

  /// The spacing between the loading indicator and the text
  final double textSpacing;

  /// Whether to show the loading indicator in a container with padding
  final bool withPadding;

  /// The padding around the loading indicator
  final EdgeInsetsGeometry padding;

  /// Creates a [LoadingIndicator].
  const LoadingIndicator({
    super.key,
    this.type = LoadingIndicatorType.circular,
    this.color,
    this.size = 40.0,
    this.strokeWidth = 4.0,
    this.backgroundColor,
    this.value,
    this.text,
    this.textStyle,
    this.textSpacing = 16.0,
    this.withPadding = false,
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = color ?? theme.colorScheme.primary;
    final effectiveBackgroundColor = backgroundColor ?? theme.colorScheme.surfaceContainerHighest;
    final effectiveTextStyle = textStyle ?? theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurface,
    );

    Widget indicator;

    switch (type) {
      case LoadingIndicatorType.circular:
        indicator = SizedBox(
          width: size,
          height: size,
          child: value != null
              ? CircularProgressIndicator(
                  value: value,
                  strokeWidth: strokeWidth,
                  valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
                  backgroundColor: effectiveBackgroundColor,
                )
              : CircularProgressIndicator(
                  strokeWidth: strokeWidth,
                  valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
                  backgroundColor: effectiveBackgroundColor,
                ),
        );
        break;
      case LoadingIndicatorType.linear:
        indicator = SizedBox(
          width: size * 5,
          child: value != null
              ? LinearProgressIndicator(
                  value: value,
                  valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
                  backgroundColor: effectiveBackgroundColor,
                  minHeight: strokeWidth,
                )
              : LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
                  backgroundColor: effectiveBackgroundColor,
                  minHeight: strokeWidth,
                ),
        );
        break;
      case LoadingIndicatorType.threeBounce:
        indicator = _ThreeBouncingDots(
          color: effectiveColor,
          size: size,
        );
        break;
      case LoadingIndicatorType.pulsing:
        indicator = _PulsingDot(
          color: effectiveColor,
          size: size,
        );
        break;
    }

    Widget content;

    if (text != null) {
      content = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          indicator,
          SizedBox(height: textSpacing),
          Text(
            text!,
            style: effectiveTextStyle,
            textAlign: TextAlign.center,
          ),
        ],
      );
    } else {
      content = indicator;
    }

    if (withPadding) {
      return Padding(
        padding: padding,
        child: Center(child: content),
      );
    }

    return Center(child: content);
  }
}

/// Enum representing the type of loading indicator
enum LoadingIndicatorType {
  /// A circular progress indicator
  circular,

  /// A linear progress indicator
  linear,

  /// Three bouncing dots animation
  threeBounce,

  /// A pulsing dot animation
  pulsing,
}

/// A custom loading indicator with three bouncing dots
class _ThreeBouncingDots extends StatefulWidget {
  final Color color;
  final double size;

  const _ThreeBouncingDots({
    required this.color,
    required this.size,
  });

  @override
  _ThreeBouncingDotsState createState() => _ThreeBouncingDotsState();
}

class _ThreeBouncingDotsState extends State<_ThreeBouncingDots> with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(
      3,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        ),
      );
    }).toList();

    for (var i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) {
          _controllers[i].repeat(reverse: true);
        }
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: AnimatedBuilder(
            animation: _animations[index],
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, -10 * _animations[index].value),
                child: Container(
                  width: widget.size / 3,
                  height: widget.size / 3,
                  decoration: BoxDecoration(
                    color: widget.color,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

/// A custom loading indicator with a pulsing dot
class _PulsingDot extends StatefulWidget {
  final Color color;
  final double size;

  const _PulsingDot({
    required this.color,
    required this.size,
  });

  @override
  _PulsingDotState createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.repeat(reverse: true);
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
      builder: (context, child) {
        return Container(
          width: widget.size * _animation.value,
          height: widget.size * _animation.value,
          decoration: BoxDecoration(
            color: widget.color.withValues(alpha: 1 - _animation.value / 2),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
