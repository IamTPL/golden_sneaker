import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/cart_model.dart';
import 'package:provider/provider.dart';
import '../components/cart.dart';
import '../components/products.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween(begin: 0.0, end: 100.0).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: Scaffold(
        body: Stack(
          children: [
            //background yellow
            Positioned(
                left: MediaQuery.of(context).size.width * 0.5,
                top: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 3,
                height: MediaQuery.of(context).size.width * 2.3,
                child: Transform.translate(
                    offset: Offset(0, _animation.value),
                    child: AnimatedBuilder(
                        animation: _animationController,
                        builder: (BuildContext context, child) {
                          return Transform.translate(
                            offset: Offset(0, _animation.value),
                            child: Transform(
                              transform: Matrix4.skewY(-0.13962634)
                                ..translate(
                                    -0.5 *
                                        MediaQuery.of(context).size.width *
                                        3,
                                    0.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF6C90E),
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(9999, 9999)),
                                ),
                              ),
                            ),
                          );
                        }))),

            //Content Page
            screenWidth > 800
                ? Center(
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProductBlock(),
                      SizedBox(width: 50),
                      CartBlock(),
                    ],
                  ))
                : Container(
                    child: ListView(
                    children: [
                      Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ProductBlock(),
                          SizedBox(height: 50),
                          CartBlock(),
                        ],
                      )),
                    ],
                  ))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
