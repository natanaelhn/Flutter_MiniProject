import 'package:flutter/material.dart';

class MyImageLoadingIndicator extends StatelessWidget {
  const MyImageLoadingIndicator({super.key, required this.percent, this.color = Colors.white});

  final double percent; //0.10, 0.20, 0.30 etc
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircularProgressIndicator(
          value: percent,
          color: color
        ),
        Text((percent*100).toInt().toString(), style: TextStyle(color: color),)
      ],
    );
  }
}