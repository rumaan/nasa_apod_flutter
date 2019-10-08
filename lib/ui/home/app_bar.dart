import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      title: Text("NASA APOD"),
      elevation: 2.0,
      snap: true,
      floating: true,
    );
  }
}
