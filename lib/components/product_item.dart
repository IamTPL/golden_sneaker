import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import '../model/cart_model.dart';

class ProductItem extends StatefulWidget {
  final shoe;
  const ProductItem({super.key, this.shoe});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(builder: (context, cart, child) {
      return Container(
        margin: EdgeInsets.only(bottom: 40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //Product Image Block
          Container(
            height: 380,
            decoration: BoxDecoration(
              color: HexColor(widget.shoe.color),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Transform.rotate(
              angle: -24 * (pi / 180),
              child: Transform.translate(
                offset: Offset(-16, -10),
                child: Image.network(
                  widget.shoe.image,
                ),
              ),
            ),
          ),

          //Product Name
          Padding(
            padding: EdgeInsets.only(top: 26, bottom: 20),
            child: Text(
              widget.shoe.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          //Product Description
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              widget.shoe.description,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF777777),
                  height: 1.8,
                  fontWeight: FontWeight.w400),
            ),
          ),

          //Price & button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${widget.shoe.price.toString()}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              Container(
                  height: 46,
                  decoration: BoxDecoration(
                      color: Color(0xFFF6C90E),
                      borderRadius: BorderRadius.circular(999)),
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 700),
                    child: cart.cartList
                            .any((element) => element.id == widget.shoe.id)
                        ? RepaintBoundary(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 13),
                              alignment: Alignment.center,
                              child: Image.asset(
                                'assets/images/check.png',
                                width: 20,
                              ),
                            ),
                          )
                        : RepaintBoundary(
                            child: ElevatedButton(
                                onPressed: () {
                                  cart.add(widget.shoe);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 22, horizontal: 22),
                                  backgroundColor: Color(0xFFF6C90E),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        999), // Bo góc của button
                                  ),
                                ),
                                child: const Text(
                                  'ADD TO CART',
                                  style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF303841)),
                                )),
                          ),
                  ))
            ],
          )
        ]),
      );
    });
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
