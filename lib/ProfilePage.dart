import 'package:flutter/material.dart';
import 'package:my_cst2335_labs/DataRepository.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => OtherProfilePage();
}

String? firstName;
String? lastName;
String? email;
String? phone;

class OtherProfilePage extends State<ProfilePage> {
  TextEditingController _controllerFirstName = TextEditingController();
  TextEditingController _controllerLastName = TextEditingController();
  TextEditingController _controllerPhone = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();

  Future<void> _phoneLauncher() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: _controllerPhone.text);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      showDialog<String>(
        context: context,
        builder:
            (BuildContext context) => AlertDialog(
              title: const Text('Unsupported Feature'),
              content: Text('Cannot make phone calls on this device'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('CANCEL'),
                ),
              ],
            ),
      );
    }
  }

  Future<void> _smsLauncher() async {
    final Uri smsUri = Uri(scheme: 'sms', path: _controllerPhone.text);
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      showDialog<String>(
        context: context,
        builder:
            (BuildContext context) => AlertDialog(
          title: const Text('Unsupported Feature'),
          content: Text('Cannot use sms on this device'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('CANCEL'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _emailLauncher() async {
    final Uri emailUri = Uri(scheme: 'mailto', path: _controllerEmail.text);
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      showDialog<String>(
        context: context,
        builder:
            (BuildContext context) => AlertDialog(
          title: const Text('Unsupported Feature'),
          content: Text('Cannot use email on this device'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('CANCEL'),
            ),
          ],
        ),
      );
    }
  }

  void initState() {
    super.initState();
    _controllerFirstName = TextEditingController(
      text: DataRepository.firstName,
    );
    _controllerLastName = TextEditingController(text: DataRepository.lastName);
    _controllerEmail = TextEditingController(text: DataRepository.email);
    _controllerPhone = TextEditingController(text: DataRepository.phone);

    DataRepository.firstName = _controllerFirstName.text;
    DataRepository.saveData();

    DataRepository.lastName = _controllerLastName.text;
    DataRepository.saveData();

    DataRepository.phone = _controllerPhone.text;
    DataRepository.saveData();

    DataRepository.email = _controllerEmail.text;
    DataRepository.saveData();
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
            Text("Welcome back ${DataRepository.login}"),
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
                  onPressed: _phoneLauncher,
                  child: Icon(Icons.phone),
                ),
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
                ElevatedButton(
                  onPressed: _emailLauncher,
                  child: Icon(Icons.email),
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await DataRepository.saveData();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Data has been saved to EncryptedSharedPreferences",
                            ),
                          ),
                        );
                      },
                      child: Text("CLICK TO SAVE"),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ); //Use a Scaffold to layout a page with an AppBar and main body region
  }
}
