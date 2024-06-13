import 'package:ecomerse/page/auth/loginPage.dart';
import 'package:ecomerse/page/utils/sesionManager.dart';
import 'package:flutter/material.dart';
import '../../../model/modeBase.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_text_field.dart';
import '../../../widget/password_text_field.dart';
import 'package:http/http.dart' as http;

import '../../utils/apiUrl.dart';


class EditProfilePage extends StatefulWidget {
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController txtName = TextEditingController(text: sessionManager.fullname);
  TextEditingController txtAlamat = TextEditingController(text: sessionManager.alamat);
  TextEditingController txtNohp = TextEditingController(text: sessionManager.nohp);
  TextEditingController txtEmail = TextEditingController(text: sessionManager.email);
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
          "id_user": sessionManager.idUser.toString(),
          "fullname": txtName.text,
          "email": txtEmail.text,
          "phone": txtNohp.text,
          "address": txtAlamat.text,
        };
        print(requestBody);

        // Determine URL based on sessionManager.idUser
        Uri url = Uri.parse('${ApiUrl().baseUrl}userUPDATE.php');

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
          var id = sessionManager.idUser;
          sessionManager.saveSession(
            true,
            id.toString(),
            txtEmail.text.toString(),
            txtName.text.toString(),
            txtAlamat.text.toString(),
            txtNohp.text.toString(),
            data.message.toString(),
            "Customer",
          );
          sessionManager.getSession();
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
      body: Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile"),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(top: 50.0, left: 16, right: 16, bottom: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  CustomButton(
                    text: "Update Profile",
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => VerificationPage()),
                      // );
                      pushData();
                    },
                  ),
                  SizedBox(height: 20),
                 ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
