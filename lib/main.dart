import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:my_cst2335_labs/ProfilePage.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? enterLogin;
  String? enterPassword;
  TextEditingController _controllerLogin = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  final EncryptedSharedPreferences prefs = EncryptedSharedPreferences();

  Future<void> saveData() async {
    String enterLogin = _controllerLogin.text;
    String enterPassword = _controllerPassword.text;

    await prefs.setString("savedLogin", enterLogin);
    await prefs.setString("savedPassword", enterPassword);

    String? verifyLogin = await prefs.getString("savedLogin");
    String? verifyPassword = await prefs.getString("savedPassword");
    if (verifyLogin.isNotEmpty && verifyPassword.isNotEmpty) {
      print("Successfully saved both login and password!");
      print("Login: $verifyLogin");
      print("Password $verifyPassword");
    } else {
      print("Error: Unsuccessful save");
    }
  }

  Future<void> loadSavedData() async {
    String? savedLogin = await prefs.getString("savedLogin");
    String? savedPassword = await prefs.getString("savedPassword");

    if (savedLogin.isNotEmpty && savedPassword.isNotEmpty) {
      setState(() {
        _controllerLogin.text = savedLogin;
        _controllerPassword.text = savedPassword;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login data loaded and filled in TextFields!")),
      );
      print("Both login and password loaded into TextFields");
    } else {
      print("No saved data found");
    }
  }

  Future<void> removeData() async {
    await prefs.remove("savedLogin");
    await prefs.remove("savedPassword");
  }

  Future<void> loginUser() async {
    String enterLogin = _controllerLogin.text;
    String enterPassword = _controllerPassword.text;

    if (enterLogin.isNotEmpty && enterPassword.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Welcome Back"), duration: Duration(seconds: 3)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a login and password")),
      );
    }
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controllerLogin,
              decoration: InputDecoration(
                hintText: "Login",
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: _controllerPassword,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder:
                      (BuildContext context) => AlertDialog(
                        title: const Text('Save Login & Password'),
                        content: const Text(
                          'Would you like to save your login and password',
                        ),
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

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Login and Password successfully saved",
                                  ),
                                ),
                              );
                            },
                            child: const Text("SAVE"),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              await loginUser();
                            },
                            child: const Text("Login"),
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
