import 'package:flutter/material.dart';
import 'loading_indicator.dart';
import 'skeleton_item.dart';

/// A ListView with load more functionality, pull-to-refresh, and skeleton loading.
///
/// This widget detects when the user scrolls to the bottom of the list and
/// triggers a callback to load more items, while showing a loading indicator
/// at the bottom. It also supports pull-to-refresh functionality.
class LoadMoreListView<T> extends StatefulWidget {
  /// The list of items to display
  final List<T> items;

  /// The builder function to create a widget for each item
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  /// The callback function to load more items
  final Future<void> Function() onLoadMore;

  /// The callback function to refresh the list
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

  /// The padding around the list
  final EdgeInsetsGeometry? padding;

  /// The scroll physics of the list
  final ScrollPhysics? physics;

  /// The scroll controller of the list
  final ScrollController? controller;

  /// The separator builder for the list
  final Widget Function(BuildContext, int)? separatorBuilder;

  /// Whether to show the separator
  final bool showSeparator;

  /// Whether to shrink wrap the list
  final bool shrinkWrap;

  /// The threshold in pixels to trigger load more
  final double loadMoreThreshold;

  /// The color of the refresh indicator
  final Color? refreshIndicatorColor;

  /// The background color of the refresh indicator
  final Color? refreshIndicatorBackgroundColor;

  /// The displacement of the refresh indicator
  final double refreshIndicatorDisplacement;

  /// The stroke width of the refresh indicator
  final double refreshIndicatorStrokeWidth;

  /// Creates a [LoadMoreListView].
  const LoadMoreListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.onLoadMore,
    this.onRefresh,
    this.hasMoreItems = true,
    this.isLoading = false,
    this.skeletonItemCount = 5,
    this.skeletonItemBuilder,
    this.loadingIndicator,
    this.padding,
    this.physics,
    this.controller,
    this.separatorBuilder,
    this.showSeparator = false,
    this.shrinkWrap = false,
    this.loadMoreThreshold = 200.0,
    this.refreshIndicatorColor,
    this.refreshIndicatorBackgroundColor,
    this.refreshIndicatorDisplacement = 40.0,
    this.refreshIndicatorStrokeWidth = 3.0,
  });

  @override
  State<LoadMoreListView<T>> createState() => _LoadMoreListViewState<T>();
}

class _LoadMoreListViewState<T> extends State<LoadMoreListView<T>> {
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
        SkeletonItem.listTile();
  }

  @override
  Widget build(BuildContext context) {
    // Build the list view
    Widget listView;

    // If the list is empty and loading, show skeleton items
    if (widget.items.isEmpty && widget.isLoading) {
      listView = ListView.separated(
        padding: widget.padding,
        physics: widget.onRefresh != null 
            ? widget.physics ?? const AlwaysScrollableScrollPhysics() 
            : widget.physics,
        controller: _scrollController,
        shrinkWrap: widget.shrinkWrap,
        itemCount: widget.skeletonItemCount,
        itemBuilder: (context, index) => _buildSkeletonItem(context, index),
        separatorBuilder: widget.separatorBuilder ?? 
            (context, index) => widget.showSeparator ? const Divider() : const SizedBox.shrink(),
      );
    } else {
      listView = ListView.separated(
        padding: widget.padding,
        physics: widget.onRefresh != null 
            ? widget.physics ?? const AlwaysScrollableScrollPhysics() 
            : widget.physics,
        controller: _scrollController,
        shrinkWrap: widget.shrinkWrap,
        itemCount: widget.items.length + (widget.hasMoreItems ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < widget.items.length) {
            return widget.itemBuilder(context, widget.items[index], index);
          } else {
            return _buildLoadingIndicator();
          }
        },
        separatorBuilder: widget.separatorBuilder ?? 
            (context, index) => widget.showSeparator ? const Divider() : const SizedBox.shrink(),
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
        child: listView,
      );
    }

    return listView;
  }
}
