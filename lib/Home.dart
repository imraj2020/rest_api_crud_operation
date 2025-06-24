import 'package:flutter/material.dart';
import 'Controller/ProductController.dart';
import 'ProductCard/productcard.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final ProductController productcontroller = ProductController();

  Future<void> fetchProducts() async {
    await productcontroller.fetchProducts();
    setState(() {});
    print(productcontroller.products.length);
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    void ProductDialogue({
      String? id,
      String? name,
      String? img,
      int? qty,
      int? unitPrice,
      int? totalPrice, required bool isupdate,
    }) {
      TextEditingController productNameController = TextEditingController();
      TextEditingController productQTYController = TextEditingController();
      TextEditingController productImageController = TextEditingController();
      TextEditingController productUnitPriceController =
          TextEditingController();
      TextEditingController productTotalPriceController =
          TextEditingController();

      productNameController.text = name ?? '';
      productImageController.text = img ?? '';
      productQTYController.text = qty != null ? qty.toString() : '0';
      productUnitPriceController.text =
          unitPrice != null ? unitPrice.toString() : '0';
      productTotalPriceController.text =
          totalPrice != null ? totalPrice.toString() : '0';

      showDialog(
        context: context,
        builder:
            (context) => SingleChildScrollView(
              child: AlertDialog(
                title: Text(isupdate ? 'Edit product' : 'Add product'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: productNameController,
                      decoration: InputDecoration(labelText: 'Product name'),
                    ),
                    TextField(
                      controller: productImageController,
                      decoration: InputDecoration(labelText: 'Product image'),
                    ),
                    TextField(
                      controller: productQTYController,
                      decoration: InputDecoration(labelText: 'Product qty'),
                    ),
                    TextField(
                      controller: productUnitPriceController,
                      decoration: InputDecoration(
                        labelText: 'Product unit price',
                      ),
                    ),
                    TextField(
                      controller: productTotalPriceController,
                      decoration: InputDecoration(labelText: ' total price'),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Close'),
                        ),
                        SizedBox(width: 5),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              await productcontroller.CreateUpdateProduct(
                                productNameController.text,
                                productImageController.text,
                                int.parse(productQTYController.text.trim()),
                                int.parse(productUnitPriceController.text.trim()),
                                int.parse(
                                  productTotalPriceController.text.trim(),
                                ),
                                id,
                                isupdate
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:  Text(isupdate ? 'product updated ': 'Product Created'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Something wrong...!' + e.toString(),
                                  ),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
              
                            Navigator.pop(context);
                            await fetchProducts();
                            setState(() {});
                          },
                          child: Text(isupdate ? 'Update Product': 'Add product'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Rest Api CRUD Operation'),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Column(
        children: [
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
             mainAxisExtent: 270,
              // Removed childAspectRatio
            ),
            itemCount: productcontroller.products.length,
            itemBuilder: (context, index) {
              var myproducts = productcontroller.products[index];
              return ProductCard(
                onDelete: () async {
                  try {
                    await productcontroller.DeleteProduct(
                      myproducts.sId.toString(),
                    );
                    await productcontroller.fetchProducts();
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Product Deleted'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Something went wrong' + e.toString()),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },

                onEdit: () {
                  ProductDialogue(
                    name: myproducts.productName,
                    img: myproducts.img,
                    id: myproducts.sId,
                    unitPrice: myproducts.unitPrice,
                    totalPrice: myproducts.totalPrice,
                    qty: myproducts.qty,
                      isupdate: true,
                  );
                },

                product: myproducts,
              );
            },
          ),
        ),
      ],),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ProductDialogue(isupdate: false);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
