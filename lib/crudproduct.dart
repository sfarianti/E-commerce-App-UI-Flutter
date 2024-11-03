import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CrudProduct extends StatefulWidget {
  const CrudProduct({super.key});

  @override
  State<CrudProduct> createState() => _CrudProductState();
}

class _CrudProductState extends State<CrudProduct> {
  List<dynamic> _listdata = [];
  bool _isloading = true;

  Future<void> _getdata() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.105/flutterapi/crudflutter/read.php'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = data;
          _isloading = false;
        });
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Your Product"),
      ),
      body: _isloading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _listdata.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(_listdata[index]['title'] ?? 'No Title'),
              subtitle: Text(_listdata[index]['price'] ?? 'No Price'),
            ),
          );
        },
      ),
    );
  }
}
