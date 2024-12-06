import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      floating: true,
      pinned: false,
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Icon(
        Icons.travel_explore,
        size: 30,
        color: Colors.blueAccent,
      ),
    );
  }
}