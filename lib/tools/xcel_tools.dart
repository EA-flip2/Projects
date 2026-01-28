import 'dart:io';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

/// Creates a new Excel file with headers and saves it
// Future<File> createExcelFile() async {
//   final Workbook workbook = Workbook();
//   final Worksheet sheet = workbook.worksheets[0];

//   // Headers
//   sheet.getRangeByIndex(1, 1).setText('Tracker_IMEI');
//   sheet.getRangeByIndex(1, 2).setText('SIM_IMEI');
//   sheet.getRangeByIndex(1, 3).setText('SIM_NUMBER');

//   return _saveWorkbook(workbook, 'assets.xlsx');
// }

Workbook createWorkbookWithHeaders() {
  final Workbook workbook = Workbook();
  final Worksheet sheet = workbook.worksheets[0];

  sheet.getRangeByIndex(1, 1).setText('Tracker_IMEI');
  sheet.getRangeByIndex(1, 2).setText('ASSET_ID');
  sheet.getRangeByIndex(1, 3).setText('SIM_IMEI');
  sheet.getRangeByIndex(1, 4).setText('SIM_NUMBER');

  return workbook;
}

// /// Inserts a row of data into an existing workbook
// void insertDataRow({
//   required Worksheet sheet,
//   required int rowIndex,
//   required String trackerImei,
//   required String simImei,
//   required String simNumber,
// }) {
//   sheet.getRangeByIndex(rowIndex, 1).setText(trackerImei);
//   sheet.getRangeByIndex(rowIndex, 2).setText(simImei);
//   sheet.getRangeByIndex(rowIndex, 3).setText(simNumber);
// }

void appendRow({
  required Worksheet sheet,
  required String trackerImei,
  required String assetId,
  required String simImei,
  required String simNumber,
}) {
  // Find next empty row
  final int nextRow = sheet.getLastRow() + 1;

  sheet.getRangeByIndex(nextRow, 1).setText(trackerImei);
  sheet.getRangeByIndex(nextRow, 2).setText(assetId);
  sheet.getRangeByIndex(nextRow, 3).setText(simImei);
  sheet.getRangeByIndex(nextRow, 4).setText(simNumber);
}

/// Saves workbook to app support directory
Future<File> saveWorkbook(Workbook workbook, String fileName) async {
  final List<int> bytes = workbook.saveAsStream();
  workbook.dispose();

  final String path = (await getApplicationDocumentsDirectory()).path;
  final File file = File('$path/$fileName');

  await file.writeAsBytes(bytes, flush: true);
  return file;
}

// Future<File> moveFileToDownloads(File file) async {
//   final Directory? downloadsDir = await getDownloadsDirectory();

//   if (downloadsDir == null) {
//     throw Exception('Downloads directory not available');
//   }

//   final String newPath = p.join(downloadsDir.path, p.basename(file.path));
//   print('Saved to: $newPath');

//   return file.copy(newPath);
// }

Future<File> moveFileToDownloads(File file) async {
  final Directory downloads = Directory('/storage/emulated/0/Download');

  if (!await downloads.exists()) {
    throw Exception('Downloads folder not found');
  }

  final String newPath = p.join(downloads.path, p.basename(file.path));
  print('Saved to: $newPath');
  return file.copy(newPath);
}

//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 open_router key
