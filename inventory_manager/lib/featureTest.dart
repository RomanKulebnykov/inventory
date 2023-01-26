import 'dart:math';

final Random random = Random();
void main() {
  // print(doubleBetween(45));
  // print(doubleBetween(45));
  // print(doubleBetween(45));
  // print(doubleBetween(45));
  // print(doubleBetween(45));
  // print(doubleBetween(45));
}

double randomCurrency(double maxDouble) {
  double ranDouble = random.nextDouble();
  return double.parse((ranDouble * maxDouble).toStringAsFixed(2));
}
