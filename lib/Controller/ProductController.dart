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


  Future<bool> DeleteProduct(String productId) async{

    final response = await http.get(Uri.parse(urls.deleteProduct(productId)));
    if(response.statusCode == 200){
      fetchProducts();
      return true;
    }else{
      return false;
    }
  }
}


