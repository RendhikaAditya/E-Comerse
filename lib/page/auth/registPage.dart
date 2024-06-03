import 'package:ecomerse/page/auth/loginPage.dart';
import 'package:ecomerse/page/auth/verificationPage.dart';
import 'package:flutter/material.dart';
import '../../model/modeBase.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/password_text_field.dart';
import 'package:http/http.dart' as http;

import '../utils/apiUrl.dart';
import '../utils/sesionManager.dart';


class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtAlamat = TextEditingController();
  TextEditingController txtNohp = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;


  Future<ModelBase?> pushData() async {
      setState(() {
        isLoading = true;
      });
      try {
        http.Response res;

        // Prepare request body
        Map<String, String> requestBody = {
          "fullname": txtName.text,
          "email": txtEmail.text,
          "phone": txtNohp.text,
          "address": txtAlamat.text,
          "password": txtPassword.text,
        };
        print(requestBody);

        // Determine URL based on sessionManager.idUser
        Uri url = Uri.parse('${ApiUrl().baseUrl}register.php');

        // Perform POST request
        res = await http.post(url, body: requestBody);

        print("ISI RES ::: \n\n ${res.body} \n\n");

        // Decode response body
        ModelBase data = modelBaseFromJson(res.body);



        if (data.value==1) {
          // Show appropriate Snackbar message based on response
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data.message.toString()),
          ));
          setState(() {
            isLoading = false;
            Navigator.pop(context);
          });
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error : ${e.toString()}")),
        );
      }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F9FF),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF5F9FF),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 50.0, left: 16, right: 16, bottom: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Getting Started.!",
                        style: TextStyle(
                          fontFamily: 'Jost',
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Create an Account to Continue Shopping",
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
                  hintText: "Fullname",
                  controller: txtName,
                  icon: Icons.person_2_outlined,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: "Alamat",
                  controller: txtAlamat,
                  icon: Icons.location_history_outlined,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: "Nohp",
                  controller: txtNohp,
                  icon: Icons.phone_android,
                ),
                SizedBox(height: 20),
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
                  text: "Sign Up",
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => VerificationPage()),
                    // );
                    pushData();
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
                        "Already have an Account?",
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
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        },
                        child: Text(
                          "SIGN IN",
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
      ),
    );
  }
}
