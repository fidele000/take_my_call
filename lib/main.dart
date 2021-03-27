import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin{
  AnimationController _controller;
  Animation animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    animation=CurvedAnimation(parent: _controller,curve: Curves.easeInOutCirc);

    _controller.forward();
    animation.addStatusListener((status) {
      if(status==AnimationStatus.completed){
        _controller.reverse(from: 0.9);
      }
      else if(status==AnimationStatus.dismissed){
        _controller.forward();
      }
    });

    _controller.addListener(() {
      setState(() {});
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueAccent.withOpacity(animation.value),
        body: Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                Center(child: Text('Ringing...',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),),
                Container(
                  padding: EdgeInsets.all(animation.value*10),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(60)),
                  ),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/image.jpg'),
                    radius: 50,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(child:Icon(Icons.phone,size: 30,color: Colors.white,),radius: 30,backgroundColor: Colors.green,),
                    SizedBox(width: 50,),
                    CircleAvatar(child:Icon(Icons.phone_disabled,size: 30,color: Colors.white,),radius: 30,backgroundColor: Colors.redAccent,),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("About",style: TextStyle(fontSize: 15,color: Colors.white),),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

