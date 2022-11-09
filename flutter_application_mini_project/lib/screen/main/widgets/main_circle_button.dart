import 'package:flutter/material.dart';
import 'package:flutter_application_mini_project/utils/my_color.dart';

class MainCircleButton extends StatelessWidget {
  const MainCircleButton({super.key, required this.title, required this.icon, required this.onTap});

  final String title;
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        //Circle and title
        Column(
          children: [
            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: MyColor.secondaryColor, width: 2),
                boxShadow: const [
                  BoxShadow(spreadRadius: 1, blurRadius: 2, color: Colors.black45)
                ],
                // gradient: LinearGradient(
                //   begin: Alignment.centerLeft,
                //   end: Alignment.centerRight,
                //   colors: [
                //     MyColor.primaryColor,
                //     MyColor.primaryGradientColor
                //   ]
                // )
                color: MyColor.primaryColor
              ),
              child: Icon(icon, color: Colors.white, size: 30,),
            ),
            const SizedBox(height: 10,),
            Text(title)
          ],
        ),

        //Material and InkWell
        Positioned.fill(child: Material(
          color: Colors.transparent,  
          child: InkWell(
            customBorder: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), 
                topRight: Radius.circular(25), 
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )
            ),
            onTap: onTap,
          ),
        ))
      ],
    );
  }
}