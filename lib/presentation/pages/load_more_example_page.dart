import 'package:flutter/material.dart';
import '../widgets/load_more_list_view.dart';
import '../widgets/load_more_grid_view.dart';
import '../widgets/load_more_sliver_list.dart';

/// An example page that demonstrates how to use the load more widgets.
class LoadMoreExamplePage extends StatefulWidget {
  const LoadMoreExamplePage({super.key});

  @override
  State<LoadMoreExamplePage> createState() => _LoadMoreExamplePageState();
}

class _LoadMoreExamplePageState extends State<LoadMoreExamplePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Example data
  final List<String> _listItems = List.generate(20, (index) => 'Item ${index + 1}');
  final List<String> _gridItems = List.generate(20, (index) => 'Grid Item ${index + 1}');
  final List<String> _sliverItems = List.generate(20, (index) => 'Sliver Item ${index + 1}');

  bool _isLoading = false;
  bool _hasMoreItems = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Simulates loading more items
  Future<void> _loadMoreItems() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      // Add 10 more items
      final int currentLength = _listItems.length;

      if (currentLength >= 50) {
        // No more items to load
        _hasMoreItems = false;
      } else {
        // Add more items
        _listItems.addAll(
          List.generate(10, (index) => 'Item ${currentLength + index + 1}')
        );

        _gridItems.addAll(
          List.generate(10, (index) => 'Grid Item ${currentLength + index + 1}')
        );

        _sliverItems.addAll(
          List.generate(10, (index) => 'Sliver Item ${currentLength + index + 1}')
        );
      }

      _isLoading = false;
    });
  }

  // Simulates refreshing the list
  Future<void> _refreshItems() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Reset the example
    _resetExample();
  }

  // Reset the example
  void _resetExample() {
    setState(() {
      _listItems.clear();
      _listItems.addAll(List.generate(20, (index) => 'Item ${index + 1}'));

      _gridItems.clear();
      _gridItems.addAll(List.generate(20, (index) => 'Grid Item ${index + 1}'));

      _sliverItems.clear();
      _sliverItems.addAll(List.generate(20, (index) => 'Sliver Item ${index + 1}'));

      _hasMoreItems = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Load More Examples'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetExample,
            tooltip: 'Reset Example',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'ListView'),
            Tab(text: 'GridView'),
            Tab(text: 'SliverList'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // ListView Example
          _buildListViewExample(),

          // GridView Example
          _buildGridViewExample(),

          // SliverList Example
          _buildSliverListExample(),
        ],
      ),
    );
  }

  Widget _buildListViewExample() {
    return LoadMoreListView<String>(
      items: _listItems,
      itemBuilder: (context, item, index) {
        return ListTile(
          leading: CircleAvatar(
            child: Text('${index + 1}'),
          ),
          title: Text(item),
          subtitle: Text('Tap to see details'),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Tapped on $item')),
            );
          },
        );
      },
      onLoadMore: _loadMoreItems,
      onRefresh: _refreshItems,
      hasMoreItems: _hasMoreItems,
      isLoading: _isLoading,
      showSeparator: true,
    );
  }

  Widget _buildGridViewExample() {
    return LoadMoreGridView<String>(
      items: _gridItems,
      itemBuilder: (context, item, index) {
        return Card(
          elevation: 2.0,
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tapped on $item')),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.photo, size: 48.0, color: Theme.of(context).primaryColor),
                const SizedBox(height: 8.0),
                Text(
                  item,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Item #${index + 1}'),
              ],
            ),
          ),
        );
      },
      onLoadMore: _loadMoreItems,
      onRefresh: _refreshItems,
      hasMoreItems: _hasMoreItems,
      isLoading: _isLoading,
      crossAxisCount: 2,
      childAspectRatio: 0.8,
      padding: const EdgeInsets.all(8.0),
    );
  }

  Widget _buildSliverListExample() {
    return LoadMoreCustomScrollView(
      onLoadMore: _loadMoreItems,
      onRefresh: _refreshItems,
      hasMoreItems: _hasMoreItems,
      isLoading: _isLoading,
      slivers: [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'CustomScrollView Example',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'This example shows how to use LoadMoreSliverList in a CustomScrollView.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: LoadMoreSliverList<String>(
            items: _sliverItems,
            itemBuilder: (context, item, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text(item),
                  subtitle: Text('Sliver item example'),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tapped on $item')),
                    );
                  },
                ),
              );
            },
            onLoadMore: _loadMoreItems,
            hasMoreItems: _hasMoreItems,
            isLoading: _isLoading,
            // Don't show loading indicator in the SliverList since LoadMoreCustomScrollView already shows one
            showLoadingIndicator: false,
          ),
        ),
      ],
    );
  }
}
