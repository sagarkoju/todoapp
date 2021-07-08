import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 0)
class Transaction extends HiveObject {
  @HiveField(0)
  final String? title;
  @HiveField(1)
  final String? detail;
  @HiveField(2)
  final DateTime? createdDate;
  @HiveField(3)
  final double? amount;

  Transaction({
    this.title,
    this.detail,
    this.createdDate,
    this.amount,
  });
}
