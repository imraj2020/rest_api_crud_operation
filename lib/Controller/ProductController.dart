import 'package:rest_api_crud_operation/Model/ProductModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rest_api_crud_operation/Utils/urls.dart';

class ProductController {
  List<Data> products = [];

  Future<void> fetchProducts() async{
    final response = await http.get(Uri.parse(urls.readProduct));

    print(response.statusCode);

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      ProductModel model = ProductModel.fromJson(data);
      products = model.data ?? [];
    }
  }


  // Future<void> deleteProduct(int id) async {
  //   final response = await http.delete(Uri.parse('$baseUrl/$id'));
  //   if (response.statusCode != 204) {
  //     throw Exception('Failed to delete product');
  //   }
  // }
}


