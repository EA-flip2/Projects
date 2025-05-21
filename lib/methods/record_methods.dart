import 'package:hive/hive.dart';

part 'record_methods.g.dart'; // MUST match file name

@HiveType(typeId: 0)
class Recording extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String filePath;
  @HiveField(2)
  String duration;
  @HiveField(3)
  String timestamp;
  @HiveField(4)
  bool favourite;

  Recording({
    required this.title,
    required this.filePath,
    required this.duration,
    required this.timestamp,
    required this.favourite,
  });
}
