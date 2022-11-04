import 'package:flutter/material.dart';
import 'package:flutter_application_mini_project/utils/my_color.dart';

class MyColumnDivider extends StatelessWidget {
  const MyColumnDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(height: 10, width: double.infinity, color: MyColor.boxDividerColor,);
  }
}