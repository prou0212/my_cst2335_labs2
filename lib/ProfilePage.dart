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

//   Future <void> _launchPhone async {
//     final phoneNumber = _controllerPhone.text;
//     if(phoneNumber.isEmpty) {
//       Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
//       if(await canLaunchUrl(phoneUri)) {
//         await launchUrl(phoneUri);
//   }
//   }
// }

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
            TextField(
              controller: _controllerFirstName,
              decoration: InputDecoration(
                hintText: "First Name",
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: _controllerLastName,
              decoration: InputDecoration(
                hintText: "Last Name",
                border: OutlineInputBorder(),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controllerPhone,
                    decoration: InputDecoration(
                      hintText: "Phone",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8), // Space between TextField and buttons
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(Icons.phone),
                ),
                SizedBox(width: 8), // Space between buttons
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(Icons.sms),
                ),
              ],
            ),
            TextField(
              controller: _controllerEmail,
              decoration: InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    ); //Use a Scaffold to layout a page with an AppBar and main body region
  }
}
