import 'package:flutter/material.dart';

import '../models/model.dart';
import '../network/api_service.dart';
import 'DetailPage.dart';

class favoritePage extends StatefulWidget {
  const favoritePage({Key? key}) : super(key: key);

  @override
  State<favoritePage> createState() => _favoritePageState();
}

class _favoritePageState extends State<favoritePage> {
  late BuildContext context;
  late ApiService apiService;
  // List<Products> listProducts = [];

  // GetData() async {
  //   listProducts = await getData();
  // }

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return SafeArea(
      child: FutureBuilder(
        future: apiService.getProducts(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Products>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<Products>? profiles = snapshot.data;
            return _buildListView(profiles!);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildListView(List<Products> products) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          Products produk = products[index];
          return Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Card(
                  child: ListTile(
                leading: Image.network(
                  produk.image,
                  width: 50.0,
                  fit: BoxFit.cover,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(produks: produk),
                    ),
                  );
                },
                title: Text(produk.nama),
                subtitle: Text(produk.price),
                trailing: TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Warning"),
                            content: Text(
                                "Are you sure want to delete data profile ${produk.nama}?"),
                            actions: <Widget>[
                              TextButton(
                                child: Text("Yes"),
                                onPressed: () {
                                  Navigator.pop(context);
                                  apiService
                                      .deleteProduct(produk.id)
                                      .then((isSuccess) {
                                    if (isSuccess) {
                                      setState(() {});
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text("Delete data success")));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text("Delete data failed")));
                                    }
                                  });
                                },
                              ),
                              TextButton(
                                child: Text("No"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          );
                        });
                  },
                  child: Text(
                    "Delete",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              )));
        },
      ),
    );
  }
}
