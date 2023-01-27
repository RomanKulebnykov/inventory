import 'package:products_manager/src/repositories/models/brand_model.dart';

abstract class BrendRepository {
  Future<BrandModel> getBrendById(String id);
  Future<void> saveBrend(BrandModel brend);
}
