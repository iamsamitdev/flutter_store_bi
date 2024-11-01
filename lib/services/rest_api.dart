import 'dart:convert';
import 'package:flutter_store/models/ProductModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_store/utils/constants.dart';

class CallAPI {
  // Set Headers for login/register
  _setHeaders() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  // Login User API
  loginAPI(data) async {
    return await http.post(
      Uri.parse('${baseURLAPI}auth/login'),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  // Get All Products API
  Future<List<ProductModel>?> getAllProducts() async {
    final response = await http.get(
      Uri.parse('${baseURLAPI}products'),
      headers: _setHeaders(),
    );

    return productModelFromJson(response.body);
  }

}