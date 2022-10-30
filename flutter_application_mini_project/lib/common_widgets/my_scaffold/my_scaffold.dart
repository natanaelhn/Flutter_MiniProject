import 'package:flutter/material.dart';
import 'package:flutter_application_mini_project/common_widgets/my_scaffold/my_scaffold_provider.dart';
import 'package:flutter_application_mini_project/common_widgets/my_scaffold/widgets/my_appbar.dart';
import 'package:provider/provider.dart';

class MyScaffold extends StatefulWidget {
  const MyScaffold({
    super.key, 

    this.title,
    this.size = 50,
    required this.child,
    this.leading,
    this.trailing,
    this.subTrailing,
    this.colorPrimary,
    this.colorSecondary,
    this.scrollable = false,
    this.backButton = true,
    this.backButtonColor = Colors.white,
    this.scaffoldBgColor = Colors.white,

  });
  
  final Widget? Function(bool isPortrait)? title;
  final double? size;
  final Widget Function(bool isPortrait) child;
  final Widget? leading;
  final List<Widget>? Function(bool isPortrait)? trailing;
  final List<Widget>? Function(bool isPortrait)? subTrailing;
  final Color? colorPrimary;
  final Color? colorSecondary;
  final bool scrollable;
  final bool backButton;
  final Color backButtonColor;
  final Color scaffoldBgColor;

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {

  @override
  void initState() {

    context.read<MyScaffoldProvider>().setDefault(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: widget.scaffoldBgColor,
      body: Stack(
        children: [
          Column(
            children: [

              // Give color to status bar
              coloredStatusBar(widget.colorPrimary),

              Expanded(
                child: LayoutBuilder(
                  builder: (p0context, p1constraint) {
              
                    bool isPortrait = (p1constraint.maxHeight > p1constraint.maxWidth)? true : false;
                    Widget? tempTitle = (widget.title == null)? null : widget.title!(isPortrait);
                    Widget tempChild = widget.child(isPortrait);
              
                    Widget appBar = MyAppbar(
                      isPortrait: isPortrait, 
                      size: widget.size,
                      title: tempTitle,
                      leading: (widget.backButton)? backButton(widget.size, widget.backButtonColor): widget.leading,
                      trailing: (widget.trailing == null)? null :  widget.trailing!(isPortrait),
                      subTrailing: (widget.subTrailing == null)? null : widget.subTrailing!(isPortrait),
                      colorPrimary: widget.colorPrimary,
                    );
              
                    //If screen more like portrait mode
                    if(isPortrait){
                      return Column(
                        children: [
                          appBar,
                          Expanded(
                            child: (!widget.scrollable)? SizedBox(
                              height: double.infinity,
                              width: double.infinity,
                              child: Center(
                                child: tempChild
                              )
                            ) : SingleChildScrollView(child: tempChild)
                          )
                        ],
                      );
                    }
              
              
              
                    //if screen more like landscape mode
                    else{
                      
                      MyScaffoldProvider myScaffoldProvider = Provider.of<MyScaffoldProvider>(context, listen: false);
                      
                      ScrollController childScrollController = ScrollController();
                      childScrollController.addListener(() => myScaffoldProvider.scrollListener(childScrollController));
              
              
                      Widget landscapeTitleContainer = (tempTitle == null)? const SizedBox(): Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        color: (widget.colorSecondary == null)? Colors.amber : widget.colorSecondary,
                        child: tempTitle,
                      );
              
              
              
                      Widget landscapeChild = Column(
                        children: [
                          Visibility(
                            visible: (widget.scrollable)? false : true,
                            maintainState: true,
                            maintainAnimation: true,
                            maintainSize: true,
                            child: landscapeTitleContainer
                          ),
                          //Expanded(child: tempChild)
                          (widget.scrollable)? tempChild : Expanded(
                            child: SizedBox(
                              height: double.infinity,
                              width: double.infinity,
                              child: Center(child: tempChild)
                            ),
                          )
                        ],
                      );
              
              
              
              
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appBar,
                          Expanded(
                            child: (!widget.scrollable)? landscapeChild : Stack(
                              children: [
                                SingleChildScrollView(
                                  controller: childScrollController,
                                  child: landscapeChild
                                ),
              
                                //Title widget and child widget for landscape
                                (tempTitle == null)? const SizedBox(): Consumer<MyScaffoldProvider>(
                                  builder: (context, value, child) => AnimatedSlide(
                                    duration: const Duration(milliseconds: 500),
                                    offset: value.offset,
                                    child: landscapeTitleContainer,
                                  ),
                                )
                              ]
                            )
                          )
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),

          coloredStatusBar(widget.colorPrimary),
        ],
      ),
    );
  }

  //return a backButton widget
  Widget backButton(double? size, Color color){

    size = (size == null)? 50 : size;

    return TextButton(
      onPressed: (){
        
        context.read<MyScaffoldProvider>().setDefault(true);
        Navigator.pop(context);
      },
      style: ButtonStyle(
        fixedSize: MaterialStatePropertyAll(Size(size, size))
      ),
      child: Icon(Icons.arrow_back, color: color,)
    );
  }

  Widget coloredStatusBar(Color? color){
    return Container(
      height: MediaQuery.of(context).viewPadding.top,
      color: (color == null)? Colors.amber : color,
    );
  }
}