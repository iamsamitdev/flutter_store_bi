// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_store/models/ProductModel.dart';
import 'package:flutter_store/services/rest_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // ตัวแปรสำหรับสลับระหว่าง ListView และ GridView
  bool _isListView = true;

  // สร้างเมธอดสำหรับสลับระหว่าง ListView และ GridView
  void _toggleView() {
    setState(() {
      _isListView = !_isListView;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            _toggleView();
          }, 
          icon: Icon(_isListView ? Icons.grid_view : Icons.list)
        ),
        title: const Text('Products'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await CallAPI().getAllProducts();
        },
        child: FutureBuilder(
          future: CallAPI().getAllProducts(),
          builder: (context, AsyncSnapshot snapshot) {
            // Loading...
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if(snapshot.hasData){
                List<ProductModel> products = snapshot.data;
                return _isListView ? _listView(products) : _gridView(products);
              } else {
                return const Center(
                  child: Text('No data'),
                );
              }
            }
          },
        ),
      ),
    );
  }

  // _listView Widget
  Widget _listView(List<ProductModel> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {

        ProductModel product = products[index];

        return Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          child: SizedBox(
            height: 350,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0,1),
                    blurRadius: 2
                  )
                ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  product.image == null
                  ?
                  Image.asset(
                    'assets/images/gnslogo.png',
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                  :
                  Image.network(
                    product.image!,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              '\$ ${product.price}',
                              style: const TextStyle(fontSize: 18, color: Colors.red),
                            ),
                            const Spacer(),
                            Text(
                              product.category.toString(),
                              style: const TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ],
                        ), 
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  // _gridView Widget
  Widget _gridView(List<ProductModel> products) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2
      ), 
      itemCount: products.length,
      itemBuilder: (context, index) {

        ProductModel product = products[index];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0,1),
                  blurRadius: 2
                )
              ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                product.image == null
                ?
                Image.asset(
                  'assets/images/gnslogo.png',
                  height: 110,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
                :
                Image.network(
                  product.image!,
                  height: 110,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '\$ ${product.price}',
                        style: const TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }

}