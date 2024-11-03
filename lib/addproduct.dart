import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/crudproduct.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController detailController = TextEditingController();

  Future<bool> _add() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.105/flutterapi/crudflutter/create.php'),
        body: {
          "productname": productNameController.text,
          "price": priceController.text,
          "stock": stockController.text,
          "detail": detailController.text,
        },
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print('Error adding product: $e');
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: productNameController,
                decoration: InputDecoration(
                  hintText: "Product Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Product name cannot be empty";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(
                  hintText: "Price",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Price cannot be empty";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: stockController,
                decoration: InputDecoration(
                  hintText: "Stock",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Stock cannot be empty";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: detailController,
                decoration: InputDecoration(
                  hintText: "Detail",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Detail cannot be empty";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _add().then((success) {
                      final snackBar = SnackBar(
                        content: Text(
                          success
                              ? 'Product successfully added'
                              : 'Failed to add product',
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      // Navigate to CrudProduct only if the addition was successful
                      if (success) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CrudProduct(),
                          ),
                              (route) => false,
                        );
                      }
                    });
                  }
                },
                child: const Text("Add"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
