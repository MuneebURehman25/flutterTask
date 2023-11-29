import 'dart:convert';
import 'package:flutter/material.dart';
import '../Models/ProductsModel.dart';
import 'package:http/http.dart' as http;

class ProductsApiScreen extends StatefulWidget {
  const ProductsApiScreen({super.key});

  @override
  State<ProductsApiScreen> createState() => _ProductsApiScreenState();
}

class _ProductsApiScreenState extends State<ProductsApiScreen> {
  Future<ProductsModel> getProductsApi() async {
    var productResponse = await http.get(
        Uri.parse("https://webhook.site/e336fc0d-e974-43ba-bfe4-207db1b8e15b"));
    var productData = jsonDecode(productResponse.body.toString());
    if (productResponse.statusCode == 200) {
      return ProductsModel.fromJson(productData);
    } else {
      return ProductsModel.fromJson(productData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Products Response",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<ProductsModel>(
              future: getProductsApi(),
              builder: (context, snapshot) {

                if(snapshot.hasData){
                  return ListView.builder(
                      itemCount: snapshot.data?.data?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(snapshot.data!.data![index].shop!.name.toString()),
                                subtitle: Text(snapshot.data!.data![index].shop!.shopemail.toString()),

                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(snapshot.data!.data![index].shop!.image.toString()),
                                ),
                                trailing: Text(snapshot.data!.data![index].shop!.shopaddress.toString()),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height *.3,
                                width: MediaQuery.of(context).size.width *1,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.data?[index].images?.length,
                                    itemBuilder: (context,position){
                                    return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      height: MediaQuery.of(context).size.height *.25,
                                      width: MediaQuery.of(context).size.width *.5,

                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(snapshot.data!.data![index].images![position].url.toString())
                                        )
                                      ),
                                    ),

                                  );

                                })
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(snapshot.data!.data![index].inWishlist! == false ? Icons.favorite:Icons.favorite_outline),
                              )
                            ],
                          ),
                        );
                      });
                }
                else{
                  return const Text("Loading......");
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
