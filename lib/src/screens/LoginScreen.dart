import 'package:flutter/material.dart';
import 'package:instagram_clone/src/screens/insta_home.dart';
import "dart:convert";
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<Map<String, dynamic>> loadAsset() async {
    final res = await http.get('https://www.ufavors.com/InstagramDTs.json');
    return jsonDecode(res.body);
  }

  Map<String, dynamic> response;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/insta_logo.png'),
                        fit: BoxFit.fitWidth)),
              ),
              TextField(
                cursorColor: Colors.grey,
                textAlign: TextAlign.start,
                // style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                    fillColor: Colors.grey[200],
                    filled: true,
                    contentPadding: EdgeInsets.all(15),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    hintText: "Phone number, email or username"),
              ),
              RaisedButton(
                onPressed: () async {
                  try {
                    Dialogs.showLoadingDialog(
                        context, _keyLoader); //invoking login
                    response = await loadAsset();
                    Navigator.of(_keyLoader.currentContext, rootNavigator: true)
                        .pop(); //close the dialoge
                    Navigator.pushReplacementNamed(context, "/home");
                  } catch (error) {
                    print(error);
                  }

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InstaHome(response)));
                  // Future.delayed(Duration(seconds: 2), () {
                  // });
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Log In',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                color: Color(0xFF156AE6),
              ),
              GestureDetector(
                child: Container(
                  width: 250.0,
                  height: 50.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/social-facebook.png'),
                                fit: BoxFit.fill)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Log in with Facebook',
                            style: TextStyle(
                                color: Color(0xFF156AE6),
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
                onTap: () {},
              ),
              // Column(children: messages)
            ],
          ),
        ),
      ),
    );
  }
}

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Signing in to account... Please Wait!",
                          style: TextStyle(color: Colors.blueAccent),
                        )
                      ]),
                    )
                  ]));
        });
  }
}
