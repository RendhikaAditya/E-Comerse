import 'package:ecomerse/page/main/profile/editProfilePage.dart';
import 'package:ecomerse/page/utils/sesionManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DetailProfile extends StatefulWidget {
  const DetailProfile({super.key});
  @override
  State<DetailProfile> createState() => _DetailProfileState();
}

class _DetailProfileState extends State<DetailProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text(
          'Profile Info',
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
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 1),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(15), )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Alamat", style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(sessionManager.alamat.toString()),
                          SizedBox(height: 16,),
                          Text("Nomor Hp", style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(sessionManager.nohp.toString()),
                        ],
                      ),
                    ),
                    ElevatedButton(onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditProfilePage()), // Ganti dengan halaman yang sesuai
                      );
                    }, child: Text("Edit Profile"))
                  ]

              )),

        ],
      ),
    );
  }
}
