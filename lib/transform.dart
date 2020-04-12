import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TransformMainView extends StatefulWidget {
  @override
  _TransformMainViewState createState() => _TransformMainViewState();
}

class _TransformMainViewState extends State<TransformMainView> with SingleTickerProviderStateMixin{
  Animation<double> transformAnimation;
  AnimationController transformAnimationController;

  final List<String> menus = [
    "Profile",
    "About",
    "Help",
    "Logout"
  ];

  final List<IconData> icons = [
    Icons.portrait,
    Icons.info,
    Icons.help,
    Icons.all_out
  ];

  bool animationSwitcher = false;

  void animationFunc() {
    transformAnimationController = new AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    transformAnimation = new Tween<double>(begin: 0.0, end: 0.4).animate(CurvedAnimation(parent: transformAnimationController, curve: animationSwitcher == false ? Curves.linearToEaseOut : Curves.linearToEaseOut));

    transformAnimation.addListener(() {
      setState(() {
        
      });
    });
  }

  @override
  void initState() { 
    super.initState();
    animationFunc();
  }
  
  @override
  void dispose() {
    transformAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      // appBar: AppBar(
      //   title: Text("Transform Widget"),
      // ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () {
          if(animationSwitcher == false) {
            transformAnimationController.forward();
            setState(() {
              animationSwitcher = true;
            });
          } else {
            transformAnimationController.reverse();
            setState(() {
              animationSwitcher = false;
            });
          }
        },
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(transformAnimation.value)
              ,
              alignment: FractionalOffset.centerRight,
              child: Center(
                child: AnimatedContainer(
                  padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 50.0),
                  duration: Duration(milliseconds: animationSwitcher == false ? 1000 : 400),
                  // curve: Curves.fastLinearToSlowEaseIn,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/img/photo.jpeg"),
                      fit: BoxFit.fitHeight
                    )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      Text("Transform Implementation", style: TextStyle(color: Colors.white, fontSize: 25.0),),
                      Text("Weird overlay drawer testing", style: TextStyle(color: Colors.white,),),
                      SizedBox(height: 20.0,),
                      Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book", style: TextStyle(color: Colors.white),),
                    ]
                  ),
                ),
              ),
            ),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 600),
              transitionBuilder: (child, animation) {
                final Animation _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(CurvedAnimation(parent: animation, curve: Curves.fastLinearToSlowEaseIn));
                return SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              child: animationSwitcher == true ? Container(
                padding: EdgeInsets.symmetric(vertical: 150.0, horizontal: 40.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.blue[600],
                      Colors.blue[600].withOpacity(0.4),
                    ]
                  )
                ),
                child: AnimationLimiter(
                  child: ListView.builder(
                    itemCount: menus.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: Duration(milliseconds: 700),
                        child: SlideAnimation(
                          horizontalOffset: -100,
                          child: FadeInAnimation(
                            child: ListTile(
                              leading: Icon(icons[index], color: Colors.white,),
                              title: Text(menus[index], style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ) : SizedBox()
            )
          ],
        ),
      ),
    );
  }
}