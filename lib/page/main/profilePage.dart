import 'package:ecomerse/page/auth/loginPage.dart';
import 'package:ecomerse/page/main/profile/detailProfilePage.dart';
import 'package:ecomerse/page/main/profile/termConditionPage.dart';
import 'package:ecomerse/page/utils/sesionManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widget/widget_profile_menu.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Jost',
            fontSize: 21,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
              width: double.infinity,
              child: Column(
                children:[
                  Container(
                    width: 120,
                    height: 120,
                    child: Center(
                      child: Image.asset('image/ic_profile.png'),
                    ),
                  ),
                  Text(
                    "${sessionManager.fullname}",
                    style: TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2, // Atur maksimum 2 baris
                    overflow: TextOverflow
                        .ellipsis, // Tambahkan elipsis jika melebihi 2 baris
                  ),
                  Text(
                    "${sessionManager.email}",
                    style: TextStyle(
                        fontFamily: 'Jost',
                        fontSize: 14,
                        color: Colors.grey),
                    maxLines: 2, // Atur maksimum 2 baris
                    overflow: TextOverflow
                        .ellipsis, // Tambahkan elipsis jika melebihi 2 baris
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 1),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(15), )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        WidgetProfileMenu(
                            title: "Profile Info",
                            navigatorPush: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailProfile()),
                              );
                            },
                            icon: Icons.perm_identity_rounded),
                        SizedBox(height: 10,),
                        Divider(height: 1,),
                        WidgetProfileMenu(
                            title: "Legal & Policy",
                            navigatorPush: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TermConditionPage()),
                              );
                            },
                            icon: Icons.privacy_tip_outlined),
                        SizedBox(height: 10,),
                        Divider(height: 1,),
                        WidgetProfileMenu(
                            title: "Logout",
                            navigatorPush: (){
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LoginPage()),(route) => false,
                              );
                            },
                            icon: Icons.logout),
                      ],
                    ),
                  ),

                ]

              )),

        ],
      ),
    );
  }
}
