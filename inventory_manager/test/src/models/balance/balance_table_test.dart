// import 'dart:math';
//
// import 'package:collection/collection.dart';
// import 'package:inventory_manager/inventory_manager.dart';
//
// import 'package:uuid/uuid.dart';
//
// void main() {
//   const rec1 = BalanceRecord(
//     income: 5,
//     outcome: 4,
//     reserve: 2,
//     pending: 7,
//   );
//
//   const rec2 = BalanceRecord(
//     income: 4,
//     outcome: 2,
//     reserve: 7,
//     pending: 3,
//   );
//
//   const expectedRec1and2Sum = BalanceRecord(
//     income: 9,
//     outcome: 6,
//     reserve: 9,
//     pending: 10,
//   );
//   const expectedRec1and2Sub = BalanceRecord(
//     income: 1,
//     outcome: 2,
//     reserve: -5,
//     pending: 4,
//   );
//
//   final dateNow = DateTime.now().toUtc();
//
//   group('Exception', () {
//     test('Should throw exception when add two balance row in same date', () {
//       final balTable = BalanceTable(id: const Uuid().v4());
//
//       final updBalTab = balTable.addRecord(
//         newRecord: rec1,
//         onDate: dateNow,
//         dateNow: dateNow,
//       );
//
//       expect(
//         () => updBalTab.addRecord(
//           newRecord: rec2,
//           onDate: dateNow,
//           dateNow: dateNow,
//         ),
//         throwsA(isA<ContainsManyBalanceRowInSameDateException>()),
//       );
//     });
//     test('Should throw exception when delete non-existent balance row ', () {
//       final balTable = BalanceTable(id: const Uuid().v4());
//       expect(
//         () => balTable.removeRecord(
//             record: rec1, onDate: dateNow, dateNow: dateNow),
//         throwsA(isA<RemoveRecordException>()),
//       );
//     });
//   });
//
//   group('Balance Table addRecord', () {
//     test('Should correct update current stats', () {
//       var balTable = BalanceTable(id: const Uuid().v4());
//
//       balTable = balTable.addRecord(newRecord: rec1, onDate: dateNow);
//       balTable = balTable.addRecord(
//         newRecord: rec2,
//         onDate: dateNow.add(const Duration(seconds: 1)),
//       );
//       expect(balTable.currentStats, expectedRec1and2Sum);
//     });
//     test('Should correct update recently stats', () {
//       var balTable = BalanceTable(id: const Uuid().v4());
//       final random = Random();
//       List<DateTime> dates = List.generate(20, (index) {
//         return DateTime(2018).add(Duration(
//           days: random.nextInt(1000),
//           hours: random.nextInt(10000),
//           minutes: random.nextInt(10000),
//         ));
//       });
//       for (final element in dates) {
//         balTable = balTable.addRecord(newRecord: rec1, onDate: element);
//       }
//       expect(
//         balTable.recentlyRecords.keys.toList(),
//         dates.sorted((a, b) => b.compareTo(a)).take(10).toList(),
//       );
//     });
//     test('Should correct update balance in some year', () {
//       var balTable = BalanceTable(id: const Uuid().v4());
//
//       const year = 2023;
//       balTable = balTable.addRecord(newRecord: rec1, onDate: DateTime(year, 1));
//       balTable = balTable.addRecord(newRecord: rec2, onDate: DateTime(year, 2));
//       expect(balTable.yearsStats[year], expectedRec1and2Sum);
//       // print(balTable);
//     });
//   });
//
//   group('Balance Table removeRecord', () {
//     test('Should correct update current stats', () {
//       var balTable = BalanceTable(id: const Uuid().v4());
//
//       balTable = balTable.addRecord(newRecord: rec1, onDate: dateNow);
//       balTable = balTable.addRecord(
//         newRecord: rec2,
//         onDate: dateNow.add(const Duration(seconds: 1)),
//       );
//       balTable = balTable.removeRecord(record: rec1, onDate: dateNow);
//       expect(balTable.currentStats, rec2);
//     });
//     test('Should correct update recently stats', () {
//       var balTable = BalanceTable(id: const Uuid().v4());
//       final random = Random();
//       // Create 20 random dates
//       List<DateTime> dates = List.generate(20, (index) {
//         return DateTime(2018).add(Duration(
//           days: random.nextInt(1000),
//           hours: random.nextInt(10000),
//           minutes: random.nextInt(10000),
//         ));
//       });
//
//       // Add 20 elements on created random dates
//       for (final element in dates) {
//         balTable = balTable.addRecord(
//           newRecord: rec1,
//           onDate: element,
//           dateNow: dateNow,
//         );
//       }
//       // take 10 recently dates
//       final recentlyDates =
//           dates.sorted((a, b) => b.compareTo(a)).take(10).toList();
//       // Get 5 random dates in recently dates
//
//       recentlyDates.shuffle();
//       final datesForRemoved = recentlyDates.take(5).toList();
//       recentlyDates.removeRange(0, 5);
//       final datesForExpect = recentlyDates;
//       for (final date in datesForRemoved) {
//         balTable =
//             balTable.removeRecord(record: rec1, onDate: date, dateNow: dateNow);
//       }
//       expect(
//         balTable.recentlyRecords.keys.toList(),
//         containsAll(datesForExpect),
//       );
//     });
//     test('Should correct update balance in some year', () {
//       var balTable = BalanceTable(id: const Uuid().v4());
//
//       final year = dateNow.year;
//       final date1 = DateTime(year, 1);
//       final date2 = DateTime(year, 2);
//       balTable = balTable.addRecord(newRecord: rec1, onDate: date1);
//       balTable = balTable.addRecord(newRecord: rec2, onDate: date2);
//       balTable =
//           balTable.removeRecord(record: rec1, onDate: date1, dateNow: dateNow);
//
//       expect(balTable.yearsStats[year], rec2);
//       // print(balTable);
//     });
//   });
// }
