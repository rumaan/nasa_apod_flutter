import 'package:flutter/material.dart';

class CardBuilder extends StatelessWidget {
  final _borderRadius = BorderRadius.circular(7.0);
  final Widget child;

  CardBuilder({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        width: double.maxFinite,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: _borderRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.white30,
              offset: Offset(0, 8),
              blurRadius: 18,
            ),
          ],
        ),
        child: ClipRRect(
            borderRadius: _borderRadius,
            child: Container(
              color: Colors.black,
              padding: EdgeInsets.all(16.0),
              child: child,
            )));
  }
}
