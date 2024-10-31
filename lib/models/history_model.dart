import 'package:hive/hive.dart';

part 'history_model.g.dart';

@HiveType(typeId: 0)
class HistoryModel extends HiveObject {
  @HiveField(0)
  final String input;
  @HiveField(1)
  final String output;

  HistoryModel({required this.input, required this.output});
}
