import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:assets/models/asset_object.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql
      .getDatabasesPath(); //get database  directory of phone
  final db = await sql.openDatabase(
    path.join(dbPath, 'asset_data.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE asset_images(id TEXT PRIMARY KEY,tracker_image TEXT,sim_image TEXT,sim_alt TEXT)',
      );
    },
    version: 1,
  ); // get a database or create one in the phones database directory
  return db;
}

class AssetNotifier extends Notifier<List<AssetObject>> {
  @override
  List<AssetObject> build() {
    return [];
  }

  Future<void> debugPrintDbIds() async {
    final db = await _getDatabase();
    final rows = await db.query('asset_images', columns: ['id']);
    for (final row in rows) {
      debugPrint('DB ID: ${row['id']}');
    }
  }

  Future<void> clearDatabase() async {
    final db = await _getDatabase();

    await db.delete('asset_images');

    state = [];
  }

  Future<void> loadData() async {
    final db = await _getDatabase();
    final data = await db.query('asset_images');

    state = data
        .map(
          (item) => AssetObject.load(
            id: item['id'] as String,
            Tracker: AssetDataObject(
              description: 'image of tracker_imei',
              image: File(item['tracker_image'] as String),
            ),
            Sim: [
              AssetDataObject(
                image: File(item['sim_image'] as String),
                description: 'image of sim',
              ),
              if (item['sim_alt'] != null)
                AssetDataObject(
                  image: File(item['sim_alt'] as String),
                  description: 'image of sim',
                ),
            ],
          ),
        )
        .toList();
  }

  Future<void> removeAsset(String assetId) async {
    final db = await _getDatabase();
    final deletedRows = await db.delete(
      'asset_images',
      where: 'id = ?',
      whereArgs: [assetId],
    );

    state = state.where((asset) => asset.id != assetId).toList();
    // 3. DEBUG (important)
    // print('Deleted rows: $deletedRows for id=$assetId');
  }

  Future<String> _returnPath(File fileObject, Directory appDir) async {
    final filename = path.basename(fileObject.path);
    final copiedFile = await fileObject.copy(
      '${appDir.path}/$filename',
    );
    return copiedFile.path.toString();
  } // copy file to app directory and return path

  void addAsset(AssetObject newAsset) async {
    final appDir = await syspath
        .getApplicationDocumentsDirectory(); // get directory given to you app

    final db = await _getDatabase();

    final trackerPath = await _returnPath(newAsset.Tracker.image, appDir);
    final simPath = await _returnPath(newAsset.Sim[0].image, appDir);
    final simAltPath = newAsset.Sim.length > 1
        ? await _returnPath(newAsset.Sim[1].image, appDir)
        : null;

    await db.insert('asset_images', {
      'id': newAsset.id, // see next issue
      'tracker_image': trackerPath,
      'sim_image': simPath,
      'sim_alt': simAltPath,
    });

    state = [...state, newAsset];
  }
}

final assetRecordsProvider = NotifierProvider<AssetNotifier, List<AssetObject>>(
  AssetNotifier.new,
);
