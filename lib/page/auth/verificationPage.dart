import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../widget/custom_button.dart';
import '../../widget/pin_input.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  List<String> pin = ["", "", "", "", ""];

  TextEditingController pinController1 = TextEditingController();
  TextEditingController pinController2 = TextEditingController();
  TextEditingController pinController3 = TextEditingController();
  TextEditingController pinController4 = TextEditingController();
  TextEditingController pinController5 = TextEditingController();

  int _countdown = 60;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
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
                          SizedBox(width: 8),
                          buildPinInput(context, pinController5, false),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    GestureDetector(
                      onTap: (){
                        if(_countdown==0){
                          _countdown=_countdown+60;
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
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePassword()));
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
