import 'package:ecomerse/page/utils/sesionManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../model/modelMyFavorite.dart';
import '../utils/apiUrl.dart';

class MyFavoritePage extends StatefulWidget {
  const MyFavoritePage({super.key});

  @override
  State<MyFavoritePage> createState() => _MyFavoritePageState();
}

class _MyFavoritePageState extends State<MyFavoritePage> {
  late Future<List<DatumF>?> _futureProduct;
  List<DatumF>? _filterResult;

  @override
  void initState() {
    super.initState();
    _futureProduct = getMyFavorite();
    sessionManager.getSession();
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(left: 16, right:16, top: 20),
        child: buildProductList(_futureProduct),

      ),
    );
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

  Widget buildProductList(Future<List<DatumF>?> futureProduct) {
    return FutureBuilder<List<DatumF>?>(
      future: futureProduct,
      builder: (BuildContext context, AsyncSnapshot<List<DatumF>?> snapshot) {
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
          if (data == null) {
            return const Center(
              child: Text("No data found."),
            );
          } else {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: double.infinity,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: data.length > 5 ? 5 : data.length,
                itemBuilder: (context, index) {
                  DatumF item = data[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailProductPage(product: item)));
                    },
                    child: Container(
                      width: double.infinity,
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              image: DecorationImage(
                                image: NetworkImage("${ApiUrl().baseUrl}uploads/${item.foto.toString()}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
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
                                  SizedBox(height: 4.0),
                                  Text(
                                    formatRupiah(item.price.toString()),
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
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
