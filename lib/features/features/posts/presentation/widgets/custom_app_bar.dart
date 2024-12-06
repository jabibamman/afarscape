import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SliverAppBar(
      floating: true,
      pinned: false,
      backgroundColor: colorScheme.surface,
      elevation: 0,
      centerTitle: true,
      title: Icon(
        Icons.travel_explore,
        size: 30,
        color: colorScheme.primary,
      ),
    );
  }
}
