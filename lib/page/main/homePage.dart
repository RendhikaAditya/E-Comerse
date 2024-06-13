import 'package:ecomerse/page/main/order/cartPage.dart';
import 'package:ecomerse/page/main/product/detailProductPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../model/modelProduct.dart';
import 'package:http/http.dart' as http;
import '../utils/apiUrl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Datum>?> _futureProductClothing;
  late Future<List<Datum>?> _futureProductAccessories;
  late Future<List<Datum>?> _futureProductOuter;

  List<Datum>? _filterResult;

  @override
  void initState() {
    super.initState();
    _futureProductClothing = getProduct("Clothing");
      _futureProductAccessories = getProduct("Accessories");
    _futureProductOuter = getProduct("Footwear");
  }

  String formatRupiah(String angkaStr) {
    try {
      int angka = int.parse(angkaStr);
      String rupiahStr = "Rp " + angka.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
      return rupiahStr;
    } catch (e) {
      return "Input harus berupa string angka yang valid";
    }
  }

  Future<List<Datum>?> getProduct(String q) async {
    try {
      http.Response res = await http.get(Uri.parse('${ApiUrl().baseUrl}productGET.php'));

      var productResponse = modelProductFromJson(res.body);

      if (productResponse.isSuccess == true) {
        print("Data diperoleh :: ${productResponse.data}");
        List<Datum>? result = productResponse.data;
        return result?.where((datum) => datum.kategori!.toLowerCase() == q.toLowerCase()).toList();
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 20),
        child: Column(
          children: [
            Text(
              "E-Commerce",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(
              width: double.infinity,
              height: 150,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Stack(
                children: [
                  Text(
                    "Hi user!\nWhat do you want to shop today?",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>PageCart()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Icon(CupertinoIcons.cart, color: Colors.blue),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Icon(CupertinoIcons.search, color: Colors.blue),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            buildSectionTitle("Clothing"),
            buildProductList(_futureProductClothing),
            SizedBox(height: 20),
            buildSectionTitle("Accessories"),
            buildProductList(_futureProductAccessories),
            SizedBox(height: 20),
            buildSectionTitle("Outer"),
            buildProductList(_futureProductOuter),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          "See More >",
          style: TextStyle(color: Colors.blue),
        )
      ],
    );
  }

  Widget buildProductList(Future<List<Datum>?> futureProduct) {
    return FutureBuilder<List<Datum>?>(
      future: futureProduct,
      builder: (BuildContext context, AsyncSnapshot<List<Datum>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.orange,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {
          final data = _filterResult ?? snapshot.data;
          if (data == null || data.isEmpty) {
            return const Center(
              child: Text("No data found."),
            );
          } else {
            return Container(
              height: 200, // Set a fixed height for the horizontal ListView
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.length > 5 ? 5 : data.length,
                itemBuilder: (context, index) {
                  Datum? item = data[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailProductPage(product: item)));
                    },
                    child: Container(
                      width: 150, // Set a fixed width for each item
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage("${ApiUrl().baseUrl}uploads/${item.foto.toString()}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name.toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  formatRupiah(item.price.toString()),
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        }
      },
    );
  }
}
