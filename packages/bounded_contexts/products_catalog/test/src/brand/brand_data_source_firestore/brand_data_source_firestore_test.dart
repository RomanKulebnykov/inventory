import 'dart:typed_data';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:products_catalog/products_catalog.dart';
import 'package:shared_kernel/shared_kernel.dart';

void main() {
  late BrandDataSourceFirestore brandDataSourceFirestore;
  late FakeFirebaseFirestore fakeFirestore;
  late MockFirebaseStorage fakeStorage;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    fakeStorage = MockFirebaseStorage();
    brandDataSourceFirestore = BrandDataSourceFirestore(
      getBrendsCollectionPath: () => fakeFirestore.collection('brands'),
      getStorageFilesPath: () => fakeStorage.ref('brands'),
    );
  });

  Future<Map<String, dynamic>?> _getFirestore(String id) async {
    final snap = await fakeFirestore.collection('brands').doc(id).get();
    return snap.data();
  }

  Future<Uint8List?> getStorage(String id) async {
    try {
      final file =
          await fakeStorage.ref('brands').child(id).child('logo.jpg').getData();
      return file;
    } catch (e) {
      throw Exception();
    }
  }

  group('Correct save and update', () {
    test('Save Brand without image', () async {
      final imageData = null;
      final brand = Brand(
        'id1',
        name: 'name1',
        description: 'description1',
        image: imageData,
      );

      await brandDataSourceFirestore.save(brand);
      expect(fakeStorage.storedDataMap.length, 0);
      expect(() async => await getStorage('id1'), throwsException);
      expect(
        await _getFirestore('id1'),
        isA<Map<String, dynamic>>().having(
          (map) => map['hasStoredLogoImage'],
          'Store logo image should be false',
          isFalse,
        ),
      );
    });
    test('Save Brand with set image', () async {
      final imageData = null;
      final brand = Brand(
        'id1',
        name: 'name1',
        description: 'description1',
        image: imageData,
      );

      final imageUpdateParam = ImageUpdateParamReplace(
        Uint8List.fromList([1, 2, 3]),
      );
      await brandDataSourceFirestore.save(
        brand,
        updateParam: imageUpdateParam,
      );
      expect(fakeStorage.storedDataMap.length, 1);
      expect(await getStorage('id1'), Uint8List.fromList([1, 2, 3]));
      expect(
        await _getFirestore('id1'),
        isA<Map<String, dynamic>>().having(
          (map) => map['hasStoredLogoImage'],
          'Store logo image should be true',
          isTrue,
        ),
      );
    });

    test('Save Brand and replace image', () async {
      final imageData = null;
      final brand = Brand(
        'id1',
        name: 'name1',
        description: 'description1',
        image: imageData,
      );
      final imageUpdateParam = ImageUpdateParamReplace(
        Uint8List.fromList([1, 2, 3]),
      );
      await brandDataSourceFirestore.save(
        brand,
        updateParam: imageUpdateParam,
      );

      final imageUpdateParam2 = ImageUpdateParamReplace(
        Uint8List.fromList([4, 5, 6]),
      );
      await brandDataSourceFirestore.save(
        brand,
        updateParam: imageUpdateParam2,
      );
      expect(fakeStorage.storedDataMap.length, 1);
      expect(await getStorage('id1'), Uint8List.fromList([4, 5, 6]));
      expect(
        await _getFirestore('id1'),
        isA<Map<String, dynamic>>().having(
          (map) => map['hasStoredLogoImage'],
          'Store logo image should be true',
          isTrue,
        ),
      );
    });

    test('Save Brand without update image', () async {
      final imageData = null;
      var brand = Brand(
        'id1',
        name: 'name1',
        description: 'description1',
        image: imageData,
      );

      final imageUpdateParam = ImageUpdateParamReplace(
        Uint8List.fromList([1, 2, 3]),
      );
      await brandDataSourceFirestore.save(
        brand,
        updateParam: imageUpdateParam,
      );

      final testedBrand = Brand(
        'id1',
        name: 'name1',
        description: 'description1',
        image: ImageData(imageURL: 'url'),
      );

      await brandDataSourceFirestore.save(testedBrand);
      expect(fakeStorage.storedDataMap.length, 1);
      expect(await getStorage('id1'), Uint8List.fromList([1, 2, 3]));
      expect(
        await _getFirestore('id1'),
        isA<Map<String, dynamic>>().having(
          (map) => map['hasStoredLogoImage'],
          'Store logo image should be true',
          isTrue,
        ),
      );

      await brandDataSourceFirestore.save(
        testedBrand,
        updateParam: ImageUpdateParamNone(),
      );
      expect(fakeStorage.storedDataMap.length, 1);
      expect(await getStorage('id1'), Uint8List.fromList([1, 2, 3]));
      expect(
        await _getFirestore('id1'),
        isA<Map<String, dynamic>>().having(
          (map) => map['hasStoredLogoImage'],
          'Store logo image should be true',
          isTrue,
        ),
      );
    });

    test('Save Brand with remove image', () async {
      final imageData = null;
      var brand = Brand(
        'id1',
        name: 'name1',
        description: 'description1',
        image: imageData,
      );

      final imageUpdateParam = ImageUpdateParamReplace(
        Uint8List.fromList([1, 2, 3]),
      );
      await brandDataSourceFirestore.save(
        brand,
        updateParam: imageUpdateParam,
      );

      await brandDataSourceFirestore.save(
        brand,
        updateParam: ImageUpdateParamRemove(),
      );
      expect(fakeStorage.storedDataMap.length, 0);
      expect(() async => await getStorage('id1'), throwsException);
      expect(
        await _getFirestore('id1'),
        isA<Map<String, dynamic>>().having(
          (map) => map['hasStoredLogoImage'],
          'Store logo image should be false',
          isFalse,
        ),
      );

      // print(fakeStorage.storedDataMap);
      // print(fakeFirestore.dump());
    });
  });
}
