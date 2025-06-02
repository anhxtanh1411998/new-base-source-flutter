import 'package:flutter/material.dart';

/// A customizable card widget that can be used throughout the application.
///
/// This card supports different styles, content layouts, and interactions.
class CustomCard extends StatelessWidget {
  /// The child widget to display inside the card
  final Widget child;
  
  /// The card's background color
  final Color? backgroundColor;
  
  /// The card's border color
  final Color? borderColor;
  
  /// The card's border width
  final double borderWidth;
  
  /// The card's border radius
  final double borderRadius;
  
  /// The card's elevation
  final double elevation;
  
  /// The card's shadow color
  final Color? shadowColor;
  
  /// The card's padding
  final EdgeInsetsGeometry padding;
  
  /// The card's margin
  final EdgeInsetsGeometry margin;
  
  /// The card's width
  final double? width;
  
  /// The card's height
  final double? height;
  
  /// Whether the card is clickable
  final bool clickable;
  
  /// The callback function when the card is tapped
  final VoidCallback? onTap;
  
  /// The callback function when the card is long-pressed
  final VoidCallback? onLongPress;
  
  /// The splash color when the card is tapped
  final Color? splashColor;
  
  /// The highlight color when the card is tapped
  final Color? highlightColor;
  
  /// The card's shape
  final ShapeBorder? shape;
  
  /// Creates a [CustomCard].
  const CustomCard({
    super.key,
    required this.child,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0.0,
    this.borderRadius = 8.0,
    this.elevation = 1.0,
    this.shadowColor,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.all(0.0),
    this.width,
    this.height,
    this.clickable = false,
    this.onTap,
    this.onLongPress,
    this.splashColor,
    this.highlightColor,
    this.shape,
  });

  /// Creates a [CustomCard] with no elevation.
  factory CustomCard.flat({
    Key? key,
    required Widget child,
    Color? backgroundColor,
    Color? borderColor,
    double borderWidth = 1.0,
    double borderRadius = 8.0,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16.0),
    EdgeInsetsGeometry margin = const EdgeInsets.all(0.0),
    double? width,
    double? height,
    bool clickable = false,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    Color? splashColor,
    Color? highlightColor,
  }) {
    return CustomCard(
      key: key,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
      elevation: 0.0,
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      clickable: clickable,
      onTap: onTap,
      onLongPress: onLongPress,
      splashColor: splashColor,
      highlightColor: highlightColor,
      child: child,
    );
  }

  /// Creates a [CustomCard] with a higher elevation for emphasis.
  factory CustomCard.elevated({
    Key? key,
    required Widget child,
    Color? backgroundColor,
    Color? shadowColor,
    double borderRadius = 8.0,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16.0),
    EdgeInsetsGeometry margin = const EdgeInsets.all(0.0),
    double? width,
    double? height,
    bool clickable = false,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    Color? splashColor,
    Color? highlightColor,
  }) {
    return CustomCard(
      key: key,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      elevation: 4.0,
      shadowColor: shadowColor,
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      clickable: clickable,
      onTap: onTap,
      onLongPress: onLongPress,
      splashColor: splashColor,
      highlightColor: highlightColor,
      child: child,
    );
  }

  /// Creates a [CustomCard] with a title and content.
  factory CustomCard.titled({
    Key? key,
    required String title,
    required Widget content,
    Widget? trailing,
    TextStyle? titleStyle,
    Color? backgroundColor,
    Color? borderColor,
    double borderWidth = 0.0,
    double borderRadius = 8.0,
    double elevation = 1.0,
    Color? shadowColor,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16.0),
    EdgeInsetsGeometry margin = const EdgeInsets.all(0.0),
    double? width,
    double? height,
    bool clickable = false,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    Color? splashColor,
    Color? highlightColor,
    bool divider = true,
    Color? dividerColor,
    double contentSpacing = 16.0,
  }) {
    return CustomCard(
      key: key,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
      elevation: elevation,
      shadowColor: shadowColor,
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      clickable: clickable,
      onTap: onTap,
      onLongPress: onLongPress,
      splashColor: splashColor,
      highlightColor: highlightColor,
      child: Builder(
        builder: (context) {
          final theme = Theme.of(context);
          final effectiveTitleStyle = titleStyle ?? theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          );
          final effectiveDividerColor = dividerColor ?? theme.dividerColor;
          
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: effectiveTitleStyle,
                    ),
                  ),
                  if (trailing != null) trailing,
                ],
              ),
              if (divider) ...[
                const SizedBox(height: 12.0),
                Divider(
                  color: effectiveDividerColor,
                  height: 1.0,
                ),
              ],
              SizedBox(height: contentSpacing),
              content,
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final effectiveBackgroundColor = backgroundColor ?? theme.cardColor;
    final effectiveShadowColor = shadowColor ?? theme.shadowColor;
    
    ShapeBorder effectiveShape;
    if (shape != null) {
      effectiveShape = shape!;
    } else if (borderColor != null && borderWidth > 0) {
      effectiveShape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: BorderSide(
          color: borderColor!,
          width: borderWidth,
        ),
      );
    } else {
      effectiveShape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      );
    }
    
    Widget cardContent = Padding(
      padding: padding,
      child: child,
    );
    
    if (width != null || height != null) {
      cardContent = SizedBox(
        width: width,
        height: height,
        child: cardContent,
      );
    }
    
    Widget card = Card(
      color: effectiveBackgroundColor,
      elevation: elevation,
      shadowColor: effectiveShadowColor,
      margin: margin,
      shape: effectiveShape,
      child: cardContent,
    );
    
    if (clickable || onTap != null || onLongPress != null) {
      return InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(borderRadius),
        splashColor: splashColor,
        highlightColor: highlightColor,
        child: card,
      );
    }
    
    return card;
  }
}