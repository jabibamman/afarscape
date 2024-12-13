import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onSearchCancelled;
  final bool showBackButton;
  final bool showSearching;

  const CustomAppBar({
    super.key,
    this.onSearchChanged,
    this.onSearchCancelled,
    this.showBackButton = false,
    this.showSearching = true,
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
    final theme = Theme.of(context);

    return SliverAppBar(
      floating: true,
      pinned: false,
      backgroundColor: theme.colorScheme.surface,
      elevation: 0,
      leading: widget.showBackButton
          ? IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: theme.colorScheme.primary,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )
          : null,
      centerTitle: !_isSearching,
      title: widget.showSearching && _isSearching
          ? TextField(
        controller: _searchController,
        onChanged: widget.onSearchChanged,
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.6)),
          border: InputBorder.none,
        ),
        style: TextStyle(color: theme.colorScheme.onSurface),
      )
          : widget.showSearching
          ? GestureDetector(
        onTap: _startSearch,
        child: Icon(
          Icons.travel_explore,
          size: 30,
          color: theme.colorScheme.primary,
        ),
      )
          : null,
      actions: widget.showSearching && _isSearching
          ? [
        IconButton(
          icon: Icon(
            Icons.close,
            color: theme.colorScheme.primary,
          ),
          onPressed: _cancelSearch,
        ),
      ]
          : [],
    );
  }
}
