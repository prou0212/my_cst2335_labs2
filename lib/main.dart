import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

void main() {
  runApp(const MyApp());
}
//I'm Jesse
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

  String? enterLogin;
  String? enterPassword;
  TextEditingController _controllerLogin = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  final EncryptedSharedPreferences prefs  = EncryptedSharedPreferences();

  Future <void> saveData() async {
    String enterLogin = _controllerLogin.text;
    String enterPassword = _controllerPassword.text;
 //   SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString("savedLogin", enterLogin);
    await prefs.setString("savedPassword", enterPassword);

   String? verifyLogin = await prefs.getString("savedLogin");
   String? verifyPassword = await prefs.getString("savedPassword");
    if (verifyLogin.isNotEmpty && verifyPassword.isNotEmpty) {
      print("Successfully saved both login and password!");
      print("Login: $verifyLogin");
      print("Password $verifyPassword");
    }
    else {
      print("Error: Unsuccessful save");
    }
  }

  void onPressed() {
    String password = _controllerPassword.text;
  }

  Future<void> loadSavedData() async {
    //EncryptedSharedPreferences prefs = await EncryptedSharedPreferences.getInstance();

    String? savedLogin = await prefs.getString("savedLogin");
    String? savedPassword = await prefs.getString("savedPassword");

    if (savedLogin.isNotEmpty && savedPassword.isNotEmpty) {
      setState(() {
        _controllerLogin.text = savedLogin;
        _controllerPassword.text = savedPassword;
      });
      //savedLogin = _controllerLogin.text;  // Login appears in the TextField
      //print("Loaded login: $savedLogin");

      //savedPassword = _controllerPassword.text;  // Password appears in the TextField
      //print("Loaded password: $savedPassword");
      //WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login data loaded and filled in TextFields!")),
        );
    //  }
    //);
      print("Both login and password loaded into TextFields");
    } else {
      print("No saved data found");
    }
  }

  Future<void> removeData() async {
   // SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("savedLogin");
    await prefs.remove("savedPassword");
  }

  @override
  void initState() {
    super.initState();
    _controllerLogin = TextEditingController();
    _controllerPassword = TextEditingController();
    loadSavedData();
  }

  @override
  void dispose() {
    _controllerLogin.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

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
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(controller: _controllerLogin,
              decoration: InputDecoration(
                  hintText: "Login",
                  border: OutlineInputBorder()
              ),
            ),
            TextField(controller: _controllerPassword,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder()
                )
            ),
            ElevatedButton(
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Save Login & Password'),
                    content: const Text('Would you like to save your login and password'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await removeData();
                        },
                        child: const Text('CANCEL'),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await saveData();

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login and Password successfully saved")));
                          },
                          child: const Text("SAVE"),
                      ),
                    ],
                  ),
                );
              },
              child: const Text("Click Me"),
            ),
          ],

        ),

    ),
    ); // This trailing comma makes auto-formatting nicer for build methods.

  }
}
