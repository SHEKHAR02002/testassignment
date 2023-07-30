import 'package:testassignment/Model/productmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<ProductoModel?>> getcategoryproduct({required String filter}) async {
  var url = Uri.parse('https://fakestoreapi.com/products/category/$filter');

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
