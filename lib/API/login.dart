import 'package:http/http.dart' as http;
import 'dart:convert';

void postData({required String username,required String password}) async {

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
    print('Data sent successfully!');
  } else {
    print('Failed to send data. Error: ${response.statusCode}');
  }
}
