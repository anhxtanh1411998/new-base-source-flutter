import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A customizable text field widget that can be used throughout the application.
///
/// This text field supports different styles, validation, and input types.
class CustomTextField extends StatelessWidget {
  /// The controller for the text field
  final TextEditingController? controller;
  
  /// The hint text to display when the text field is empty
  final String? hintText;
  
  /// The label text to display above the text field
  final String? labelText;
  
  /// The helper text to display below the text field
  final String? helperText;
  
  /// The error text to display when validation fails
  final String? errorText;
  
  /// The prefix icon to display at the start of the text field
  final IconData? prefixIcon;
  
  /// The suffix icon to display at the end of the text field
  final IconData? suffixIcon;
  
  /// The callback function when the suffix icon is pressed
  final VoidCallback? onSuffixIconPressed;
  
  /// The callback function when the text field value changes
  final ValueChanged<String>? onChanged;
  
  /// The callback function when the text field is submitted
  final ValueChanged<String>? onSubmitted;
  
  /// The validation function for the text field
  final String? Function(String?)? validator;
  
  /// The keyboard type for the text field
  final TextInputType keyboardType;
  
  /// Whether the text field is obscured (for passwords)
  final bool obscureText;
  
  /// Whether the text field is enabled
  final bool enabled;
  
  /// Whether the text field is read-only
  final bool readOnly;
  
  /// Whether the text field is required
  final bool required;
  
  /// The maximum number of characters allowed in the text field
  final int? maxLength;
  
  /// The maximum number of lines allowed in the text field
  final int? maxLines;
  
  /// The minimum number of lines allowed in the text field
  final int? minLines;
  
  /// The text field's border radius
  final double borderRadius;
  
  /// The text field's fill color
  final Color? fillColor;
  
  /// Whether the text field is filled
  final bool filled;
  
  /// The text field's border color
  final Color? borderColor;
  
  /// The text field's focus border color
  final Color? focusBorderColor;
  
  /// The text field's error border color
  final Color? errorBorderColor;
  
  /// The text field's text style
  final TextStyle? textStyle;
  
  /// The text field's hint style
  final TextStyle? hintStyle;
  
  /// The text field's label style
  final TextStyle? labelStyle;
  
  /// The text field's error style
  final TextStyle? errorStyle;
  
  /// The text field's content padding
  final EdgeInsetsGeometry contentPadding;
  
  /// The text field's input formatters
  final List<TextInputFormatter>? inputFormatters;
  
  /// The text field's auto-validation mode
  final AutovalidateMode autovalidateMode;
  
  /// The text field's text capitalization
  final TextCapitalization textCapitalization;
  
  /// The text field's text align
  final TextAlign textAlign;
  
  /// The text field's text direction
  final TextDirection? textDirection;
  
  /// Creates a [CustomTextField].
  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.required = false,
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
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
    this.inputFormatters,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.textDirection,
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
    
    Widget? suffixIconWidget;
    if (suffixIcon != null) {
      suffixIconWidget = IconButton(
        icon: Icon(
          suffixIcon,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        onPressed: onSuffixIconPressed,
      );
    }
    
    String? effectiveLabelText = labelText;
    if (required && labelText != null) {
      effectiveLabelText = '$labelText *';
    }
    
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: effectiveLabelText,
        helperText: helperText,
        errorText: errorText,
        prefixIcon: prefixIconWidget,
        suffixIcon: suffixIconWidget,
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
      ),
      style: effectiveTextStyle,
      keyboardType: keyboardType,
      obscureText: obscureText,
      enabled: enabled,
      readOnly: readOnly,
      maxLength: maxLength,
      maxLines: maxLines,
      minLines: minLines,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      validator: validator,
      inputFormatters: inputFormatters,
      autovalidateMode: autovalidateMode,
      textCapitalization: textCapitalization,
      textAlign: textAlign,
      textDirection: textDirection,
    );
  }
}