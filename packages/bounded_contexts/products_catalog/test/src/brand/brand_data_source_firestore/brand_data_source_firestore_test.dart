// import 'dart:typed_data';
//
// import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
// import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:products_catalog/products_catalog.dart';
import 'package:shared_kernel/shared_kernel.dart';

void main() {
  late BrandDataSourceFirestore brandDataSourceFirestore;
  // late FakeFirebaseFirestore fakeFirestore;
  // late MockFirebaseStorage fakeStorage;

  test('description', () {});

  // setUp(() {
  //   fakeFirestore = FakeFirebaseFirestore();
  //   fakeStorage = MockFirebaseStorage();
  //   brandDataSourceFirestore = BrandDataSourceFirestore(
  //     getBrendsCollectionPath: () => fakeFirestore.collection('brands'),
  //     getStorageFilesPath: () => fakeStorage.ref('brands'),
  //   );
  // });
  //
  // test('Should correct brand save', () async {
  //   final imageData = ImageData(imageURL: 'url');
  //   final imageUpdateParam = ImageUpdateParamReplace(
  //     Uint8List.fromList([1, 2, 3]),
  //   );
  //
  //   final brand = Brand(
  //     'id1',
  //     name: 'name1',
  //     description: 'description1',
  //     image: imageData,
  //   );
  //
  //   await brandDataSourceFirestore.save(brand, updateParam: imageUpdateParam);
  //   expect(true, true);
  //   print(fakeFirestore.dump());
  // });
}
