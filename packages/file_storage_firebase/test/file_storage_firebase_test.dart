import 'dart:typed_data';
import 'package:file_storage_firebase/file_storage_firebase.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_kernel/shared_kernel.dart';

void main() {
  late MockFirebaseStorage fakeStorage;
  late FileStorageFirebase fileStorage;
  setUp(() {
    fakeStorage = MockFirebaseStorage();
    fileStorage = FileStorageFirebase(() => fakeStorage.ref('brands'));
  });

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
    test('Save without image', () async {
      fileStorage.updateLogoImage(entityId: 'id1');
      fileStorage.updateLogoImage(
        entityId: 'id2',
        updateParam: ImageUpdateParamNone(),
      );
      expect(fakeStorage.storedDataMap.length, 0);
      expect(() async => await getStorage('id1'), throwsException);
    });

    test('Save with set logo image', () async {
      final imageUpdateParam = ImageUpdateParamReplace(
        Uint8List.fromList([1, 2, 3]),
      );

      fileStorage.updateLogoImage(
          entityId: 'id1', updateParam: imageUpdateParam);
      expect(fakeStorage.storedDataMap.length, 1);
      expect(await getStorage('id1'), Uint8List.fromList([1, 2, 3]));
    });

    test('Replace image', () async {
      fakeStorage
          .ref('brands')
          .child('id1')
          .child('logo.jpg')
          .putData(Uint8List.fromList([1, 2, 3]));

      final imageUpdateParam = ImageUpdateParamReplace(
        Uint8List.fromList([4, 5, 6]),
      );

      fileStorage.updateLogoImage(
        entityId: 'id1',
        updateParam: imageUpdateParam,
      );

      expect(fakeStorage.storedDataMap.length, 1);
      expect(await getStorage('id1'), Uint8List.fromList([4, 5, 6]));
    });

    test('Save Brand with remove image', () async {
      fakeStorage
          .ref('brands')
          .child('id1')
          .child('logo.jpg')
          .putData(Uint8List.fromList([1, 2, 3]));

      fileStorage.updateLogoImage(
        entityId: 'id1',
        updateParam: ImageUpdateParamRemove(),
      );

      expect(fakeStorage.storedDataMap.length, 0);
      expect(() async => await getStorage('id1'), throwsException);
    });
  });
}
