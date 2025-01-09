import 'dart:math';

class FoodModel {
  String name;
  String image;
  double price;

  FoodModel({
    required this.name,
    required this.image,
    required this.price,
  });
}

final _nombres = [
  'Chicken Food',
  'Vegetarian Food',
  'Meat Food',
  'Chinese food',
  'Dessert',
  'Mediterranean food',
];

final random = Random();

final food = List.generate(
  _nombres.length,
  (index) => FoodModel(
    name: _nombres[index],
    image: 'assets/${index + 1}.png',
    price: _precio(random, 3, 9),
  ),
);

double _precio(Random source, num inicio, num fin) =>
    source.nextDouble() * (fin - inicio) + inicio;
