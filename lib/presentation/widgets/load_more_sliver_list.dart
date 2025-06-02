import 'package:flutter/material.dart';
import 'loading_indicator.dart';
import 'skeleton_item.dart';

/// A SliverList with load more functionality and skeleton loading.
///
/// This widget can be used in a CustomScrollView and detects when the user
/// scrolls to the bottom of the list, triggering a callback to load more items
/// while showing a loading indicator at the bottom.
class LoadMoreSliverList<T> extends StatefulWidget {
  /// The list of items to display
  final List<T> items;

  /// The builder function to create a widget for each item
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  /// The callback function to load more items
  final Future<void> Function() onLoadMore;

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

  /// The scroll controller of the parent CustomScrollView
  final ScrollController? controller;

  /// The threshold in pixels to trigger load more
  final double loadMoreThreshold;

  /// Whether to show a loading indicator at the bottom of the list
  final bool showLoadingIndicator;

  /// Creates a [LoadMoreSliverList].
  const LoadMoreSliverList({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.onLoadMore,
    this.hasMoreItems = true,
    this.isLoading = false,
    this.skeletonItemCount = 5,
    this.skeletonItemBuilder,
    this.loadingIndicator,
    this.controller,
    this.loadMoreThreshold = 200.0,
    this.showLoadingIndicator = true,
  });

  @override
  State<LoadMoreSliverList<T>> createState() => _LoadMoreSliverListState<T>();
}

class _LoadMoreSliverListState<T> extends State<LoadMoreSliverList<T>> {
  ScrollController? _scrollController;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller;
    if (_scrollController != null) {
      _scrollController!.addListener(_scrollListener);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // If no controller was provided, try to get it from the CustomScrollView
    if (_scrollController == null) {
      _scrollController = Scrollable.of(context).widget.controller;
      if (_scrollController != null) {
        _scrollController!.addListener(_scrollListener);
      }
    }
  }

  @override
  void dispose() {
    if (_scrollController != null) {
      _scrollController!.removeListener(_scrollListener);
    }
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController == null ||
        _isLoadingMore ||
        !widget.hasMoreItems ||
        widget.isLoading) {
      return;
    }

    final maxScroll = _scrollController!.position.maxScrollExtent;
    final currentScroll = _scrollController!.position.pixels;

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
    // If the list is empty and loading, show skeleton items
    if (widget.items.isEmpty && widget.isLoading) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => _buildSkeletonItem(context, index),
          childCount: widget.skeletonItemCount,
        ),
      );
    }

    // If we have items, show them with a loading indicator at the bottom if needed
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index < widget.items.length) {
            return widget.itemBuilder(context, widget.items[index], index);
          } else {
            // Only show loading indicator if showLoadingIndicator is true
            return widget.showLoadingIndicator
                ? _buildLoadingIndicator()
                : const SizedBox.shrink();
          }
        },
        childCount: widget.items.length +
            (widget.hasMoreItems && widget.showLoadingIndicator ? 1 : 0),
      ),
    );
  }
}

/// A widget that combines multiple load more sliver widgets with pull-to-refresh support.
///
/// This widget can be used to create a CustomScrollView with multiple
/// load more sliver widgets, such as LoadMoreSliverList and LoadMoreSliverGrid.
/// It also supports pull-to-refresh functionality.
class LoadMoreCustomScrollView extends StatefulWidget {
  /// The slivers to place inside the viewport.
  final List<Widget> slivers;

  /// The scroll controller to use.
  final ScrollController? controller;

  /// The scroll physics to use.
  final ScrollPhysics? physics;

  /// Whether the scroll view scrolls in the reading direction.
  final bool reverse;

  /// Whether this is the primary scroll view associated with the parent.
  final bool? primary;

  /// Whether the scroll view should shrink-wrap its contents.
  final bool shrinkWrap;

  /// The amount of offset that will trigger the onLoadMore callback.
  final double loadMoreThreshold;

  /// The callback that is called when the scroll view is scrolled to the bottom.
  final Future<void> Function()? onLoadMore;

  /// The callback function to refresh the content.
  final Future<void> Function() onRefresh;

  /// Whether more items can be loaded.
  final bool hasMoreItems;

  /// Whether items are currently being loaded.
  final bool isLoading;

  /// The color of the refresh indicator
  final Color? refreshIndicatorColor;

  /// The background color of the refresh indicator
  final Color? refreshIndicatorBackgroundColor;

  /// The displacement of the refresh indicator
  final double refreshIndicatorDisplacement;

  /// The stroke width of the refresh indicator
  final double refreshIndicatorStrokeWidth;

  /// Creates a [LoadMoreCustomScrollView].
  const LoadMoreCustomScrollView({
    super.key,
    required this.slivers,
    this.controller,
    this.physics,
    this.reverse = false,
    this.primary,
    this.shrinkWrap = false,
    this.loadMoreThreshold = 200.0,
    this.onLoadMore,
    required this.onRefresh,
    this.hasMoreItems = true,
    this.isLoading = false,
    this.refreshIndicatorColor,
    this.refreshIndicatorBackgroundColor,
    this.refreshIndicatorDisplacement = 40.0,
    this.refreshIndicatorStrokeWidth = 2.0,
  });

  @override
  State<LoadMoreCustomScrollView> createState() =>
      _LoadMoreCustomScrollViewState();
}

class _LoadMoreCustomScrollViewState extends State<LoadMoreCustomScrollView> {
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
    if (_isLoadingMore ||
        widget.onLoadMore == null ||
        !widget.hasMoreItems ||
        widget.isLoading) {
      return;
    }

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= widget.loadMoreThreshold) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore || widget.onLoadMore == null) return;

    setState(() {
      _isLoadingMore = true;
    });

    await widget.onLoadMore!();

    if (mounted) {
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build the custom scroll view
    Widget scrollView = RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: CustomScrollView(
        controller: _scrollController,
        physics: widget.physics,
        reverse: widget.reverse,
        primary: widget.primary,
        shrinkWrap: widget.shrinkWrap,
        slivers: [
          ...widget.slivers,
          if (widget.hasMoreItems && widget.onLoadMore != null)
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: widget.isLoading || _isLoadingMore
                      ? const LoadingIndicator(
                          size: 32.0,
                          strokeWidth: 6.0,
                          type: LoadingIndicatorType.circular,
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ),
        ],
      ),
    );

    return scrollView;
  }
}
