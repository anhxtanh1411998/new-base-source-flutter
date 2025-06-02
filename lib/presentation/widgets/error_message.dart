import 'package:flutter/material.dart';

/// A customizable error message widget that can be used throughout the application.
///
/// This widget displays an error message with an optional icon, action button,
/// and retry functionality.
class ErrorMessage extends StatelessWidget {
  /// The error message to display
  final String message;
  
  /// The title of the error message
  final String? title;
  
  /// The icon to display with the error message
  final IconData icon;
  
  /// The color of the icon
  final Color? iconColor;
  
  /// The size of the icon
  final double iconSize;
  
  /// The text style for the error message
  final TextStyle? messageStyle;
  
  /// The text style for the error title
  final TextStyle? titleStyle;
  
  /// The action button text
  final String? actionButtonText;
  
  /// The callback function when the action button is pressed
  final VoidCallback? onActionButtonPressed;
  
  /// The background color of the action button
  final Color? actionButtonColor;
  
  /// The text color of the action button
  final Color? actionButtonTextColor;
  
  /// The spacing between the icon and the text
  final double iconTextSpacing;
  
  /// The spacing between the message and the action button
  final double messageActionSpacing;
  
  /// The padding around the error message
  final EdgeInsetsGeometry padding;
  
  /// The alignment of the error message
  final CrossAxisAlignment alignment;
  
  /// Whether to show a border around the error message
  final bool showBorder;
  
  /// The border color of the error message
  final Color? borderColor;
  
  /// The border radius of the error message
  final double borderRadius;
  
  /// The background color of the error message
  final Color? backgroundColor;
  
  /// Creates an [ErrorMessage].
  const ErrorMessage({
    super.key,
    required this.message,
    this.title,
    this.icon = Icons.error_outline,
    this.iconColor,
    this.iconSize = 48.0,
    this.messageStyle,
    this.titleStyle,
    this.actionButtonText,
    this.onActionButtonPressed,
    this.actionButtonColor,
    this.actionButtonTextColor,
    this.iconTextSpacing = 16.0,
    this.messageActionSpacing = 24.0,
    this.padding = const EdgeInsets.all(16.0),
    this.alignment = CrossAxisAlignment.center,
    this.showBorder = false,
    this.borderColor,
    this.borderRadius = 8.0,
    this.backgroundColor,
  });

  /// Creates an [ErrorMessage] for network errors.
  factory ErrorMessage.network({
    Key? key,
    String message = 'No internet connection',
    String? title = 'Connection Error',
    String actionButtonText = 'Retry',
    VoidCallback? onActionButtonPressed,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16.0),
    CrossAxisAlignment alignment = CrossAxisAlignment.center,
    bool showBorder = false,
    Color? borderColor,
    double borderRadius = 8.0,
    Color? backgroundColor,
  }) {
    return ErrorMessage(
      key: key,
      message: message,
      title: title,
      icon: Icons.wifi_off,
      actionButtonText: actionButtonText,
      onActionButtonPressed: onActionButtonPressed,
      padding: padding,
      alignment: alignment,
      showBorder: showBorder,
      borderColor: borderColor,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
    );
  }

  /// Creates an [ErrorMessage] for server errors.
  factory ErrorMessage.server({
    Key? key,
    String message = 'Something went wrong on our end',
    String? title = 'Server Error',
    String actionButtonText = 'Retry',
    VoidCallback? onActionButtonPressed,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16.0),
    CrossAxisAlignment alignment = CrossAxisAlignment.center,
    bool showBorder = false,
    Color? borderColor,
    double borderRadius = 8.0,
    Color? backgroundColor,
  }) {
    return ErrorMessage(
      key: key,
      message: message,
      title: title,
      icon: Icons.cloud_off,
      actionButtonText: actionButtonText,
      onActionButtonPressed: onActionButtonPressed,
      padding: padding,
      alignment: alignment,
      showBorder: showBorder,
      borderColor: borderColor,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
    );
  }

  /// Creates an [ErrorMessage] for not found errors.
  factory ErrorMessage.notFound({
    Key? key,
    String message = 'The requested resource was not found',
    String? title = 'Not Found',
    String? actionButtonText = 'Go Back',
    VoidCallback? onActionButtonPressed,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16.0),
    CrossAxisAlignment alignment = CrossAxisAlignment.center,
    bool showBorder = false,
    Color? borderColor,
    double borderRadius = 8.0,
    Color? backgroundColor,
  }) {
    return ErrorMessage(
      key: key,
      message: message,
      title: title,
      icon: Icons.search_off,
      actionButtonText: actionButtonText,
      onActionButtonPressed: onActionButtonPressed,
      padding: padding,
      alignment: alignment,
      showBorder: showBorder,
      borderColor: borderColor,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final effectiveIconColor = iconColor ?? theme.colorScheme.error;
    final effectiveMessageStyle = messageStyle ?? theme.textTheme.bodyLarge?.copyWith(
      color: theme.colorScheme.onSurface,
    );
    final effectiveTitleStyle = titleStyle ?? theme.textTheme.titleLarge?.copyWith(
      color: theme.colorScheme.onSurface,
      fontWeight: FontWeight.bold,
    );
    final effectiveActionButtonColor = actionButtonColor ?? theme.colorScheme.primary;
    final effectiveActionButtonTextColor = actionButtonTextColor ?? theme.colorScheme.onPrimary;
    final effectiveBorderColor = borderColor ?? theme.colorScheme.outline;
    final effectiveBackgroundColor = backgroundColor ?? theme.colorScheme.errorContainer.withValues(alpha: 0.1);
    
    Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: alignment,
      children: [
        Icon(
          icon,
          color: effectiveIconColor,
          size: iconSize,
        ),
        SizedBox(height: iconTextSpacing),
        if (title != null) ...[
          Text(
            title!,
            style: effectiveTitleStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8.0),
        ],
        Text(
          message,
          style: effectiveMessageStyle,
          textAlign: TextAlign.center,
        ),
        if (actionButtonText != null && onActionButtonPressed != null) ...[
          SizedBox(height: messageActionSpacing),
          ElevatedButton(
            onPressed: onActionButtonPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: effectiveActionButtonColor,
              foregroundColor: effectiveActionButtonTextColor,
            ),
            child: Text(actionButtonText!),
          ),
        ],
      ],
    );
    
    if (showBorder) {
      content = Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: effectiveBorderColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          color: effectiveBackgroundColor,
        ),
        padding: padding,
        child: content,
      );
    } else {
      content = Padding(
        padding: padding,
        child: content,
      );
    }
    
    return Center(child: content);
  }
}