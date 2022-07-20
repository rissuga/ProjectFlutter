import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Client;
import 'dart:async';

import '../models/model.dart';

final String apiUrl = "https://625669eb52d8738c692eb249.mockapi.io/Products";

class ApiService {
  final String apiUrl = "https://625669eb52d8738c692eb249.mockapi.io/Products";
  final String baseUrl = "https://62401e080adaf66ad74a18bc.mockapi.io/";
  Client client = Client();

  Future<List<Products>> getProducts() async {
    final response = await http.get(Uri.parse(apiUrl));
    return productsFromJson(response.body);
  }

  Future<bool> deleteProduct(String id) async {
    final response = await http.delete(Uri.parse("$apiUrl/$id"));
    return response.statusCode == 200;
  }

  Future<bool> deleteProfile(String id) async {
    final response = await client.delete(
      Uri.parse("$baseUrl/profile/$id"),
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

Future<List<dynamic>> fecthData() async {
  var result = await http.get(Uri.parse(apiUrl));
  return json.decode(result.body);
}
