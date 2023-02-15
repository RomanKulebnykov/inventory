import 'dart:typed_data';

import 'package:shared_kernel/shared_kernel.dart';
import 'package:test/test.dart';

void main() {
  group('Correct initialized', () {
    test('EditImageData Empty', () {
      final emptyEditImageData = EditImageData.fromImageData(null);
      expect(
        emptyEditImageData,
        isA<EditImageData>()
            .having(
              (editImageData) => editImageData.updateParam,
              'updateParam should be NONE',
              isA<ImageUpdateParamNone>(),
            )
            .having(
              (editImageData) => editImageData.imageData,
              'imageData should be null',
              isNull,
            ),
      );
    });

    test('EditImageData with Data', () {
      final initializedEditImageData = EditImageData.fromImageData(
        ImageData(imageURL: 'url', bytes: Uint8List.fromList([1, 2, 3])),
      );

      expect(
        initializedEditImageData,
        isA<EditImageData>()
            .having(
              (editImageData) => editImageData.updateParam,
              'updateParam should be NONE',
              isA<ImageUpdateParamNone>(),
            )
            .having(
              (editImageData) => editImageData.imageData,
              'imageData should be initialized',
              ImageData(imageURL: 'url', bytes: Uint8List.fromList([1, 2, 3])),
            ),
      );
    });
  });

  group('Correct Replace', () {
    test('Correct Replace Empty', () {
      final emptyEditImageData = EditImageData.fromImageData(null);
      emptyEditImageData.replace(Uint8List.fromList([1, 2, 3]));

      expect(
        emptyEditImageData,
        isA<EditImageData>()
            .having(
              (editImageData) => editImageData.initialImageData,
              'initialImageData should stay null',
              isNull,
            )
            .having(
              (editImageData) => editImageData.imageData,
              'imageData should be updated to new value',
              ImageData(bytes: Uint8List.fromList([1, 2, 3]), imageURL: null),
            )
            .having(
              (editImageData) => editImageData.updateParam,
              'update param should be update ',
              ImageUpdateParamReplace(Uint8List.fromList([1, 2, 3])),
            ),
      );
    });
    test('Correct Replace with Data', () {
      final initializedEditImageData = EditImageData.fromImageData(
        ImageData(imageURL: 'url', bytes: Uint8List.fromList([1, 2, 3])),
      );

      initializedEditImageData.replace(Uint8List.fromList([3, 4, 5]));

      expect(
        initializedEditImageData,
        isA<EditImageData>()
            .having(
              (editImageData) => editImageData.imageData,
              'imageData should be updated to new value',
              ImageData(imageURL: null, bytes: Uint8List.fromList([3, 4, 5])),
            )
            .having(
              (editImageData) => editImageData.initialImageData,
              'initial data should not changed',
              ImageData(imageURL: 'url', bytes: Uint8List.fromList([1, 2, 3])),
            )
            .having(
              (editImageData) => editImageData.updateParam,
              'updateParam should change to correct value',
              ImageUpdateParamReplace(Uint8List.fromList([3, 4, 5])),
            ),
      );
    });
  });
  group('Correct remove', () {
    test('Correct remove empty', () {
      final emptyEditImageData = EditImageData.fromImageData(null);

      emptyEditImageData.remove();

      expect(
        emptyEditImageData,
        isA<EditImageData>()
            .having(
              (editImageData) => editImageData.imageData,
              'imageData should be updated to new value',
              isNull,
            )
            .having(
              (editImageData) => editImageData.initialImageData,
              'initial data should not changed',
              isNull,
            )
            .having(
              (editImageData) => editImageData.updateParam,
              'updateParam should change to correct value',
              ImageUpdateParamNone(),
            ),
      );
    });
    test('Correct remove empty and updated', () {
      final emptyEditImageData = EditImageData.fromImageData(null);

      emptyEditImageData.replace(Uint8List.fromList([1, 2, 3]));
      emptyEditImageData.remove();

      expect(
        emptyEditImageData,
        isA<EditImageData>()
            .having(
              (editImageData) => editImageData.imageData,
              'imageData should be updated to new value',
              isNull,
            )
            .having(
              (editImageData) => editImageData.initialImageData,
              'initial data should not changed',
              isNull,
            )
            .having(
              (editImageData) => editImageData.updateParam,
              'updateParam should change to correct value',
              ImageUpdateParamNone(),
            ),
      );
    });
    test('Correct remove initialized with data', () {
      final initializedEditImageData = EditImageData.fromImageData(
        ImageData(imageURL: 'url', bytes: Uint8List.fromList([1, 2, 3])),
      );

      initializedEditImageData.remove();
      expect(
        initializedEditImageData,
        isA<EditImageData>()
            .having(
              (editImageData) => editImageData.imageData,
              'imageData should be updated to new value',
              null,
            )
            .having(
              (editImageData) => editImageData.initialImageData,
              'initial data should not changed',
              ImageData(imageURL: 'url', bytes: Uint8List.fromList([1, 2, 3])),
            )
            .having(
              (editImageData) => editImageData.updateParam,
              'updateParam should change to correct value',
              ImageUpdateParamRemove(),
            ),
      );
    });

    test('Correct remove initialized with data and updated', () {
      final initializedEditImageData = EditImageData.fromImageData(
        ImageData(imageURL: 'url', bytes: Uint8List.fromList([1, 2, 3])),
      );

      initializedEditImageData.replace(Uint8List.fromList([3, 4, 5]));

      initializedEditImageData.remove();
      expect(
        initializedEditImageData,
        isA<EditImageData>()
            .having(
              (editImageData) => editImageData.imageData,
              'imageData should be updated to new value',
              null,
            )
            .having(
              (editImageData) => editImageData.initialImageData,
              'initial data should not changed',
              ImageData(imageURL: 'url', bytes: Uint8List.fromList([1, 2, 3])),
            )
            .having(
              (editImageData) => editImageData.updateParam,
              'updateParam should change to correct value',
              ImageUpdateParamRemove(),
            ),
      );
    });
  });
}
