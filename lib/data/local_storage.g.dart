// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_storage.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageStoreAdapter extends TypeAdapter<MessageStore> {
  @override
  final int typeId = 0;

  @override
  MessageStore read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessageStore(
      message: fields[0] as String,
      groupID: fields[1] as String,
      draftID: fields[2] as String,
      messageID: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MessageStore obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.groupID)
      ..writeByte(2)
      ..write(obj.draftID)
      ..writeByte(3)
      ..write(obj.messageID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageStoreAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ContactStoreAdapter extends TypeAdapter<ContactStore> {
  @override
  final int typeId = 1;

  @override
  ContactStore read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContactStore(
      name: fields[0] as String,
      number: fields[1] as String,
      groupID: fields[2] as String,
      draftID: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ContactStore obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.groupID)
      ..writeByte(3)
      ..write(obj.draftID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactStoreAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DraftStoreAdapter extends TypeAdapter<DraftStore> {
  @override
  final int typeId = 2;

  @override
  DraftStore read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DraftStore(
      name: fields[0] as String,
      description: fields[1] as String,
      groupID: fields[3] as String,
      draftID: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DraftStore obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.groupID)
      ..writeByte(4)
      ..write(obj.draftID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DraftStoreAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GroupStoreAdapter extends TypeAdapter<GroupStore> {
  @override
  final int typeId = 3;

  @override
  GroupStore read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GroupStore(
      name: fields[0] as String,
      description: fields[1] as String,
      groupID: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GroupStore obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.groupID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupStoreAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
