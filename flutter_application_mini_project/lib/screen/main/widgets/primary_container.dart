import 'package:flutter/material.dart';
import 'package:flutter_application_mini_project/utils/my_color.dart';

class PrimaryContainer extends StatelessWidget {
  const PrimaryContainer({
    super.key,
    this.child,
    this.height,
    this.width,

  });

  final Widget? child;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {

    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            MyColor.primaryColor,
            MyColor.primaryGradientColor
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: MyColor.secondaryColor, width: 0.7),
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: 0,
            offset: Offset(0, 0),
            color: Colors.black45
          )
        ],
      ),
      child: child
    );
  }
}