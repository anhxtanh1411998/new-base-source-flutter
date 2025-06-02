import 'package:flutter/material.dart';

/// A customizable button widget that can be used throughout the application.
///
/// This button supports different styles, sizes, and states.
class CustomButton extends StatelessWidget {
  /// The text to display on the button
  final String text;
  
  /// The callback function when the button is pressed
  final VoidCallback? onPressed;
  
  /// The button's background color
  final Color? backgroundColor;
  
  /// The button's text color
  final Color? textColor;
  
  /// The button's border color
  final Color? borderColor;
  
  /// The button's border radius
  final double borderRadius;
  
  /// The button's border width
  final double borderWidth;
  
  /// The button's elevation
  final double elevation;
  
  /// The button's padding
  final EdgeInsetsGeometry padding;
  
  /// The button's minimum width
  final double? minWidth;
  
  /// The button's minimum height
  final double? minHeight;
  
  /// The button's icon (optional)
  final IconData? icon;
  
  /// The button's icon position (left or right)
  final IconPosition iconPosition;
  
  /// The button's icon size
  final double iconSize;
  
  /// The button's icon color
  final Color? iconColor;
  
  /// The button's loading state
  final bool isLoading;
  
  /// The button's disabled state
  final bool isDisabled;
  
  /// The button's text style
  final TextStyle? textStyle;

  /// Creates a [CustomButton].
  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderRadius = 8.0,
    this.borderWidth = 1.0,
    this.elevation = 0.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    this.minWidth,
    this.minHeight,
    this.icon,
    this.iconPosition = IconPosition.left,
    this.iconSize = 20.0,
    this.iconColor,
    this.isLoading = false,
    this.isDisabled = false,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final effectiveBackgroundColor = backgroundColor ?? theme.primaryColor;
    final effectiveTextColor = textColor ?? Colors.white;
    final effectiveBorderColor = borderColor ?? Colors.transparent;
    final effectiveIconColor = iconColor ?? effectiveTextColor;
    
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: effectiveBackgroundColor,
      foregroundColor: effectiveTextColor,
      elevation: elevation,
      padding: padding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: BorderSide(
          color: effectiveBorderColor,
          width: borderWidth,
        ),
      ),
      minimumSize: (minWidth != null || minHeight != null)
          ? Size(minWidth ?? 0, minHeight ?? 0)
          : null,
    );
    
    final effectiveTextStyle = textStyle ??
        theme.textTheme.labelLarge?.copyWith(
          color: effectiveTextColor,
          fontWeight: FontWeight.bold,
        );
    
    Widget buttonContent;
    
    if (isLoading) {
      buttonContent = SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(effectiveTextColor),
        ),
      );
    } else if (icon != null) {
      final iconWidget = Icon(
        icon,
        size: iconSize,
        color: effectiveIconColor,
      );
      
      if (iconPosition == IconPosition.left) {
        buttonContent = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            iconWidget,
            const SizedBox(width: 8.0),
            Text(text, style: effectiveTextStyle),
          ],
        );
      } else {
        buttonContent = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text, style: effectiveTextStyle),
            const SizedBox(width: 8.0),
            iconWidget,
          ],
        );
      }
    } else {
      buttonContent = Text(text, style: effectiveTextStyle);
    }
    
    return ElevatedButton(
      onPressed: (isDisabled || isLoading) ? null : onPressed,
      style: buttonStyle,
      child: buttonContent,
    );
  }
}

/// Enum representing the position of the icon in the button
enum IconPosition {
  /// Icon positioned to the left of the text
  left,
  
  /// Icon positioned to the right of the text
  right,
}