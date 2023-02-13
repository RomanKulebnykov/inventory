import 'package:shared_kernel/shared_kernel.dart';

class BrandFilter implements IEntityFilter {
  int _limit;

  int get limit => _limit;

  set limit(int value) {
    _limit = value;
  }

  String? _nameStarts;

  String? get nameStarts => _nameStarts;

  set nameStarts(String? value) {
    _nameStarts = value;
  }

  BrandFilter({
    int limit = 10,
    String? nameStarts,
  })  : _limit = limit,
        _nameStarts = nameStarts;
}
