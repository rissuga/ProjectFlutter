import 'package:flutter/material.dart';
import '../models/model.dart';
import '../network/api_service.dart';

class DetailPage extends StatelessWidget {
  final Products produks;

  DetailPage({Key? key, required this.produks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Pickup',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0,
                color: Color(0xFF545D68))),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications_none, color: Color(0xFF545D68)),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: fecthData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Image.network(
                      produks.image,
                      width: 160,
                      height: 160,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: Text(produks.nama,
                        style: TextStyle(
                            fontFamily: 'Varela',
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF17532))),
                  ),
                  SizedBox(height: 10.0),
                  Center(
                    child: Text(produks.price,
                        style: TextStyle(
                            color: Color(0xFF575E67),
                            fontFamily: 'Varela',
                            fontSize: 15.0)),
                  ),
                  SizedBox(height: 20.0),
                  Center(
                    child: Container(
                      child: Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s. Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Varela',
                              fontSize: 16.0,
                              color: Color(0xFFB4B8B9))),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Center(
                      child: Container(
                          width: MediaQuery.of(context).size.width - 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: Color(0xFFF17532)),
                          child: Center(
                              child: Text(
                            'Add to cart',
                            style: TextStyle(
                                fontFamily: 'Varela',
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ))))
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
