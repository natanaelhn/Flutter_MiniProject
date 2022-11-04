import 'package:flutter/material.dart';
import 'package:flutter_application_mini_project/screen/pick_favorite/pick_favorite.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key, required this.isAnime });

  final bool isAnime;

  @override
  Widget build(BuildContext context) {

    String text = (isAnime)? 'Anime' : 'Manga';


    //Trasition Animation
    Route createRoute(){
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const PickFavorite(backButton: true,),
        transitionsBuilder: (context, animation, secondaryAnimation, child){

          final tween = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(CurveTween(curve: Curves.ease));
          final offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child,);
        }
      );
    }




    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(context, createRoute(),);
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 30,
          width: 80,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
      
          child: Row(
            children: [
              const SizedBox(width: 4,),
              Text(text, style: const TextStyle(fontSize: 15),),
              const Expanded(child: Align(alignment: Alignment.centerRight, child: Icon(Icons.expand_more)))
            ],
          )
          
        ),
      ),
    );
  }
}