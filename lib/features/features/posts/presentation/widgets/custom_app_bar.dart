import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onSearchCancelled;

  const CustomAppBar({
    super.key,
    this.onSearchChanged,
    this.onSearchCancelled,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _cancelSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
      widget.onSearchCancelled?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      leading: _isSearching
          ? IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.blueAccent),
        onPressed: _cancelSearch,
      )
          : null,
      centerTitle: !_isSearching,
      title: _isSearching
          ? TextField(
        controller: _searchController,
        onChanged: widget.onSearchChanged,
        decoration: const InputDecoration(
          hintText: 'Search...',
          border: InputBorder.none,
        ),
      )
          : GestureDetector(
        onTap: _startSearch,
        child: const Icon(
          Icons.travel_explore,
          size: 30,
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}
