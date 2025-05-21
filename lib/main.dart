import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center (
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text("Browse Categories", style: TextStyle(fontSize: 30.0)),
          Text("Not sure about exactly which recipe you're looking for? Do a search, dive into our popular categories", style: TextStyle(fontSize: 15)),
              Text("By Meat", style: TextStyle(fontSize: 30.0)),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Stack(alignment: AlignmentDirectional.center,
              children: [ CircleAvatar(backgroundImage: AssetImage('images/beef.png'), radius:75),
                Text("Beef", style: TextStyle(fontSize: 20.0,color:Colors.white,),)
              ]),
          Stack(alignment: AlignmentDirectional.center,
            children: [ CircleAvatar(backgroundImage: AssetImage('images/chicken.png'), radius:75),
              Text("Chicken", style: TextStyle(fontSize: 20.0, color:Colors.white),)
            ]),
          Stack(alignment: AlignmentDirectional.center,
              children: [ CircleAvatar(backgroundImage: AssetImage('images/pork.png'), radius:75),
                Text("Pork", style: TextStyle(fontSize: 20.0, color:Colors.white),)
              ]),
          Stack(alignment: AlignmentDirectional.center,
              children: [ CircleAvatar(backgroundImage: AssetImage('images/seafood.png'), radius:75),
                Text("Seafood", style: TextStyle(fontSize: 20.0, color:Colors.white),)
              ]),
        ],),
              Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("By Course", style: TextStyle(fontSize: 30.0)
                )],),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Stack(alignment: AlignmentDirectional.center,
                    children: [ CircleAvatar(backgroundImage: AssetImage('images/main-dishes.png'), radius:75),
                      Text("Main Dishes", style: TextStyle(fontSize: 20.0,color:Colors.white,),)
                    ]),
                Stack(alignment: AlignmentDirectional.center,
                    children: [ CircleAvatar(backgroundImage: AssetImage('images/salads.png'), radius:75),
                      Text("Salads", style: TextStyle(fontSize: 20.0,color:Colors.white,),)
                    ]),
                Stack(alignment: AlignmentDirectional.center,
                    children: [ CircleAvatar(backgroundImage: AssetImage('images/side-dishes.png'), radius:75),
                      Text("Side Dishes", style: TextStyle(fontSize: 20.0,color:Colors.white,),)
                    ]),
                Stack(alignment: AlignmentDirectional.center,
                    children: [ CircleAvatar(backgroundImage: AssetImage('images/crock-pot.png'), radius:75),
                      Text("Crock Pot", style: TextStyle(fontSize: 20.0,color:Colors.white,),)
                    ]),
              ],),
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("By Dessert", style: TextStyle(fontSize: 30.0)
            )],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            CircleAvatar(backgroundImage: AssetImage('images/ice-cream.jpg'), radius:75),
            CircleAvatar(backgroundImage: AssetImage('images/brownies.jpeg'), radius:75),
            CircleAvatar(backgroundImage: AssetImage('images/pies.jpg'), radius:75),
            CircleAvatar(backgroundImage: AssetImage('images/cookies.jpg'), radius:75),
          ],),
        ]),
      ));
  }
}
