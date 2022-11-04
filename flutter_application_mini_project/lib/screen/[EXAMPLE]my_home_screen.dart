import 'package:flutter/material.dart';
import 'package:flutter_application_mini_project/common_widgets/my_scaffold/my_scaffold.dart';
import 'package:flutter_application_mini_project/utils/my_color.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key,});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {

  @override
  Widget build(BuildContext context) {
    
    return MyScaffold(
      title: (isPortrait) {
        if(isPortrait){
          return const Text('Ini Title', style: TextStyle(color: Colors.white, fontSize: 20),);
        }
        else{
          return const Text('Ini Title', style: TextStyle(color: Colors.white, fontSize: 20),);
        }
      },

      size: 50,
      scrollable: true,
      backButton: true,
      backButtonColor: Colors.white,
      scaffoldBgColor: Colors.white,
      colorPrimary: MyColor.appBarColor,
      colorSecondary: MyColor.appBarColor,

      // when backButton = false, leading widget can be custom

      // leading: TextButton(
      //   onPressed: (){
      //     Navigator.pop(context);
      //   },
      //   style: const ButtonStyle(
      //     fixedSize: MaterialStatePropertyAll(Size(50, 50))
      //   ),
      //   child: const Icon(Icons.arrow_back, color: Colors.white,)
      // ),

      trailing: (isPortrait) {
        if(isPortrait){
          return [
            TextButton(
              onPressed: (){},
              style: const ButtonStyle(
                fixedSize: MaterialStatePropertyAll(Size(50, 50))
              ),
              child: const Icon(Icons.more_vert, color: Colors.white,)
            ),
          ];
        }
        else{
          return [
            TextButton(
              onPressed: (){},
              style: const ButtonStyle(
                fixedSize: MaterialStatePropertyAll(Size(50, 50))
              ),
              child: const Icon(Icons.more_horiz, color: Colors.white,)
            ),
          ];
        }
      },

      subTrailing: (isPortrait) => [
        TextButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomeScreen(),));
          },
          style: const ButtonStyle(
            fixedSize: MaterialStatePropertyAll(Size(50, 50))
          ),
          child: const Icon(Icons.add, color: Colors.white,)
        ),
        TextButton(
          onPressed: (){},
          style: const ButtonStyle(
            fixedSize: MaterialStatePropertyAll(Size(50, 50))
          ),
          child: const Icon(Icons.favorite, color: Colors.white,)
        ),
      ],
      
      



      //CHILD
      child: (isPortrait) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 200,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 30,
              itemBuilder: (context, index) => Text('$index# '),
            ),
          ),
        ],
      )
    );

  }
}
