import 'dart:convert';

import 'package:ecomerse/model/modeBase.dart';
import 'package:ecomerse/model/modelMyFavorite.dart';
import 'package:ecomerse/page/utils/apiUrl.dart';
import 'package:ecomerse/widget/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../../../model/modelProduct.dart';
import '../../../model/modelMyFavorite.dart';
import '../../utils/sesionManager.dart';

class DetailProductPage extends StatefulWidget {
  final Datum product;
  const DetailProductPage({super.key, required this.product});

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  bool isFavorite = false;
  int qty = 1;
  bool isLoadingAddFavorite = false;
  bool isLoadingAddCart = false;
  String formatRupiah(String angkaStr) {
    try {
      int angka = int.parse(angkaStr);
      String rupiahStr = "Rp " + angka.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
      return rupiahStr;
    } catch (e) {
      return "Input harus berupa string angka yang valid";
    }
  }
  @override
  void initState() {
// TODO: implement initState
    super.initState();
    setState(() {
      sessionManager.getSession();
    });
    print(sessionManager.value);
    getMyFavorite();

  }

  Future<List<DatumF>?> getMyFavorite() async {
    try {
      http.Response res = await http.get(Uri.parse('${ApiUrl().baseUrl}myfavoriteGET.php'));

      var productResponse = modelFavoriteFromJson(res.body);

      if (productResponse.isSuccess == true) {
        print("Data diperoleh :: ${productResponse.data}");
        List<DatumF>? result = productResponse.data;

        if (result != null) {
          // Filter the result based on user ID
          List<DatumF> filteredResult = result.where((datum) => datum.idUser == sessionManager.idUser).toList();

          // Update the isFavorite state if any matching item is found
          if (filteredResult.isNotEmpty) {
            setState(() {
              isFavorite = true;
            });
          }

          // Print each filtered item for debugging
          for (var datum in filteredResult) {
            print("Filtered Item: ${datum.idProduct}");
          }

          return filteredResult;
        } else {
          print("Data kosong");
          return [];
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${productResponse.message}")),
        );
        return null;
      }
    } catch (e) {
      print("Terjadi kesalahan: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $e")),
      );
      return null;
    }
  }

  Future<ModelBase?> addFavorite() async {
    try {

      setState(() {
        isLoadingAddFavorite=true;
      });
      http.Response res = await http.post(
        Uri.parse('${ApiUrl().baseUrl}myfavoritePOST.php'),
        body: {
          "id_user": sessionManager.idUser,
          "id_product": widget.product.idProduct
        },
      );

      ModelBase data = modelBaseFromJson(res.body);
      print(data);

      if (data.value==1) {
        setState(() {
          isFavorite=isFavorite?false:true;
          isLoadingAddFavorite= false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${data.message}')),
        );

      } else {
        setState(() {
          isLoadingAddFavorite= false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${data.message}')),
        );
      }

      return data;
    } catch (e) {
      setState(() {
        isLoadingAddFavorite= false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );

    }

    return null;
  }

  Future<ModelBase?> addCart() async {
    try {

      setState(() {
        isLoadingAddCart=true;
      });
      http.Response res = await http.post(
        Uri.parse('${ApiUrl().baseUrl}chartsPOST.php'),
        body: {
          "id_user": sessionManager.idUser,
          "id_product": widget.product.idProduct,
          "quantity": qty.toString(),
        },
      );

      ModelBase data = modelBaseFromJson(res.body);
      print(data);

      if (data.value==1) {
        setState(() {
          isLoadingAddCart= false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${data.message}')),
        );

      } else {
        setState(() {
          isLoadingAddCart= false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${data.message}')),
        );
      }

      return data;
    } catch (e) {
      setState(() {
        isLoadingAddCart= false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );

    }

    return null;
  }


  @override
  Widget build(BuildContext context) {
    final Datum product = widget.product;
    return Scaffold(
      appBar: AppBar(
        title: Text("${product.name}"),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Image.network(
                  "${ApiUrl().baseUrl}image/${product.foto}",
                  fit: BoxFit.cover,
                  height: 350,
                  width: double.infinity,
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${product.name}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  GestureDetector(
                    onTap: (){
                      addFavorite();
                    },
                    child: isLoadingAddFavorite?CircularProgressIndicator(color: Colors.blue,):Icon(Icons.star, color: isFavorite?Colors.orange:Colors.grey,),
                  )
                ],
              ),
              Text(product.kategori.toString()),
              Text("${formatRupiah(product.price.toString())}", style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        qty=qty>1?qty-1:1;
                      });
                    },
                    child: Icon(CupertinoIcons.minus_circled,color: Colors.red,size: 42,),
                  ),
                  Text("  $qty  ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        qty=qty<int.parse(product.stock.toString())?qty+1:qty;
                      });
                    },
                    child: Icon(CupertinoIcons.plus_circle, color: Colors.green,size: 42,),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              CustomButton(text: "Add To Cart",onPressed: (){addCart();},),
              SizedBox(height: 10,),
              Text(product.description.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
