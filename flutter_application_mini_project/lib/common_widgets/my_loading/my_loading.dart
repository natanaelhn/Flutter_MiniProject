import 'package:flutter/material.dart';

class MyLoading extends StatelessWidget {
  const MyLoading({super.key, required this.isLoading, this.color});

  final bool isLoading;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return 
      (!isLoading)? const SizedBox() : Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black45,
        child: Center(
          child: CircularProgressIndicator(
            color: (color == null)? Colors.blue : color,
          ),
        ),
      );
  }
}