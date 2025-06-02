import 'package:flutter/material.dart';

/// A customizable empty state widget that can be used throughout the application.
///
/// This widget displays a message and an optional image when there's no data to show.
class EmptyState extends StatelessWidget {
  /// The message to display
  final String message;
  
  /// The title of the empty state
  final String? title;
  
  /// The icon to display
  final IconData? icon;
  
  /// The image asset path to display
  final String? imagePath;
  
  /// The widget to display instead of an icon or image
  final Widget? customImage;
  
  /// The size of the icon or image
  final double imageSize;
  
  /// The color of the icon
  final Color? iconColor;
  
  /// The text style for the message
  final TextStyle? messageStyle;
  
  /// The text style for the title
  final TextStyle? titleStyle;
  
  /// The action button text
  final String? actionButtonText;
  
  /// The callback function when the action button is pressed
  final VoidCallback? onActionButtonPressed;
  
  /// The background color of the action button
  final Color? actionButtonColor;
  
  /// The text color of the action button
  final Color? actionButtonTextColor;
  
  /// The spacing between the image and the text
  final double imageTextSpacing;
  
  /// The spacing between the message and the action button
  final double messageActionSpacing;
  
  /// The padding around the empty state
  final EdgeInsetsGeometry padding;
  
  /// The alignment of the empty state
  final CrossAxisAlignment alignment;
  
  /// The background color of the empty state
  final Color? backgroundColor;
  
  /// Creates an [EmptyState].
  const EmptyState({
    super.key,
    required this.message,
    this.title,
    this.icon,
    this.imagePath,
    this.customImage,
    this.imageSize = 120.0,
    this.iconColor,
    this.messageStyle,
    this.titleStyle,
    this.actionButtonText,
    this.onActionButtonPressed,
    this.actionButtonColor,
    this.actionButtonTextColor,
    this.imageTextSpacing = 24.0,
    this.messageActionSpacing = 24.0,
    this.padding = const EdgeInsets.all(24.0),
    this.alignment = CrossAxisAlignment.center,
    this.backgroundColor,
  }) : assert(
          (icon != null && imagePath == null && customImage == null) ||
          (icon == null && imagePath != null && customImage == null) ||
          (icon == null && imagePath == null && customImage != null) ||
          (icon == null && imagePath == null && customImage == null),
          'Only one of icon, imagePath, or customImage can be provided',
        );

  /// Creates an [EmptyState] for an empty list.
  factory EmptyState.list({
    Key? key,
    String message = 'No items found',
    String? title,
    IconData icon = Icons.list_alt,
    Color? iconColor,
    TextStyle? messageStyle,
    TextStyle? titleStyle,
    String? actionButtonText,
    VoidCallback? onActionButtonPressed,
    Color? actionButtonColor,
    Color? actionButtonTextColor,
    EdgeInsetsGeometry padding = const EdgeInsets.all(24.0),
    CrossAxisAlignment alignment = CrossAxisAlignment.center,
    Color? backgroundColor,
  }) {
    return EmptyState(
      key: key,
      message: message,
      title: title,
      icon: icon,
      iconColor: iconColor,
      messageStyle: messageStyle,
      titleStyle: titleStyle,
      actionButtonText: actionButtonText,
      onActionButtonPressed: onActionButtonPressed,
      actionButtonColor: actionButtonColor,
      actionButtonTextColor: actionButtonTextColor,
      padding: padding,
      alignment: alignment,
      backgroundColor: backgroundColor,
    );
  }

  /// Creates an [EmptyState] for search results.
  factory EmptyState.search({
    Key? key,
    String message = 'No results found',
    String? title = 'No matches',
    IconData icon = Icons.search_off,
    Color? iconColor,
    TextStyle? messageStyle,
    TextStyle? titleStyle,
    String? actionButtonText = 'Clear Search',
    VoidCallback? onActionButtonPressed,
    Color? actionButtonColor,
    Color? actionButtonTextColor,
    EdgeInsetsGeometry padding = const EdgeInsets.all(24.0),
    CrossAxisAlignment alignment = CrossAxisAlignment.center,
    Color? backgroundColor,
  }) {
    return EmptyState(
      key: key,
      message: message,
      title: title,
      icon: icon,
      iconColor: iconColor,
      messageStyle: messageStyle,
      titleStyle: titleStyle,
      actionButtonText: actionButtonText,
      onActionButtonPressed: onActionButtonPressed,
      actionButtonColor: actionButtonColor,
      actionButtonTextColor: actionButtonTextColor,
      padding: padding,
      alignment: alignment,
      backgroundColor: backgroundColor,
    );
  }

  /// Creates an [EmptyState] for network errors.
  factory EmptyState.network({
    Key? key,
    String message = 'Could not connect to the server',
    String? title = 'Connection Error',
    IconData icon = Icons.wifi_off,
    Color? iconColor,
    TextStyle? messageStyle,
    TextStyle? titleStyle,
    String? actionButtonText = 'Retry',
    VoidCallback? onActionButtonPressed,
    Color? actionButtonColor,
    Color? actionButtonTextColor,
    EdgeInsetsGeometry padding = const EdgeInsets.all(24.0),
    CrossAxisAlignment alignment = CrossAxisAlignment.center,
    Color? backgroundColor,
  }) {
    return EmptyState(
      key: key,
      message: message,
      title: title,
      icon: icon,
      iconColor: iconColor,
      messageStyle: messageStyle,
      titleStyle: titleStyle,
      actionButtonText: actionButtonText,
      onActionButtonPressed: onActionButtonPressed,
      actionButtonColor: actionButtonColor,
      actionButtonTextColor: actionButtonTextColor,
      padding: padding,
      alignment: alignment,
      backgroundColor: backgroundColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final effectiveIconColor = iconColor ?? theme.colorScheme.primary;
    final effectiveMessageStyle = messageStyle ?? theme.textTheme.bodyLarge?.copyWith(
      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
    );
    final effectiveTitleStyle = titleStyle ?? theme.textTheme.titleLarge?.copyWith(
      color: theme.colorScheme.onSurface,
      fontWeight: FontWeight.bold,
    );
    final effectiveActionButtonColor = actionButtonColor ?? theme.colorScheme.primary;
    final effectiveActionButtonTextColor = actionButtonTextColor ?? theme.colorScheme.onPrimary;
    final effectiveBackgroundColor = backgroundColor;
    
    Widget? imageWidget;
    if (icon != null) {
      imageWidget = Icon(
        icon,
        size: imageSize,
        color: effectiveIconColor,
      );
    } else if (imagePath != null) {
      imageWidget = Image.asset(
        imagePath!,
        width: imageSize,
        height: imageSize,
      );
    } else if (customImage != null) {
      imageWidget = SizedBox(
        width: imageSize,
        height: imageSize,
        child: customImage,
      );
    }
    
    Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: alignment,
      children: [
        if (imageWidget != null) ...[
          imageWidget,
          SizedBox(height: imageTextSpacing),
        ],
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
    
    if (effectiveBackgroundColor != null) {
      content = Container(
        color: effectiveBackgroundColor,
        padding: padding,
        child: Center(child: content),
      );
    } else {
      content = Padding(
        padding: padding,
        child: Center(child: content),
      );
    }
    
    return content;
  }
}