import 'package:ecomerse/page/utils/apiUrl.dart';
import 'package:ecomerse/page/utils/sesionManager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../model/modelOrder.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({super.key});
  @override
  State<MyOrderPage> createState() => _MyOrderPage();
}

class _MyOrderPage extends State<MyOrderPage> {
  Future<ModelOrder>? futureOrder;

  @override
  void initState() {
    super.initState();
    futureOrder = fetchOrder();
  }

  Future<ModelOrder> fetchOrder() async {
    final response = await http.get(Uri.parse('${ApiUrl().baseUrl}/ordersGET.php?id_user=${sessionManager.idUser}'));

    if (response.statusCode == 200) {
      return modelOrderFromJson(response.body);
    } else {
      throw Exception('Failed to load orders');
    }
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

  void showOrderDetails(BuildContext context, Datum order) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Order Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text('Order ID: ${order.idOrder}'),
                Text('Total Amount: ${formatRupiah(order.totalAmount.toString())}'),
                Text('Status: ${order.status}'),
                Divider(),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: order.details!.length,
                  itemBuilder: (context, index) {
                    var detail = order.details![index];
                    return ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage("${ApiUrl().baseUrl}uploads/${detail.foto.toString()}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(detail.name ?? '', style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Qty: ${detail.quantity}'),
                          Text('Price: ${formatRupiah(detail.price.toString())}'),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Orders')),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Center(
          child: FutureBuilder<ModelOrder>(
            future: futureOrder,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data?.data?.isEmpty == true) {
                return Text('No orders found');
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.data!.length,
                  itemBuilder: (context, index) {
                    final order = snapshot.data!.data![index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        title: Text(
                          'Order ID: ${order.idOrder}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total: ${formatRupiah(order.totalAmount.toString())}'),
                            ElevatedButton(
                              onPressed:
                                  () {},
                              style: ElevatedButton
                                  .styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                    50),
                                backgroundColor: order.status=="Pending"?Colors.grey:order.status=="Finish"?Colors.green:Colors.yellow, // Warna latar belakang tombol
                              ),
                              child: Text(
                                  '${order.status}',
                                  style: TextStyle(
                                      color:
                                      Colors.white)),
                            )
                          ],
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () => showOrderDetails(context, order),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
