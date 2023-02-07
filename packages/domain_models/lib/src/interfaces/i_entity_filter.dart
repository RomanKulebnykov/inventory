abstract class Specification<T> {
  bool isSatisfiedBy(T candidate);
  Specification<T> and(Specification<T> otherSpec) {
    return AndSpecification<T>(this, otherSpec);
  }
}

// abstract class CompositeSpecification<T> extends Specification<T> {
//   @override
//   Specification<T> and(Specification<T> otherSpec) {
//     return AndSpecification<T>(this, otherSpec);
//   }
// }

class AndSpecification<T> extends Specification<T> {
  final Specification<T> left;
  final Specification<T> right;

  AndSpecification(this.left, this.right);

  @override
  bool isSatisfiedBy(candidate) {
    return left.isSatisfiedBy(candidate) && right.isSatisfiedBy(candidate);
  }
}

///
class ProductNameSpecification extends Specification<Product> {
  final String nameSubStr = '';

  @override
  bool isSatisfiedBy(Product candidate) {
    return candidate.name.contains(nameSubStr);
  }
}

class ProductIsActiveSpecification extends Specification<Product> {
  final bool isActive = true;

  @override
  bool isSatisfiedBy(Product candidate) {
    return candidate.isActive == isActive;
  }
}

class Product {
  final String name;
  final double price;
  final bool isActive;

  Product(this.name, this.price, this.isActive);
}

enum FilterOperator {
  equals,
  greater,
  less,
  contains,
  inSet,
}

abstract class IEntityFilter<T> {
  // List<FilterCondition> get conditions;
  bool isSatisfiedBy(T candidate);
}

class FilterCondition {
  final String fieldName;
  final FilterOperator operator;
  final Object value;

  FilterCondition({
    required this.fieldName,
    required this.operator,
    required this.value,
  });
}

class ProductFilter extends IEntityFilter<Product> {
  // final String? nameContains;
  // final bool isActive;

  @override
  bool isSatisfiedBy(Product candidate) {
    bool result = true;

    return result;
  }
}

void main() {
  List<Product> products = [
    Product('Cbkd1', 500, true),
    Product('Cbkd2', 1000, true),
    Product('Cvkd1', 100, true),
    Product('Cvkd2', 300, false),
    Product('Clkd7', 700, true),
  ];
}
