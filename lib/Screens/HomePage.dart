import 'package:flutter/material.dart';
import '../models/model.dart';
import '../network/api_service.dart';
import 'DetailPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return Scaffold(
        body: Container(
      child: ListView(
        children: <Widget>[
          Container(
            height: 153,
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(left: 2),
            child: ListView.builder(
              padding: EdgeInsets.only(left: 25, right: 6),
              itemCount: products.length,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                Products produk = products[index];
                return Container(
                  // margin antar buku
                  margin: EdgeInsets.only(right: 19),
                  height: 10,
                  width: 153,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue.shade50,
                    image: DecorationImage(
                        image: NetworkImage(produk.image), fit: BoxFit.contain),
                  ),

                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(produk.price),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          Container(
            height: 25,
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.only(left: 25),
            child: DefaultTabController(
              length: 3,
              child: TabBar(
                  labelPadding: EdgeInsets.all(0),
                  indicatorPadding: EdgeInsets.all(0),
                  isScrollable: true,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  // labelStyle: GoogleFonts.openSans(
                  //     fontSize: 14, fontWeight: FontWeight.w700),
                  // unselectedLabelStyle: GoogleFonts.openSans(
                  //     fontSize: 14, fontWeight: FontWeight.w600),
                  tabs: [
                    Tab(
                      child: Container(
                        margin: EdgeInsets.only(right: 23),
                        child: Text('New'),
                      ),
                    ),
                    Tab(
                      child: Container(
                        margin: EdgeInsets.only(right: 23),
                        child: Text('Trending'),
                      ),
                    ),
                    Tab(
                      child: Container(
                        margin: EdgeInsets.only(right: 23),
                        child: Text('Best Seller'),
                      ),
                    )
                  ]),
            ),
          ),
//

          Container(
              margin: EdgeInsets.only(top: 21, bottom: 20),
              height: 300,
              child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: ((context, index) {
                    Products produk = products[index];
                    return Padding(
                      padding: EdgeInsets.all(8.0),
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
                                builder: (context) =>
                                    DetailPage(produks: produk),
                              ),
                            );
                          },
                          title: Text(produk.nama),
                          subtitle: Text(produk.price),
                        ),
                      ),
                    );
                  }))),
        ],
      ),
    ));
  }
}
