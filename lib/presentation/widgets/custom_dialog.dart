import 'package:flutter/material.dart';

/// A utility class for showing customizable dialogs throughout the application.
class CustomDialog {
  /// Shows a custom dialog with the given content.
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget content,
    String? title,
    List<Widget>? actions,
    bool barrierDismissible = true,
    Color? barrierColor,
    Color? backgroundColor,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.all(24.0),
    EdgeInsetsGeometry titlePadding = const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
    EdgeInsetsGeometry actionsPadding = const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
    double borderRadius = 8.0,
    double maxWidth = 400.0,
    double elevation = 24.0,
    TextStyle? titleStyle,
    bool scrollable = false,
  }) {
    final theme = Theme.of(context);
    
    final effectiveTitleStyle = titleStyle ?? theme.textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.bold,
    );
    
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      builder: (context) {
        return Dialog(
          backgroundColor: backgroundColor,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxWidth,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (title != null)
                  Padding(
                    padding: titlePadding,
                    child: Text(
                      title,
                      style: effectiveTitleStyle,
                    ),
                  ),
                if (scrollable)
                  Flexible(
                    child: SingleChildScrollView(
                      padding: contentPadding,
                      child: content,
                    ),
                  )
                else
                  Padding(
                    padding: contentPadding,
                    child: content,
                  ),
                if (actions != null && actions.isNotEmpty)
                  Padding(
                    padding: actionsPadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: actions,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Shows a confirmation dialog with the given message.
  static Future<bool> confirm({
    required BuildContext context,
    required String message,
    String? title,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    Color? confirmColor,
    Color? cancelColor,
    bool isDestructive = false,
    bool barrierDismissible = true,
    Color? barrierColor,
    Color? backgroundColor,
    double borderRadius = 8.0,
    TextStyle? messageStyle,
    TextStyle? titleStyle,
    TextStyle? confirmTextStyle,
    TextStyle? cancelTextStyle,
  }) async {
    final theme = Theme.of(context);
    
    final effectiveMessageStyle = messageStyle ?? theme.textTheme.bodyLarge;
    final effectiveConfirmColor = confirmColor ?? (isDestructive ? theme.colorScheme.error : theme.colorScheme.primary);
    final effectiveCancelColor = cancelColor ?? theme.colorScheme.onSurface.withValues(alpha: 0.6);
    
    final effectiveConfirmTextStyle = confirmTextStyle ?? TextStyle(
      color: effectiveConfirmColor,
      fontWeight: FontWeight.bold,
    );
    
    final effectiveCancelTextStyle = cancelTextStyle ?? TextStyle(
      color: effectiveCancelColor,
    );
    
    final result = await show<bool>(
      context: context,
      title: title,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      titleStyle: titleStyle,
      content: Text(
        message,
        style: effectiveMessageStyle,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            cancelText,
            style: effectiveCancelTextStyle,
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            confirmText,
            style: effectiveConfirmTextStyle,
          ),
        ),
      ],
    );
    
    return result ?? false;
  }

  /// Shows an information dialog with the given message.
  static Future<void> info({
    required BuildContext context,
    required String message,
    String? title,
    String buttonText = 'OK',
    Color? buttonColor,
    bool barrierDismissible = true,
    Color? barrierColor,
    Color? backgroundColor,
    double borderRadius = 8.0,
    TextStyle? messageStyle,
    TextStyle? titleStyle,
    TextStyle? buttonTextStyle,
  }) async {
    final theme = Theme.of(context);
    
    final effectiveMessageStyle = messageStyle ?? theme.textTheme.bodyLarge;
    final effectiveButtonColor = buttonColor ?? theme.colorScheme.primary;
    
    final effectiveButtonTextStyle = buttonTextStyle ?? TextStyle(
      color: effectiveButtonColor,
      fontWeight: FontWeight.bold,
    );
    
    await show(
      context: context,
      title: title,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      titleStyle: titleStyle,
      content: Text(
        message,
        style: effectiveMessageStyle,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            buttonText,
            style: effectiveButtonTextStyle,
          ),
        ),
      ],
    );
  }

  /// Shows an error dialog with the given message.
  static Future<void> error({
    required BuildContext context,
    required String message,
    String title = 'Error',
    String buttonText = 'OK',
    Color? buttonColor,
    bool barrierDismissible = true,
    Color? barrierColor,
    Color? backgroundColor,
    double borderRadius = 8.0,
    TextStyle? messageStyle,
    TextStyle? titleStyle,
    TextStyle? buttonTextStyle,
    IconData icon = Icons.error_outline,
    Color? iconColor,
    double iconSize = 48.0,
  }) async {
    final theme = Theme.of(context);
    
    final effectiveMessageStyle = messageStyle ?? theme.textTheme.bodyLarge;
    final effectiveButtonColor = buttonColor ?? theme.colorScheme.primary;
    final effectiveIconColor = iconColor ?? theme.colorScheme.error;
    
    final effectiveButtonTextStyle = buttonTextStyle ?? TextStyle(
      color: effectiveButtonColor,
      fontWeight: FontWeight.bold,
    );
    
    await show(
      context: context,
      title: title,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      titleStyle: titleStyle,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: effectiveIconColor,
            size: iconSize,
          ),
          const SizedBox(height: 16.0),
          Text(
            message,
            style: effectiveMessageStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            buttonText,
            style: effectiveButtonTextStyle,
          ),
        ),
      ],
    );
  }

  /// Shows a loading dialog with the given message.
  static Future<void> loading({
    required BuildContext context,
    String message = 'Loading...',
    bool barrierDismissible = false,
    Color? barrierColor,
    Color? backgroundColor,
    double borderRadius = 8.0,
    TextStyle? messageStyle,
    Color? progressIndicatorColor,
    double progressIndicatorSize = 48.0,
  }) async {
    final theme = Theme.of(context);
    
    final effectiveMessageStyle = messageStyle ?? theme.textTheme.bodyLarge;
    final effectiveProgressIndicatorColor = progressIndicatorColor ?? theme.colorScheme.primary;
    
    await show(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: progressIndicatorSize,
            height: progressIndicatorSize,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(effectiveProgressIndicatorColor),
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            message,
            style: effectiveMessageStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Dismisses the currently showing dialog.
  static void dismiss(BuildContext context) {
    Navigator.of(context).pop();
  }
}