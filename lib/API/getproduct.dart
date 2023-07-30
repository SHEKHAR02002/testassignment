import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:testassignment/Model/productmodel.dart';

Future<List<ProductoModel?>> getproduct() async {
  var url = Uri.parse('https://fakestoreapi.com/products');

  var response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    List<ProductoModel> product = List<ProductoModel>.from(
        jsonResponse.map((x) => ProductoModel.fromJson(x)));

    return product;
  } else {
    throw Exception('Failed to fetch users. Error: ${response.statusCode}');
  }
}

Future<ProductoModel?> getsingleproduct({required String id}) async {
  var url = Uri.parse('https://fakestoreapi.com/products/$id');

  var response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    ProductoModel product = ProductoModel.fromJson(jsonResponse);
    return product;
  } else {
    throw Exception('Failed to fetch users. Error: ${response.statusCode}');
  }
}
