import '../models/brend_model.dart';

abstract class BrendRepository {
  Future<BrendModel> getBrendById(String id);
  Future<void> saveBrend(BrendModel brend);
}
