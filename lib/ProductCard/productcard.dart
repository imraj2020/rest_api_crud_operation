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
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(12), // card corner radius
      ),
      child: Column(
        children: [
          // Clip the image to the same (or slightly smaller) radius
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 130,
              color: Colors.blueAccent, // match background if image has transparency
              child: Image.network(
                widget.product.img.toString(),
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return Image.network(
                    'https://www.shutterstock.com/image-illustration/parcel-box-exclamation-mark-about-260nw-2377273621.jpg',
                    fit: BoxFit.cover,
                  );
                },
              ),
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
