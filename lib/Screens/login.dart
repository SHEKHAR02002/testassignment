import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:testassignment/API/login.dart';
import 'package:testassignment/Screens/Theme/theme.dart';
import 'package:testassignment/Screens/home.dart';

class LoginScrenn extends ConsumerStatefulWidget {
  const LoginScrenn({super.key});

  @override
  ConsumerState<LoginScrenn> createState() => _LoginScrennState();
}

class _LoginScrennState extends ConsumerState<LoginScrenn> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                "assets/login.svg",
                width: width,
                height: height / 2.2,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Login",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Enter Your Username And PassWord",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                decoration: shadowdecoration,
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "Username",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    labelStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    border: InputBorder.none,
                  ),
                  controller: username,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: shadowdecoration,
                child: TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Password",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    labelStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    border: InputBorder.none,
                  ),
                  controller: password,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Note:For testing Username and Password is mor_2314 & 83r5^_",
                style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ElevatedButton(
            onPressed: () async {
              if (username.text != "" && password.text != "") {
                int responsecode = await postData(
                    username: username.text, password: password.text);
                if (responsecode == 200) {
                  Fluttertoast.showToast(
                      msg: "Login success",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                } else {
                  Fluttertoast.showToast(
                      msg: responsecode.toString(),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              } else {
                Fluttertoast.showToast(
                    msg: "Fill All Fields",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Colors.blueGrey,
                minimumSize: Size(width, 50)),
            child: const Text(
              "Continue",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
            )),
      ),
    );
  }
}
