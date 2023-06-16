import 'package:flutter/material.dart';
import 'dart:math';
import '../model/cart_model.dart';

class CartItem extends StatefulWidget {
  final shoe;
  final CartModel cart;

  const CartItem({super.key, this.shoe, required this.cart});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController controller2;
  late Animation<double> animation1;
  late Animation<double> animation2;
  CartModel previousCart = CartModel();
  bool _isClosed = false;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(milliseconds: 700), vsync: this);
    animation1 = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller2 =
        AnimationController(duration: Duration(milliseconds: 900), vsync: this);
    animation2 = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: controller2, curve: Curves.easeOutBack));
    controller.forward();
    super.initState();
  }

  @override
  void dispose() async {
    controller.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _isClosed ? animation2 : animation1,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              child: Stack(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: HexColor(widget.shoe.color),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                  ),
                  Transform.rotate(
                    angle: -28 * (pi / 180),
                    child: Transform.translate(
                      offset: Offset(0, -40),
                      child: Image.network(
                        widget.shoe.image,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 5,
              child: Transform.translate(
                offset: Offset(0, -18),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //cart item name
                      Text(
                        widget.shoe.name,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),

                      //cart item price
                      Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 15),
                        child: Text(
                          '\$${widget.shoe.price}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),

                      //cart item quantity & action
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(children: [
                              //DELETE Button
                              Container(
                                width: 28,
                                height: 28,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (widget.shoe.quantity == 1) {
                                      setState(() {
                                        _isClosed = true;
                                      });
                                      controller2.reset();
                                      controller2.forward();
                                      Future.delayed(
                                          const Duration(milliseconds: 700),
                                          () {
                                        widget.cart.decrease(widget.shoe.id);

                                        setState(() {
                                          _isClosed = false;
                                        });
                                      });
                                    } else {
                                      widget.cart.decrease(widget.shoe.id);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFEEEEEE),
                                      foregroundColor: Color(0xFF303841),
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(999))),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      'assets/images/minus.png',
                                      width: 10,
                                    ),
                                  ),
                                ),
                              ),

                              //Quantity
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    '${widget.shoe.quantity}',
                                    style: TextStyle(fontSize: 14),
                                  )),

                              //ADD Button
                              Container(
                                width: 28,
                                height: 28,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFEEEEEE),
                                      foregroundColor: Color(0xFF303841),
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(999))),
                                  onPressed: () {
                                    widget.cart.increase(widget.shoe.id);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      'assets/images/plus.png',
                                      width: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),

                          //Trash Button
                          Container(
                            width: 28,
                            height: 28,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFF6C90E),
                                  foregroundColor: Color(0xFF303841),
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(999))),
                              onPressed: () {
                                setState(() {
                                  _isClosed = true;
                                });
                                controller2.reset();
                                controller2.forward();
                                Future.delayed(
                                    const Duration(milliseconds: 700), () {
                                  widget.cart.remove(widget.shoe);
                                  setState(() {
                                    _isClosed = false;
                                  });
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'assets/images/trash.png',
                                  width: 16,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
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
