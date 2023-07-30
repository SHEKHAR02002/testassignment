import 'package:http/http.dart' as http;
import 'dart:convert';

postData({required String username, required String password}) async {
  var jsonData = {
    'username': username,
    'password': password,
  };
  var jsonString = jsonEncode(jsonData);

  var response = await http.post(
    Uri.parse("https://fakestoreapi.com/auth/login"),
    headers: {'Content-Type': 'application/json'},
    body: jsonString,
  );

  if (response.statusCode == 200) {
    return response.statusCode;
  } else {
    return response.statusCode;
  }
}
