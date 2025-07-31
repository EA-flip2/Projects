import 'package:hive/hive.dart';

part 'local_storage.g.dart';

// Message Object
@HiveType(typeId: 0)
class MessageStore extends HiveObject {
  @HiveField(0)
  String message;

  @HiveField(1)
  String groupID;

  @HiveField(2)
  String draftID;

  @HiveField(3)
  String messageID; //timestamp

  MessageStore({
    required this.message,
    required this.groupID,
    required this.draftID,
    required this.messageID,
  });
}

// Contact Object
@HiveType(typeId: 1)
class ContactStore extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String number;

  @HiveField(2)
  String groupID;

  @HiveField(3)
  String draftID;

  ContactStore({
    required this.name,
    required this.number,
    required this.groupID,
    required this.draftID,
  });
}

// Draft Object
@HiveType(typeId: 2)
class DraftStore extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String description;

  @HiveField(3)
  String groupID;

  @HiveField(4)
  String draftID;

  DraftStore({
    required this.name,
    required this.description,
    required this.groupID,
    required this.draftID,
  });
}

// Group Object
@HiveType(typeId: 3)
class GroupStore extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String description;

  @HiveField(3)
  String groupID;

  GroupStore({
    required this.name,
    required this.description,
    required this.groupID,
  });
}

// dart run build_runner build --delete-conflicting-outputs
