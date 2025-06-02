import 'package:flutter/material.dart';
import 'loading_indicator.dart';
import 'skeleton_item.dart';

/// A GridView with load more functionality, pull-to-refresh, and skeleton loading.
///
/// This widget detects when the user scrolls to the bottom of the grid and
/// triggers a callback to load more items, while showing a loading indicator
/// at the bottom. It also supports pull-to-refresh functionality.
class LoadMoreGridView<T> extends StatefulWidget {
  /// The list of items to display
  final List<T> items;

  /// The builder function to create a widget for each item
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  /// The callback function to load more items
  final Future<void> Function() onLoadMore;

  /// The callback function to refresh the grid
  final Future<void> Function()? onRefresh;

  /// Whether more items can be loaded
  final bool hasMoreItems;

  /// Whether items are currently being loaded
  final bool isLoading;

  /// The number of skeleton items to show when loading
  final int skeletonItemCount;

  /// The builder function to create a skeleton item
  final Widget Function(BuildContext context, int index)? skeletonItemBuilder;

  /// The loading indicator to show at the bottom when loading more items
  final Widget? loadingIndicator;

  /// The padding around the grid
  final EdgeInsetsGeometry? padding;

  /// The scroll physics of the grid
  final ScrollPhysics? physics;

  /// The scroll controller of the grid
  final ScrollController? controller;

  /// Whether to shrink wrap the grid
  final bool shrinkWrap;

  /// The threshold in pixels to trigger load more
  final double loadMoreThreshold;

  /// The number of columns in the grid
  final int crossAxisCount;

  /// The ratio of the cross-axis to the main-axis extent of each child
  final double childAspectRatio;

  /// The spacing between the children in the cross axis
  final double crossAxisSpacing;

  /// The spacing between the children in the main axis
  final double mainAxisSpacing;

  /// The color of the refresh indicator
  final Color? refreshIndicatorColor;

  /// The background color of the refresh indicator
  final Color? refreshIndicatorBackgroundColor;

  /// The displacement of the refresh indicator
  final double refreshIndicatorDisplacement;

  /// The stroke width of the refresh indicator
  final double refreshIndicatorStrokeWidth;

  /// Creates a [LoadMoreGridView].
  const LoadMoreGridView({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.onLoadMore,
    this.onRefresh,
    this.hasMoreItems = true,
    this.isLoading = false,
    this.skeletonItemCount = 10,
    this.skeletonItemBuilder,
    this.loadingIndicator,
    this.padding,
    this.physics,
    this.controller,
    this.shrinkWrap = false,
    this.loadMoreThreshold = 200.0,
    this.crossAxisCount = 2,
    this.childAspectRatio = 1.0,
    this.crossAxisSpacing = 10.0,
    this.mainAxisSpacing = 10.0,
    this.refreshIndicatorColor,
    this.refreshIndicatorBackgroundColor,
    this.refreshIndicatorDisplacement = 40.0,
    this.refreshIndicatorStrokeWidth = 3.0,
  });

  @override
  State<LoadMoreGridView<T>> createState() => _LoadMoreGridViewState<T>();
}

class _LoadMoreGridViewState<T> extends State<LoadMoreGridView<T>> {
  late ScrollController _scrollController;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _scrollController.dispose();
    } else {
      _scrollController.removeListener(_scrollListener);
    }
    super.dispose();
  }

  void _scrollListener() {
    if (_isLoadingMore || !widget.hasMoreItems || widget.isLoading) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= widget.loadMoreThreshold) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    await widget.onLoadMore();

    if (mounted) {
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  Widget _buildLoadingIndicator() {
    return widget.loadingIndicator ?? 
        const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: LoadingIndicator(
              size: 32.0,
              strokeWidth: 6.0,
              type: LoadingIndicatorType.circular,
            ),
          ),
        );
  }

  Widget _buildSkeletonItem(BuildContext context, int index) {
    return widget.skeletonItemBuilder?.call(context, index) ?? 
        SkeletonItem.gridTile();
  }

  @override
  Widget build(BuildContext context) {
    // Build the grid view
    Widget gridView;

    // If the list is empty and loading, show skeleton items
    if (widget.items.isEmpty && widget.isLoading) {
      gridView = GridView.builder(
        padding: widget.padding,
        physics: widget.onRefresh != null 
            ? widget.physics ?? const AlwaysScrollableScrollPhysics() 
            : widget.physics,
        controller: _scrollController,
        shrinkWrap: widget.shrinkWrap,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.crossAxisCount,
          childAspectRatio: widget.childAspectRatio,
          crossAxisSpacing: widget.crossAxisSpacing,
          mainAxisSpacing: widget.mainAxisSpacing,
        ),
        itemCount: widget.skeletonItemCount,
        itemBuilder: (context, index) => _buildSkeletonItem(context, index),
      );
    } else {
      // Calculate the total item count (items + loading indicator)
      final int totalItemCount = widget.items.length + (widget.hasMoreItems ? 1 : 0);

      // Calculate the number of rows needed for the grid
      final int rowCount = (totalItemCount / widget.crossAxisCount).ceil();

      // Calculate the total number of cells (including empty cells)
      final int totalCellCount = rowCount * widget.crossAxisCount;

      gridView = GridView.builder(
        padding: widget.padding,
        physics: widget.onRefresh != null 
            ? widget.physics ?? const AlwaysScrollableScrollPhysics() 
            : widget.physics,
        controller: _scrollController,
        shrinkWrap: widget.shrinkWrap,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.crossAxisCount,
          childAspectRatio: widget.childAspectRatio,
          crossAxisSpacing: widget.crossAxisSpacing,
          mainAxisSpacing: widget.mainAxisSpacing,
        ),
        itemCount: totalCellCount,
        itemBuilder: (context, index) {
          // If we're at the last row and have a loading indicator
          if (index >= widget.items.length) {
            // Show loading indicator only in the center of the last row
            if (widget.hasMoreItems && index == widget.items.length) {
              return _buildLoadingIndicator();
            }
            // Empty cell for the rest of the last row
            return const SizedBox.shrink();
          }

          // Regular item
          return widget.itemBuilder(context, widget.items[index], index);
        },
      );
    }

    // Wrap with RefreshIndicator if onRefresh is provided
    if (widget.onRefresh != null) {
      final theme = Theme.of(context);
      return RefreshIndicator(
        onRefresh: widget.onRefresh!,
        color: widget.refreshIndicatorColor ?? theme.colorScheme.primary,
        backgroundColor: widget.refreshIndicatorBackgroundColor,
        displacement: widget.refreshIndicatorDisplacement,
        strokeWidth: widget.refreshIndicatorStrokeWidth,
        child: gridView,
      );
    }

    return gridView;
  }
}
