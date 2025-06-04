import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => OtherProfilePage();
}

class OtherProfilePage extends State<ProfilePage> {

  String? firstName;
  String? lastName;
  int? phoneNumber;
  String? email;

  TextEditingController _controllerFirstName = TextEditingController();
  TextEditingController _controllerLastName = TextEditingController();
  TextEditingController _controllerPhone = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();

  void initState() {
    super.initState();
    _controllerFirstName = TextEditingController();
    _controllerLastName = TextEditingController();
    _controllerPhone = TextEditingController();
    _controllerEmail = TextEditingController();
  }

  @override
  void dispose() {
    _controllerFirstName.dispose();
    _controllerLastName.dispose();
    _controllerPhone.dispose();
    _controllerEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ProfilePage")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(controller: _controllerFirstName,
              decoration: InputDecoration(
                  hintText: "First Name",
                  border: OutlineInputBorder()
              ),
            ),
            TextField(controller: _controllerLastName,
              decoration: InputDecoration(
                  hintText: "Last Name",
                  border: OutlineInputBorder()
              ),
            ),
            TextField(controller: _controllerPhone,
              decoration: InputDecoration(
                  hintText: "Phone",
                  border: OutlineInputBorder()
              ),
            ),
            TextField(controller: _controllerEmail,
                decoration: InputDecoration(
                  hintText: "Email",
                    border: OutlineInputBorder()
                ),
            ),
          ],
        ),
      ),
    ); //Use a Scaffold to layout a page with an AppBar and main body region
  }
}
