import 'dart:io';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class AssetDataObject {
  AssetDataObject({required this.image, required this.description});
  final File image;
  final String description;
}

class AssetObject {
  AssetObject({
    required this.Tracker,
    required this.Sim,
  }) : id = uuid.v4();

  AssetObject.load({
    required this.Tracker,
    required this.Sim,
    required this.id,
  });

  final String id;
  final AssetDataObject Tracker;
  final List<AssetDataObject> Sim;
}
