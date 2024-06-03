import 'package:ecomerse/page/auth/registPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/modelUser.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/password_text_field.dart';
import '../main/navigationPage.dart';
import '../utils/apiUrl.dart';
import '../utils/sesionManager.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool? isLoading;

  Future<ModelUser?> loginUser() async {
    try {
      setState(() {
        isLoading = true;
      });

      http.Response res = await http.post(
        Uri.parse('${ApiUrl().baseUrl}login.php'),
        body: {
          "email": txtEmail.text,
          "password": txtPassword.text
        },
      );

      ModelUser data = modelUserFromJson(res.body);
      print(data);

      if (data.value==1) {
        sessionManager.saveSession(
          true,
          data.idUser.toString(),
          data.email.toString(),
          data.fullname.toString(),
          data.address.toString(),
          data.phone.toString(),
          data.message.toString(),
          data.role.toString(),
        );
        sessionManager.getSession();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${data.message}')),
        );



        setState(() {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => PageBottomBar()),
                (route) => false,
          );
          isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${data.message}')),
        );

        setState(() {
          isLoading = false;
        });
      }

      return data;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
      setState(() {
        isLoading = false;
      });
    }

    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF5F9FF),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 52.0, left: 16,right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login Account",
                      style: TextStyle(
                        fontFamily: 'Jost',
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Please Login with registered account",
                      style: TextStyle(
                        fontFamily: 'Mulish',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              CustomTextField(
                hintText: "Email",
                controller: txtEmail,
                icon: Icons.mail_outline,
              ),
              SizedBox(height: 20),
              PasswordTextField(
                hintText: "Password",
                controller: txtPassword,
              ),
              SizedBox(height: 20),
              CustomButton(
                text: "Sign In",
                onPressed: () {
                  // Navigator.pushAndRemoveUntil(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => PageBottomBar()),
                  //         (route) => false//nanti ubah ke page class yang sebenarnya
                  // );
                  loginUser();
                },
              ),
              SizedBox(height: 20),
              // "Or Continue With" di tengah
              Center(
                child: Text(
                  "Or Continue With",
                  style: TextStyle(
                    fontFamily: 'Mulish',
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF545454),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    // Implement your action here for the Google button
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey), // Stroke color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'image/google.png',
                          height: 42,
                          width: 42,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Sign in with Google',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // "Don’t have an Account? SIGN UP" menjadi tengah
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Account? ",
                      style: TextStyle(
                        fontFamily: 'Mulish',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF545454),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterPage()),
                        );
                      },
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
