import 'package:flutter/material.dart';

/// A customizable dropdown widget that can be used throughout the application.
///
/// This dropdown supports different styles, validation, and customization options.
class CustomDropdown<T> extends StatelessWidget {
  /// The currently selected value
  final T? value;
  
  /// The list of items to display in the dropdown
  final List<DropdownMenuItem<T>> items;
  
  /// The callback function when the value changes
  final ValueChanged<T?>? onChanged;
  
  /// The hint text to display when no value is selected
  final String? hint;
  
  /// The label text to display above the dropdown
  final String? label;
  
  /// The helper text to display below the dropdown
  final String? helperText;
  
  /// The error text to display when validation fails
  final String? errorText;
  
  /// The prefix icon to display at the start of the dropdown
  final IconData? prefixIcon;
  
  /// The suffix icon to display at the end of the dropdown
  final IconData? suffixIcon;
  
  /// Whether the dropdown is enabled
  final bool enabled;
  
  /// Whether the dropdown is required
  final bool required;
  
  /// The dropdown's border radius
  final double borderRadius;
  
  /// The dropdown's fill color
  final Color? fillColor;
  
  /// Whether the dropdown is filled
  final bool filled;
  
  /// The dropdown's border color
  final Color? borderColor;
  
  /// The dropdown's focus border color
  final Color? focusBorderColor;
  
  /// The dropdown's error border color
  final Color? errorBorderColor;
  
  /// The dropdown's text style
  final TextStyle? textStyle;
  
  /// The dropdown's hint style
  final TextStyle? hintStyle;
  
  /// The dropdown's label style
  final TextStyle? labelStyle;
  
  /// The dropdown's error style
  final TextStyle? errorStyle;
  
  /// The dropdown's content padding
  final EdgeInsetsGeometry contentPadding;
  
  /// The dropdown's icon (the arrow icon)
  final Widget? icon;
  
  /// The dropdown's icon size
  final double iconSize;
  
  /// The dropdown's icon color
  final Color? iconColor;
  
  /// The dropdown's dropdown color
  final Color? dropdownColor;
  
  /// The dropdown's elevation
  final int elevation;
  
  /// The dropdown's auto-validation mode
  final AutovalidateMode autovalidateMode;
  
  /// The validation function for the dropdown
  final String? Function(T?)? validator;
  
  /// Whether to show the dropdown as a button
  final bool isButton;
  
  /// The dropdown's button color
  final Color? buttonColor;
  
  /// The dropdown's button text color
  final Color? buttonTextColor;
  
  /// The dropdown's button elevation
  final double buttonElevation;
  
  /// The dropdown's button border color
  final Color? buttonBorderColor;
  
  /// The dropdown's button border width
  final double buttonBorderWidth;
  
  /// Creates a [CustomDropdown].
  const CustomDropdown({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.hint,
    this.label,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.required = false,
    this.borderRadius = 8.0,
    this.fillColor,
    this.filled = true,
    this.borderColor,
    this.focusBorderColor,
    this.errorBorderColor,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.errorStyle,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
    this.icon,
    this.iconSize = 24.0,
    this.iconColor,
    this.dropdownColor,
    this.elevation = 8,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.validator,
    this.isButton = false,
    this.buttonColor,
    this.buttonTextColor,
    this.buttonElevation = 0.0,
    this.buttonBorderColor,
    this.buttonBorderWidth = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final effectiveFillColor = fillColor ?? theme.colorScheme.surface;
    final effectiveBorderColor = borderColor ?? theme.colorScheme.outline;
    final effectiveFocusBorderColor = focusBorderColor ?? theme.colorScheme.primary;
    final effectiveErrorBorderColor = errorBorderColor ?? theme.colorScheme.error;
    
    final effectiveTextStyle = textStyle ?? theme.textTheme.bodyLarge;
    final effectiveHintStyle = hintStyle ?? theme.textTheme.bodyLarge?.copyWith(
      color: theme.hintColor,
    );
    final effectiveLabelStyle = labelStyle ?? theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurface,
    );
    final effectiveErrorStyle = errorStyle ?? theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.error,
    );
    
    final effectiveIconColor = iconColor ?? theme.colorScheme.onSurface.withValues(alpha: 0.6);
    final effectiveDropdownColor = dropdownColor ?? theme.colorScheme.surface;
    
    final effectiveButtonColor = buttonColor ?? theme.colorScheme.primary;
    final effectiveButtonTextColor = buttonTextColor ?? theme.colorScheme.onPrimary;
    final effectiveButtonBorderColor = buttonBorderColor ?? theme.colorScheme.primary;
    
    final effectiveInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
        color: effectiveBorderColor,
        width: 1.0,
      ),
    );
    
    final effectiveFocusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
        color: effectiveFocusBorderColor,
        width: 2.0,
      ),
    );
    
    final effectiveErrorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
        color: effectiveErrorBorderColor,
        width: 1.0,
      ),
    );
    
    final effectiveFocusedErrorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
        color: effectiveErrorBorderColor,
        width: 2.0,
      ),
    );
    
    Widget? prefixIconWidget;
    if (prefixIcon != null) {
      prefixIconWidget = Icon(
        prefixIcon,
        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
      );
    }
    
    String? effectiveLabel = label;
    if (required && label != null) {
      effectiveLabel = '$label *';
    }
    
    if (isButton) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (effectiveLabel != null) ...[
            Text(
              effectiveLabel,
              style: effectiveLabelStyle,
            ),
            const SizedBox(height: 8.0),
          ],
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: errorText != null
                    ? effectiveErrorBorderColor
                    : effectiveButtonBorderColor,
                width: buttonBorderWidth,
              ),
              color: enabled ? effectiveButtonColor : effectiveButtonColor.withValues(alpha: 0.6),
            ),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<T>(
                  value: value,
                  items: items,
                  onChanged: enabled ? onChanged : null,
                  hint: hint != null
                      ? Text(
                          hint!,
                          style: effectiveHintStyle?.copyWith(
                            color: effectiveButtonTextColor.withValues(alpha: 0.7),
                          ),
                        )
                      : null,
                  style: effectiveTextStyle?.copyWith(
                    color: effectiveButtonTextColor,
                  ),
                  icon: icon ??
                      Icon(
                        suffixIcon ?? Icons.arrow_drop_down,
                        color: effectiveButtonTextColor,
                        size: iconSize,
                      ),
                  iconSize: iconSize,
                  dropdownColor: effectiveDropdownColor,
                  elevation: elevation,
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(borderRadius),
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          if (errorText != null) ...[
            const SizedBox(height: 4.0),
            Text(
              errorText!,
              style: effectiveErrorStyle,
            ),
          ] else if (helperText != null) ...[
            const SizedBox(height: 4.0),
            Text(
              helperText!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ],
      );
    }
    
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: enabled ? onChanged : null,
      decoration: InputDecoration(
        hintText: hint,
        labelText: effectiveLabel,
        helperText: helperText,
        errorText: errorText,
        prefixIcon: prefixIconWidget,
        filled: filled,
        fillColor: effectiveFillColor,
        contentPadding: contentPadding,
        border: effectiveInputBorder,
        enabledBorder: effectiveInputBorder,
        focusedBorder: effectiveFocusedBorder,
        errorBorder: effectiveErrorBorder,
        focusedErrorBorder: effectiveFocusedErrorBorder,
        hintStyle: effectiveHintStyle,
        labelStyle: effectiveLabelStyle,
        errorStyle: effectiveErrorStyle,
        enabled: enabled,
      ),
      style: effectiveTextStyle,
      icon: icon ??
          Icon(
            suffixIcon ?? Icons.arrow_drop_down,
            color: effectiveIconColor,
            size: iconSize,
          ),
      iconSize: iconSize,
      dropdownColor: effectiveDropdownColor,
      elevation: elevation,
      validator: validator,
      autovalidateMode: autovalidateMode,
      isExpanded: true,
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }
}