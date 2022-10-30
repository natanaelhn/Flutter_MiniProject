import 'package:flutter/material.dart';

class MyAppbar extends StatelessWidget {
  const MyAppbar({
    super.key, 
    required this.isPortrait, 
    this.size,
    this.title,
    this.colorPrimary,
    this.leading,
    this.trailing,
    this.subTrailing,
  });

  final bool isPortrait;
  final double? size;
  final Widget? title;
  final Color? colorPrimary;
  final Widget? leading;
  final List<Widget>? trailing;
  final List<Widget>? subTrailing;

  @override
  Widget build(BuildContext context) {

    double tempSize = (size == null)? 50 : size!;
    List<Widget> listOfWidget = _setListOfWidget();

    return Container(
      color: (colorPrimary == null)? Colors.amber : colorPrimary,
      height: (isPortrait)? tempSize : double.infinity,
      width: (isPortrait)? double.infinity: tempSize,
      child: (isPortrait)? Row(
        children: listOfWidget,
      )
      
      : Column(
        children: listOfWidget,
      ),
      
    );
  }

  List<Widget> _setListOfWidget(){

    Widget tempTitle = (title == null)? const SizedBox() : title!;
    Widget tempLeading = (leading == null)? SizedBox(
      width: (isPortrait)? 16: 0,
    ) : leading!;
    List<Widget> tempTrailing = (trailing == null)? <Widget>[const SizedBox()] : trailing!;
    List<Widget> tempSubTrailing = (subTrailing == null)? <Widget>[const SizedBox()] : subTrailing!;

    List<Widget> tempList = [
      tempLeading,
      (isPortrait)? tempTitle : const SizedBox(),
      Expanded(
        child: (isPortrait)? Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [...tempSubTrailing, ...tempTrailing],
        )
        : Column(
          children: [
            Column(
              children: tempSubTrailing,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: tempTrailing,
              )
            )
          ]
        )
      ),
    ];
    return tempList;
  }
}