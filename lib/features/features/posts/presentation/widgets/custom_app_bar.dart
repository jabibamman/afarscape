import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();

    return SliverAppBar(
      floating: true,
      pinned: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      leading: canPop
          ? IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.blueAccent),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )
          : null,
      centerTitle: true,
      title: const Icon(
        Icons.travel_explore,
        size: 30,
        color: Colors.blueAccent,
      ),
    );
  }
}