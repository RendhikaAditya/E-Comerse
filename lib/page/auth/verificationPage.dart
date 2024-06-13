import 'dart:async';

import 'package:ecomerse/page/auth/loginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../model/modeBase.dart';
import '../../widget/custom_button.dart';
import '../../widget/pin_input.dart';
import 'package:http/http.dart' as http;

import '../utils/apiUrl.dart';

class VerificationPage extends StatefulWidget {
  final String email;
  const VerificationPage({super.key, required this.email});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  List<String> pin = ["", "", "", "", ""];

  TextEditingController pinController1 = TextEditingController();
  TextEditingController pinController2 = TextEditingController();
  TextEditingController pinController3 = TextEditingController();
  TextEditingController pinController4 = TextEditingController();

  int _countdown = 60;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    sendEmail();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (_countdown == 0) {
        _timer.cancel();
      } else {
        setState(() {
          _countdown--;
        });
      }
    });
  }

  Future<ModelBase?> sendEmail() async {
    try {
      http.Response res;
      Map<String, String> requestBody = {
        "email": widget.email,
      };
      Uri url = Uri.parse('${ApiUrl().baseUrl}send_verification_code.php');
      res = await http.post(url, body: requestBody);
      print("ISI RES ::: \n\n ${res.body} \n\n");
      ModelBase data = modelBaseFromJson(res.body);
      if (data.value==1) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data.message.toString()),
            ));
        setState(() {

        });
      }
    } catch (e) {
      setState(() {
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error : ${e.toString()}")),
      );
    }
  }

  Future<ModelBase?> verifEmail() async {
    try {
      http.Response res;
      Map<String, String> requestBody = {
        "email": widget.email,
        "verification_code": "${pinController1.text}${pinController2.text}${pinController3.text}${pinController4.text}"
      };
      Uri url = Uri.parse('${ApiUrl().baseUrl}verified_code.php');
      res = await http.post(url, body: requestBody);
      print("ISI RES ::: \n\n ${res.body} \n\n");
      ModelBase data = modelBaseFromJson(res.body);
      if (data.value==1) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data.message.toString()),
            ));
        setState(() {

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false,
          );
        });
      }
    } catch (e) {
      setState(() {
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error : ${e.toString()}")),
      );
    }
  }


  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Row(
          children: [
            Text(
              'Verification Account',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
        ),
        child: Column(
          children: [

            Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                '',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            Image.asset(
              'image/ic_verify.png',
              height: 142,
              width: 142,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              child: Column(
                  children: [
                    Text(
                      "Code has been Send to ( +1 ) ***-***-*529",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.all(10),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildPinInput(context, pinController1, false),
                          SizedBox(width: 8),
                          buildPinInput(context, pinController2, false),
                          SizedBox(width: 8),
                          buildPinInput(context, pinController3, false),
                          SizedBox(width: 8),
                          buildPinInput(context, pinController4, false),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    GestureDetector(
                      onTap: (){
                        if(_countdown==0){
                          _countdown=_countdown+60;
                          sendEmail();
                        }
                      },
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: _countdown!=0?'Resend Code in ':'',
                            ),
                            TextSpan(
                              text: _countdown!=0?'$_countdown':'Resend Code',
                              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold), // Warna biru untuk angka
                            ),
                            TextSpan(
                              text: _countdown!=0?'s':'',
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    CustomButton(
                      text: 'Verify',
                      onPressed: () {
                        verifEmail();
                      },
                    ),

                  ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
