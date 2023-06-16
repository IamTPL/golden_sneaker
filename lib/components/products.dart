import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../model/list_shoe_model.dart';
import '../model/shoe_model.dart';
import 'product_item.dart';

class ProductBlock extends StatefulWidget {
  const ProductBlock({super.key});

  @override
  State<ProductBlock> createState() => _ProductBlockState();
}

class _ProductBlockState extends State<ProductBlock> {
  List<Shoe> shoeArr = [];

  @override
  void initState() {
    super.initState();
    loadShoesFromJson().then((listShoe) {
      setState(() {
        shoeArr = listShoe.shoes;
      });
    });
  }

  Future<ListShoeModel> loadShoesFromJson() async {
    String jsonContent =
        await rootBundle.loadString('assets/data/shoeData.json');
    Map<String, dynamic> jsonData = jsonDecode(jsonContent);

    return ListShoeModel.fromJson(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335,
      height: 600,
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(1.0),
              spreadRadius: 2,
              blurRadius: 20,
              offset: Offset(0, 5),
            )
          ],
          color: Colors.white),
      child: Stack(
        children: [
          //Background corner
          Transform.translate(
            offset: const Offset(-180, -130),
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                  color: const Color(0xFFF6C90E),
                  borderRadius: BorderRadius.circular(999)),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //logo Nike
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Image(
                  width: 60,
                  image: AssetImage('assets/images/nike.png'),
                ),
              ),

              //Title
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Text(
                      'Our Products',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    )
                  ],
                ),
              ),

              //Product List
              Expanded(
                child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: ListView.builder(
                      itemCount: shoeArr.length,
                      itemBuilder: (context, index) {
                        final shoe = shoeArr[index];
                        return ProductItem(shoe: shoe);
                      },
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
