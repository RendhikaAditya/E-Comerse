import 'dart:ffi';

import 'package:ecomerse/page/utils/apiUrl.dart';
import 'package:ecomerse/page/utils/sesionManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../model/modeBase.dart';
import '../../../model/modelCart.dart';

class PageCart extends StatefulWidget {
  const PageCart({super.key});

  @override
  State<PageCart> createState() => _PageCartState();
}

class ProductData {
  String idProduct;
  int quantity;
  int price;

  ProductData(this.idProduct, this.quantity, this.price);
}

class _PageCartState extends State<PageCart> {
  int qty = 0;
  late Future<List<Datum>?> _futureCart;
  int totalPrice = 0;

  String formatRupiah(String angkaStr) {
    try {
      int angka = int.parse(angkaStr);
      String rupiahStr = "Rp " + angka.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
      return rupiahStr;
    } catch (e) {
      return "Input harus berupa string angka yang valid";
    }
  }

  Future<ModelBase?> addCart(String? idProduct, String q) async {
    try {
      http.Response res = await http.post(
        Uri.parse('${ApiUrl().baseUrl}chartsPOST.php'),
        body: {
          "id_user": sessionManager.idUser,
          "id_product": idProduct,
          "quantity": q,
        },
      );

      ModelBase data = modelBaseFromJson(res.body);
      print(data);

      if (data.value == 1) {
        setState(() {
          _futureCart = getCart();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${data.message}')),
        );
      }

      return data;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }

    return null;
  }

  Future<ModelBase?> addOrder() async {
    try {
      http.Response res = await http.post(
        Uri.parse('${ApiUrl().baseUrl}ordersPOST.php'),
        body: {
          "id_user": sessionManager.idUser,
        },
      );

      ModelBase data = modelBaseFromJson(res.body);
      print(data);

      if (data.value == 1) {
        setState(() {
          Navigator.pop(context);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${data.message}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${data.message}')),
        );
      }

      return data;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }

    return null;
  }

  Future<List<Datum>?> getCart() async {
    try {
      http.Response res = await http.get(Uri.parse('${ApiUrl().baseUrl}chartsGET.php?id=${sessionManager.idUser}'));

      var productResponse = modelCartFromJson(res.body);

      if (productResponse.isSuccess == true) {
        print("Data diperoleh :: ${productResponse.data}");
        List<Datum>? result = productResponse.data;
        updateTotalPrice(result);
        return result;
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

  void updateTotalPrice(List<Datum>? cartItems) {
    setState(() {
      totalPrice = cartItems?.fold(0, (sum, item) => sum! + (int.parse(item.price!) * int.parse(item.quantity!))) ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
    _futureCart = getCart();
    sessionManager.getSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: _futureCart,
              builder: (BuildContext context, AsyncSnapshot<List<Datum>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }
                if (snapshot.hasData && snapshot.data != null) {
                  List<Datum> cart = snapshot.data!;
                  return ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      Datum data = cart[index];
                      qty = int.parse(data.quantity.toString());
                      return Container(
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  child: Image.network("${ApiUrl().baseUrl}image/${data.foto}", width: 120, height: 120),
                                ),
                                SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${data.name}", style: TextStyle(fontWeight: FontWeight.bold)),
                                    Text("${data.kategori}"),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              qty = qty > 0 ? qty - 1 : 0;
                                              addCart(data.idProduct, "-1");
                                              data.quantity = qty.toString();
                                              updateTotalPrice(cart);
                                            });
                                          },
                                          child: Icon(CupertinoIcons.minus_circled, color: Colors.red),
                                        ),
                                        Text("  $qty  ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              qty = qty + 1;
                                              addCart(data.idProduct, "1");
                                              data.quantity = qty.toString();
                                              updateTotalPrice(cart);
                                            });
                                          },
                                          child: Icon(CupertinoIcons.plus_circle, color: Colors.green),
                                        ),
                                      ],
                                    ),
                                    Text("${formatRupiah(data.price.toString())}", style: TextStyle(fontWeight: FontWeight.bold)),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Divider(height: 1),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text("Data Tidak Ditemukan"));
                }
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total", style: TextStyle(fontSize: 16)),
                    Text("${formatRupiah(totalPrice.toString())}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    addOrder();
                  },
                  child: Text("Checkout", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: TextStyle(fontSize: 16),
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
