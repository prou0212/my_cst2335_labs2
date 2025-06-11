import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => OtherProfilePage();
}

class OtherProfilePage extends State<ProfilePage> {
  TextEditingController _controllerFirstName = TextEditingController();
  TextEditingController _controllerLastName = TextEditingController();
  TextEditingController _controllerPhone = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();

  // final UserRepository _repository = UserRepository();

  Future<void> _phoneLauncher() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: _controllerPhone.text);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Cannot make phone calls from this device")),
      );
    }
  }

  Future<void> _smsLauncher() async {
    final Uri smsUri = Uri(scheme: 'sms', path: _controllerPhone.text);
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Cannot make sms from this device")),
      );
    }
  }

  Future<void> _emailLauncher() async {
    final Uri emailUri = Uri(scheme: 'mailto', path: _controllerEmail.text);
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Cannot email on this device")));
    }
  }

  void initState() {
    super.initState();
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
            //Joking purposes
            Text("Give me your Personal Information"),
            Text("This is NOT a Scam"),
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
                ElevatedButton(onPressed: _phoneLauncher, child: Icon(Icons.phone)),
                SizedBox(width: 8), // Space between buttons
                ElevatedButton(onPressed: _smsLauncher, child: Icon(Icons.sms)),
              ],
            ),
            SizedBox(width: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controllerEmail,
                    decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                ElevatedButton(onPressed: _emailLauncher, child: Icon(Icons.email)),
              ],
            ),
          ],
        ),
      ),
    ); //Use a Scaffold to layout a page with an AppBar and main body region
  }
}
