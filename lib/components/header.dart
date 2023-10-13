import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TabBar? tabBar;

  const Header({required this.title, this.tabBar, Key? key}) : super(key: key);

  @override
  Size get preferredSize {
    return const Size.fromHeight(100.0);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      bottom: tabBar,
    );
  }
}
