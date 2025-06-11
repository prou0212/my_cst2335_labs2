import 'package:flutter/material.dart';
import 'package:my_cst2335_labs/DataRepository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => OtherProfilePage();
}

String? firstName;
String? lastName;
String? email;
String? phone;

final EncryptedSharedPreferences prefs = EncryptedSharedPreferences();

class OtherProfilePage extends State<ProfilePage> {
  late TextEditingController _controllerFirstName;
  late TextEditingController _controllerLastName;
  late TextEditingController _controllerPhone;
  late TextEditingController _controllerEmail;

  Future<void> save() async {
    String enterFirstName = _controllerFirstName.text;
    String enterLastName = _controllerLastName.text;
    String enterPhone = _controllerPhone.text;
    String enterEmail = _controllerEmail.text;

    await prefs.setString("savedFirstName", enterFirstName);
    await prefs.setString("savedLastName", enterLastName);
    await prefs.setString("savedPhone", enterPhone);
    await prefs.setString("savedEmail", enterEmail);

  }

  Future<void> load() async {
    String? first = await prefs.getString("savedFirstName");
    String? last = await prefs.getString("savedLastName");
    String? phone = await prefs.getString("savedPhone");
    String? email = await prefs.getString("savedEmail");

    setState(() {
      _controllerFirstName.text = first ?? '';
      _controllerLastName.text = last ?? '';
      _controllerPhone.text = phone ?? '';
      _controllerEmail.text = email ?? '';
    });

    print("Success");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Data loaded from EncryptedSharedPreferences")),
    );
  }
  ///TODO: FINISHED - LAUNCHES/ASKS FOR THE PHONE APPLICATION
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

  ///
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


@override
void initState() {
  super.initState();
  _controllerFirstName = TextEditingController();
  _controllerLastName = TextEditingController();
  _controllerPhone = TextEditingController();
  _controllerEmail = TextEditingController();
  load();
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
            Text("Welcome back ${DataRepository.login.toString()}"),
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
                        await save();
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
