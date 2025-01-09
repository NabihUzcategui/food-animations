import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_food_animations/model/fod_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MenuFood extends StatefulWidget {
  static const String routeName = 'MenuFood';

  const MenuFood({super.key});

  @override
  State<MenuFood> createState() => _MenuFoodState();
}

class _MenuFoodState extends State<MenuFood> {
  final _pageControllerFood = PageController(viewportFraction: 1.5);
  final _pageControllerBackFood = PageController();

  double _pageScrollFood = 0.0;

  void pageScroll() {
    setState(() {
      _pageScrollFood = _pageControllerFood.page!;
    });
  }

  @override
  void initState() {
    _pageControllerFood.addListener(pageScroll);
    super.initState();
  }

  @override
  void dispose() {
    _pageControllerFood.removeListener(pageScroll);
    _pageControllerFood.dispose();
    _pageControllerBackFood.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            right: -size.width * 0.2,
            left: -size.width * 0.2,
            top: -size.height * 0.22,
            height: size.height * 0.7,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: _pageControllerBackFood,
              itemBuilder: (context, index) {
                final opacity = 1 - (_pageScrollFood - index).abs();
                return Opacity(
                  opacity: opacity.clamp(0.0, 0.3),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..rotateZ(pi * 1 - (index - _pageScrollFood)),
                    child: Image.asset(
                      'assets/${index + 1}.png',
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: size.height * 0.05,
            left: size.width * 0.1,
            child: const Icon(
              Icons.keyboard_backspace_rounded,
              size: 35,
              color: Colors.pink,
            ),
          ),
          Positioned(
            top: size.height * 0.05,
            right: size.width * 0.1,
            child: const Icon(
              Icons.shopping_bag_outlined,
              size: 35,
              color: Colors.pink,
            ),
          ),
          Positioned(
            top: size.height * 0.1,
            left: 0,
            right: 0,
            height: size.height * 0.6,
            child: PageView.builder(
              onPageChanged: (value) {
                _pageControllerBackFood.animateToPage(
                  value,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                );
              },
              itemCount: food.length,
              controller: _pageControllerFood,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final opacity = 1 - (_pageScrollFood - index).abs();

                return Column(
                  children: [
                    Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()
                        ..rotateZ((_pageScrollFood - index) * pi / 2),
                      child: Opacity(
                        opacity: opacity.clamp(0.0, 1.0),
                        child: SizedBox(
                          width: size.width * 0.8,
                          height: size.height * 0.4,
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..rotateZ(pi * 1 - (index - _pageScrollFood)),
                            child: Image.asset(
                              food[index].image,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: opacity.clamp(0.0, 1.0),
                      child: Text(
                        food[index].name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.black87,
                          shadows: [
                            Shadow(
                              color: Colors.black12,
                              offset: Offset(3.0, 3.0),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Opacity(
                      opacity: opacity.clamp(0.0, 1.0),
                      child: Text(
                        '\$ ${food[index].price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                          color: Colors.pink,
                          shadows: [
                            Shadow(
                              color: Colors.black12,
                              offset: Offset(3.0, 3.0),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          Positioned(
            left: size.width * 0.2,
            right: size.width * 0.2,
            bottom: size.height * 0.2,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () {},
              child: const Text(
                'Add to Cart',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            left: size.width * 0.3,
            right: size.width * 0.3,
            bottom: size.height * 0.02,
            height: size.height * 0.15,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.primaryDelta! < -20) {
                  showCupertinoModalBottomSheet(
                      context: context,
                      builder: (context) => Material(
                            child: SizedBox(
                              height: size.height * 0.7,
                              child: const Center(
                                  child: Text(
                                'Menú',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              )),
                            ),
                          ));
                }
              },
              child: Container(
                width: size.width * 0.2,
                height: size.height * 0.1,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_drop_up_outlined,
                      color: Colors.black87,
                    ),
                    Text(
                      'Swipe to see Recipe',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
