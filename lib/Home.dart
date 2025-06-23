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
    return Scaffold(
      appBar: AppBar(
        title: Text('Rest Api CRUD Operation'),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          childAspectRatio: 0.6,
        ),
        itemCount: productcontroller.products.length,
        itemBuilder: (context, index) {
          var myproducts = productcontroller.products[index];
          return ProductWidget(
            // onDelete: () {
            //   productcontroller.DeleteProduct(myproducts.sId.toString()).then((value) async {
            //     if (value) {
            //       await productcontroller.fetchProducts();
            //       setState(() {});
            //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //         content: Text('Product Deleted'),
            //         duration: Duration(seconds: 2),
            //       ));
            //     } else {
            //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //         content: Text('Something wrong...!'),
            //         duration: Duration(seconds: 2),
            //       ));
            //     }
            //   });
            // },

            onDelete: () async {

              try{

                await productcontroller.DeleteProduct(myproducts.sId.toString());
                await productcontroller.fetchProducts();
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Product Deleted'),
                  duration: Duration(seconds: 2),
                ));
              }catch(e){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Something went wrong'+e.toString()),
                  duration: Duration(seconds: 2),
                ));
              }
            },
            product: myproducts,
      );
        },
      ),

    );
  }
}
