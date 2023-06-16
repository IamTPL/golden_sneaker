import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/cart_model.dart';
import 'package:provider/provider.dart';
import 'cart_item.dart';

class CartBlock extends StatefulWidget {
  const CartBlock({super.key});

  @override
  State<CartBlock> createState() => _CartBlockState();
}

class _CartBlockState extends State<CartBlock> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(builder: (context, cart, child) {
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
                offset: const Offset(0, 5),
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
                const Padding(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your cart',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        '\$${cart.totalPrice()}',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 24),
                      )
                    ],
                  ),
                ),

                //Cart List
                cart.cartList.isEmpty
                    ? const Text(
                        'Your cart is empty.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF777777),
                        ),
                      )
                    : Expanded(
                        child: ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context)
                                .copyWith(scrollbars: false),
                            child: ListView.builder(
                              itemCount: cart.cartList.length,
                              itemBuilder: (context, index) {
                                final shoe = cart.cartList[index];
                                return CartItem(shoe: shoe, cart: cart);
                              },
                            )),
                      ),
              ],
            )
          ],
        ),
      );
    });
  }
}
