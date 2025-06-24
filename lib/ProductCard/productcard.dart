import 'package:flutter/material.dart';
import 'package:rest_api_crud_operation/Model/ProductModel.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_crud_operation/Home.dart';

class ProductWidget extends StatefulWidget {
  final Data product;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ProductWidget({
    super.key,
    required this.onEdit,
    required this.onDelete,
    required this.product,
  });

  @override
  State<StatefulWidget> createState() {
    return _ProductWidget();
  }
}

class _ProductWidget extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 150,
            child: Image.network(
              widget.product.img.toString(),

              // 'https://adminapi.applegadgetsbd.com/storage/media/large/3408-34138.jpg', // image url
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  widget.product.productName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                Text(
                  'Price: ${widget.product.unitPrice ?? 0} | QTY : ${widget.product.qty ?? 0}',
                  style: TextStyle(fontSize: 10, color: Colors.black54),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: widget.onEdit,
                  icon: Icon(Icons.edit, color: Colors.orange),
                ),
                SizedBox(width: 5),
                IconButton(
                  onPressed: widget.onDelete,
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
