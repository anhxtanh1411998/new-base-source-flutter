import 'package:flutter/material.dart';

/// A customizable app bar widget that can be used throughout the application.
///
/// This app bar supports different styles, actions, and search functionality.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The title of the app bar
  final String? title;
  
  /// The widget to display as the title
  final Widget? titleWidget;
  
  /// The text style for the title
  final TextStyle? titleStyle;
  
  /// The background color of the app bar
  final Color? backgroundColor;
  
  /// The foreground color of the app bar (affects icons and text)
  final Color? foregroundColor;
  
  /// The elevation of the app bar
  final double elevation;
  
  /// The leading widget of the app bar
  final Widget? leading;
  
  /// The list of action widgets to display at the end of the app bar
  final List<Widget>? actions;
  
  /// Whether to show a back button if possible
  final bool automaticallyImplyLeading;
  
  /// Whether the app bar should be centered
  final bool centerTitle;
  
  /// Whether the app bar should have a shadow
  final bool hasShadow;
  
  /// The bottom widget of the app bar
  final PreferredSizeWidget? bottom;
  
  /// The shape of the app bar
  final ShapeBorder? shape;
  
  /// The padding around the app bar content
  final EdgeInsetsGeometry? padding;
  
  /// The height of the app bar
  final double? height;
  
  /// Whether the app bar is in search mode
  final bool isSearchMode;
  
  /// The controller for the search field
  final TextEditingController? searchController;
  
  /// The hint text for the search field
  final String searchHint;
  
  /// The callback function when the search query changes
  final ValueChanged<String>? onSearchChanged;
  
  /// The callback function when the search is submitted
  final ValueChanged<String>? onSearchSubmitted;
  
  /// The callback function when the search is closed
  final VoidCallback? onSearchClosed;
  
  /// The callback function when the search is opened
  final VoidCallback? onSearchOpened;
  
  /// Creates a [CustomAppBar].
  const CustomAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.titleStyle,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0.0,
    this.leading,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.centerTitle = true,
    this.hasShadow = false,
    this.bottom,
    this.shape,
    this.padding,
    this.height,
    this.isSearchMode = false,
    this.searchController,
    this.searchHint = 'Search',
    this.onSearchChanged,
    this.onSearchSubmitted,
    this.onSearchClosed,
    this.onSearchOpened,
  });

  /// Creates a [CustomAppBar] with a search field.
  factory CustomAppBar.search({
    Key? key,
    String? title,
    Widget? titleWidget,
    TextStyle? titleStyle,
    Color? backgroundColor,
    Color? foregroundColor,
    double elevation = 0.0,
    Widget? leading,
    List<Widget>? actions,
    bool automaticallyImplyLeading = true,
    bool centerTitle = true,
    bool hasShadow = false,
    PreferredSizeWidget? bottom,
    ShapeBorder? shape,
    EdgeInsetsGeometry? padding,
    double? height,
    required TextEditingController searchController,
    String searchHint = 'Search',
    ValueChanged<String>? onSearchChanged,
    ValueChanged<String>? onSearchSubmitted,
    VoidCallback? onSearchClosed,
  }) {
    return CustomAppBar(
      key: key,
      title: title,
      titleWidget: titleWidget,
      titleStyle: titleStyle,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
      leading: leading,
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: onSearchClosed,
        ),
        ...(actions ?? []),
      ],
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centerTitle,
      hasShadow: hasShadow,
      bottom: bottom,
      shape: shape,
      padding: padding,
      height: height,
      isSearchMode: true,
      searchController: searchController,
      searchHint: searchHint,
      onSearchChanged: onSearchChanged,
      onSearchSubmitted: onSearchSubmitted,
      onSearchClosed: onSearchClosed,
    );
  }

  /// Creates a [CustomAppBar] with a transparent background.
  factory CustomAppBar.transparent({
    Key? key,
    String? title,
    Widget? titleWidget,
    TextStyle? titleStyle,
    Color? foregroundColor,
    Widget? leading,
    List<Widget>? actions,
    bool automaticallyImplyLeading = true,
    bool centerTitle = true,
    PreferredSizeWidget? bottom,
    EdgeInsetsGeometry? padding,
    double? height,
  }) {
    return CustomAppBar(
      key: key,
      title: title,
      titleWidget: titleWidget,
      titleStyle: titleStyle,
      backgroundColor: Colors.transparent,
      foregroundColor: foregroundColor,
      elevation: 0.0,
      leading: leading,
      actions: actions,
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centerTitle,
      hasShadow: false,
      bottom: bottom,
      shape: null,
      padding: padding,
      height: height,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final effectiveBackgroundColor = backgroundColor ?? theme.colorScheme.surface;
    final effectiveForegroundColor = foregroundColor ?? theme.colorScheme.onSurface;
    final effectiveTitleStyle = titleStyle ?? theme.textTheme.titleLarge?.copyWith(
      color: effectiveForegroundColor,
      fontWeight: FontWeight.bold,
    );
    
    final effectiveElevation = hasShadow ? (elevation > 0 ? elevation : 4.0) : 0.0;
    
    if (isSearchMode) {
      return AppBar(
        backgroundColor: effectiveBackgroundColor,
        foregroundColor: effectiveForegroundColor,
        elevation: effectiveElevation,
        automaticallyImplyLeading: automaticallyImplyLeading,
        centerTitle: centerTitle,
        shape: shape,
        bottom: bottom,
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: searchHint,
            border: InputBorder.none,
            hintStyle: TextStyle(color: effectiveForegroundColor.withValues(alpha: 0.6)),
          ),
          style: TextStyle(color: effectiveForegroundColor),
          cursorColor: effectiveForegroundColor,
          onChanged: onSearchChanged,
          onSubmitted: onSearchSubmitted,
          autofocus: true,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onSearchClosed,
        ),
        actions: [
          if (searchController != null && searchController!.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                searchController!.clear();
                if (onSearchChanged != null) {
                  onSearchChanged!('');
                }
              },
            ),
        ],
      );
    }
    
    return AppBar(
      backgroundColor: effectiveBackgroundColor,
      foregroundColor: effectiveForegroundColor,
      elevation: effectiveElevation,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centerTitle,
      shape: shape,
      bottom: bottom,
      title: titleWidget ?? (title != null ? Text(title!, style: effectiveTitleStyle) : null),
      actions: actions,
      titleSpacing: padding?.horizontal,
      toolbarHeight: height,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}