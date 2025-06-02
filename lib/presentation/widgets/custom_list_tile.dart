import 'package:flutter/material.dart';

/// A customizable list tile widget that can be used throughout the application.
///
/// This list tile supports different styles, layouts, and interactions.
class CustomListTile extends StatelessWidget {
  /// The title of the list tile
  final Widget title;
  
  /// The subtitle of the list tile
  final Widget? subtitle;
  
  /// The leading widget of the list tile
  final Widget? leading;
  
  /// The trailing widget of the list tile
  final Widget? trailing;
  
  /// The callback function when the list tile is tapped
  final VoidCallback? onTap;
  
  /// The callback function when the list tile is long-pressed
  final VoidCallback? onLongPress;
  
  /// The background color of the list tile
  final Color? backgroundColor;
  
  /// The selected color of the list tile
  final Color? selectedColor;
  
  /// Whether the list tile is selected
  final bool isSelected;
  
  /// Whether the list tile is enabled
  final bool enabled;
  
  /// The list tile's content padding
  final EdgeInsetsGeometry contentPadding;
  
  /// The list tile's horizontal title gap
  final double? horizontalTitleGap;
  
  /// The list tile's minimum leading width
  final double? minLeadingWidth;
  
  /// The list tile's minimum vertical padding
  final double minVerticalPadding;
  
  /// The list tile's shape
  final ShapeBorder? shape;
  
  /// The list tile's border radius
  final double borderRadius;
  
  /// The list tile's border color
  final Color? borderColor;
  
  /// The list tile's border width
  final double borderWidth;
  
  /// The list tile's elevation
  final double elevation;
  
  /// The list tile's shadow color
  final Color? shadowColor;
  
  /// The list tile's margin
  final EdgeInsetsGeometry margin;
  
  /// The list tile's title style
  final TextStyle? titleStyle;
  
  /// The list tile's subtitle style
  final TextStyle? subtitleStyle;
  
  /// The list tile's dense spacing
  final bool dense;
  
  /// The list tile's visualization density
  final VisualDensity? visualDensity;
  
  /// The splash color when the list tile is tapped
  final Color? splashColor;
  
  /// The highlight color when the list tile is tapped
  final Color? highlightColor;
  
  /// Creates a [CustomListTile].
  const CustomListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.backgroundColor,
    this.selectedColor,
    this.isSelected = false,
    this.enabled = true,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.horizontalTitleGap,
    this.minLeadingWidth,
    this.minVerticalPadding = 4.0,
    this.shape,
    this.borderRadius = 8.0,
    this.borderColor,
    this.borderWidth = 0.0,
    this.elevation = 0.0,
    this.shadowColor,
    this.margin = const EdgeInsets.all(0.0),
    this.titleStyle,
    this.subtitleStyle,
    this.dense = false,
    this.visualDensity,
    this.splashColor,
    this.highlightColor,
  });

  /// Creates a [CustomListTile] with an icon as the leading widget.
  factory CustomListTile.icon({
    Key? key,
    required Widget title,
    Widget? subtitle,
    required IconData icon,
    double iconSize = 24.0,
    Color? iconColor,
    Widget? trailing,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    Color? backgroundColor,
    Color? selectedColor,
    bool isSelected = false,
    bool enabled = true,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.symmetric(horizontal: 16.0),
    double? horizontalTitleGap,
    double? minLeadingWidth,
    double minVerticalPadding = 4.0,
    ShapeBorder? shape,
    double borderRadius = 8.0,
    Color? borderColor,
    double borderWidth = 0.0,
    double elevation = 0.0,
    Color? shadowColor,
    EdgeInsetsGeometry margin = const EdgeInsets.all(0.0),
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    bool dense = false,
    VisualDensity? visualDensity,
    Color? splashColor,
    Color? highlightColor,
  }) {
    return CustomListTile(
      key: key,
      title: title,
      subtitle: subtitle,
      leading: Icon(
        icon,
        size: iconSize,
        color: iconColor,
      ),
      trailing: trailing,
      onTap: onTap,
      onLongPress: onLongPress,
      backgroundColor: backgroundColor,
      selectedColor: selectedColor,
      isSelected: isSelected,
      enabled: enabled,
      contentPadding: contentPadding,
      horizontalTitleGap: horizontalTitleGap,
      minLeadingWidth: minLeadingWidth,
      minVerticalPadding: minVerticalPadding,
      shape: shape,
      borderRadius: borderRadius,
      borderColor: borderColor,
      borderWidth: borderWidth,
      elevation: elevation,
      shadowColor: shadowColor,
      margin: margin,
      titleStyle: titleStyle,
      subtitleStyle: subtitleStyle,
      dense: dense,
      visualDensity: visualDensity,
      splashColor: splashColor,
      highlightColor: highlightColor,
    );
  }

  /// Creates a [CustomListTile] with a circular avatar as the leading widget.
  factory CustomListTile.avatar({
    Key? key,
    required Widget title,
    Widget? subtitle,
    required Widget avatar,
    double avatarRadius = 20.0,
    Widget? trailing,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    Color? backgroundColor,
    Color? selectedColor,
    bool isSelected = false,
    bool enabled = true,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.symmetric(horizontal: 16.0),
    double? horizontalTitleGap,
    double? minLeadingWidth,
    double minVerticalPadding = 4.0,
    ShapeBorder? shape,
    double borderRadius = 8.0,
    Color? borderColor,
    double borderWidth = 0.0,
    double elevation = 0.0,
    Color? shadowColor,
    EdgeInsetsGeometry margin = const EdgeInsets.all(0.0),
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    bool dense = false,
    VisualDensity? visualDensity,
    Color? splashColor,
    Color? highlightColor,
  }) {
    return CustomListTile(
      key: key,
      title: title,
      subtitle: subtitle,
      leading: CircleAvatar(
        radius: avatarRadius,
        child: avatar,
      ),
      trailing: trailing,
      onTap: onTap,
      onLongPress: onLongPress,
      backgroundColor: backgroundColor,
      selectedColor: selectedColor,
      isSelected: isSelected,
      enabled: enabled,
      contentPadding: contentPadding,
      horizontalTitleGap: horizontalTitleGap,
      minLeadingWidth: minLeadingWidth,
      minVerticalPadding: minVerticalPadding,
      shape: shape,
      borderRadius: borderRadius,
      borderColor: borderColor,
      borderWidth: borderWidth,
      elevation: elevation,
      shadowColor: shadowColor,
      margin: margin,
      titleStyle: titleStyle,
      subtitleStyle: subtitleStyle,
      dense: dense,
      visualDensity: visualDensity,
      splashColor: splashColor,
      highlightColor: highlightColor,
    );
  }

  /// Creates a [CustomListTile] with a checkbox as the trailing widget.
  factory CustomListTile.checkbox({
    Key? key,
    required Widget title,
    Widget? subtitle,
    Widget? leading,
    required bool value,
    required ValueChanged<bool?>? onChanged,
    Color? activeColor,
    Color? checkColor,
    Color? backgroundColor,
    Color? selectedColor,
    bool isSelected = false,
    bool enabled = true,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.symmetric(horizontal: 16.0),
    double? horizontalTitleGap,
    double? minLeadingWidth,
    double minVerticalPadding = 4.0,
    ShapeBorder? shape,
    double borderRadius = 8.0,
    Color? borderColor,
    double borderWidth = 0.0,
    double elevation = 0.0,
    Color? shadowColor,
    EdgeInsetsGeometry margin = const EdgeInsets.all(0.0),
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    bool dense = false,
    VisualDensity? visualDensity,
    Color? splashColor,
    Color? highlightColor,
  }) {
    return CustomListTile(
      key: key,
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: Checkbox(
        value: value,
        onChanged: enabled ? onChanged : null,
        activeColor: activeColor,
        checkColor: checkColor,
      ),
      onTap: enabled ? () => onChanged?.call(!value) : null,
      backgroundColor: backgroundColor,
      selectedColor: selectedColor,
      isSelected: isSelected,
      enabled: enabled,
      contentPadding: contentPadding,
      horizontalTitleGap: horizontalTitleGap,
      minLeadingWidth: minLeadingWidth,
      minVerticalPadding: minVerticalPadding,
      shape: shape,
      borderRadius: borderRadius,
      borderColor: borderColor,
      borderWidth: borderWidth,
      elevation: elevation,
      shadowColor: shadowColor,
      margin: margin,
      titleStyle: titleStyle,
      subtitleStyle: subtitleStyle,
      dense: dense,
      visualDensity: visualDensity,
      splashColor: splashColor,
      highlightColor: highlightColor,
    );
  }

  /// Creates a [CustomListTile] with a switch as the trailing widget.
  factory CustomListTile.toggle({
    Key? key,
    required Widget title,
    Widget? subtitle,
    Widget? leading,
    required bool value,
    required ValueChanged<bool>? onChanged,
    Color? activeColor,
    Color? activeTrackColor,
    Color? inactiveThumbColor,
    Color? inactiveTrackColor,
    Color? backgroundColor,
    Color? selectedColor,
    bool isSelected = false,
    bool enabled = true,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.symmetric(horizontal: 16.0),
    double? horizontalTitleGap,
    double? minLeadingWidth,
    double minVerticalPadding = 4.0,
    ShapeBorder? shape,
    double borderRadius = 8.0,
    Color? borderColor,
    double borderWidth = 0.0,
    double elevation = 0.0,
    Color? shadowColor,
    EdgeInsetsGeometry margin = const EdgeInsets.all(0.0),
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    bool dense = false,
    VisualDensity? visualDensity,
    Color? splashColor,
    Color? highlightColor,
  }) {
    return CustomListTile(
      key: key,
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: Switch(
        value: value,
        onChanged: enabled ? onChanged : null,
        activeColor: activeColor,
        activeTrackColor: activeTrackColor,
        inactiveThumbColor: inactiveThumbColor,
        inactiveTrackColor: inactiveTrackColor,
      ),
      onTap: enabled ? () => onChanged?.call(!value) : null,
      backgroundColor: backgroundColor,
      selectedColor: selectedColor,
      isSelected: isSelected,
      enabled: enabled,
      contentPadding: contentPadding,
      horizontalTitleGap: horizontalTitleGap,
      minLeadingWidth: minLeadingWidth,
      minVerticalPadding: minVerticalPadding,
      shape: shape,
      borderRadius: borderRadius,
      borderColor: borderColor,
      borderWidth: borderWidth,
      elevation: elevation,
      shadowColor: shadowColor,
      margin: margin,
      titleStyle: titleStyle,
      subtitleStyle: subtitleStyle,
      dense: dense,
      visualDensity: visualDensity,
      splashColor: splashColor,
      highlightColor: highlightColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final effectiveBackgroundColor = backgroundColor ?? (isSelected ? selectedColor ?? theme.colorScheme.primaryContainer : null);
    final effectiveShadowColor = shadowColor ?? theme.shadowColor;
    
    final effectiveTitleStyle = titleStyle ?? (isSelected
        ? theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          )
        : theme.textTheme.titleMedium);
    
    final effectiveSubtitleStyle = subtitleStyle ?? (isSelected
        ? theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
          )
        : theme.textTheme.bodyMedium);
    
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
    
    Widget listTile = ListTile(
      title: DefaultTextStyle(
        style: effectiveTitleStyle ?? const TextStyle(),
        child: title,
      ),
      subtitle: subtitle != null
          ? DefaultTextStyle(
              style: effectiveSubtitleStyle ?? const TextStyle(),
              child: subtitle!,
            )
          : null,
      leading: leading,
      trailing: trailing,
      onTap: enabled ? onTap : null,
      onLongPress: enabled ? onLongPress : null,
      selected: isSelected,
      enabled: enabled,
      contentPadding: contentPadding,
      horizontalTitleGap: horizontalTitleGap,
      minLeadingWidth: minLeadingWidth,
      minVerticalPadding: minVerticalPadding,
      dense: dense,
      visualDensity: visualDensity,
      tileColor: effectiveBackgroundColor,
      selectedTileColor: selectedColor,
      shape: effectiveShape,
    );
    
    if (elevation > 0) {
      listTile = Material(
        elevation: elevation,
        shadowColor: effectiveShadowColor,
        shape: effectiveShape,
        color: effectiveBackgroundColor,
        child: listTile,
      );
    }
    
    if (margin != EdgeInsets.zero) {
      listTile = Padding(
        padding: margin,
        child: listTile,
      );
    }
    
    if (onTap != null || onLongPress != null) {
      listTile = InkWell(
        onTap: enabled ? onTap : null,
        onLongPress: enabled ? onLongPress : null,
        splashColor: splashColor,
        highlightColor: highlightColor,
        borderRadius: BorderRadius.circular(borderRadius),
        child: listTile,
      );
    }
    
    return listTile;
  }
}