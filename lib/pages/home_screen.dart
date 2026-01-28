import 'dart:io';

import 'package:assets/pages/create_asset.dart';
import 'package:assets/tools/xcel_tools.dart';
import 'package:assets/widgets/assets_list.dart';
import 'package:assets/tools/upload_data.dart';
import 'package:flutter/material.dart';
import 'package:assets/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';

import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<void> _assetLoad;
  bool _isUploading = false;
  List<Map<String, String>> processed_data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _assetLoad = ref.read(assetRecordsProvider.notifier).loadData();
  }

  // definition of the dialog
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Alert!!"),
          content: const Text("Done"),
          actions: [
            MaterialButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void createAsset() {
    Navigator.of(
      context,
    ).push(
      MaterialPageRoute(
        builder: (ctx) => CreateAsset(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text("Asset Data"),
        actions: [
          IconButton(
            icon: Icon(Icons.upload),
            onPressed: () async {
              setState(() {
                _isUploading = true;
              });

              final uploadAssets = ref.read(assetRecordsProvider);
              processed_data = [];

              for (final asset in uploadAssets) {
                final response = await uploadAsset(asset);
                print(response.body);

                if (response.statusCode != 200) continue;

                final decoded =
                    jsonDecode(response.body) as Map<String, dynamic>;

                processed_data.add({
                  'tracker_imei': decoded['tracker_imei']?.toString() ?? '',
                  'asset_id': decoded['asset_id']?.toString() ?? '',
                  'sim_imei': decoded['sim_imei']?.toString() ?? '',
                  'phone': decoded['phone']?.toString() ?? '',
                });
              }

              setState(() {
                _isUploading = false;
                _showDialog(context);
              });
            },
          ),

          IconButton(
            icon: Icon(Icons.download),
            onPressed: () async {
              // 1️⃣ Create workbook
              final Workbook workbook = createWorkbookWithHeaders();
              final Worksheet sheet = workbook.worksheets[0];

              // 2️⃣ Append rows
              for (final data in processed_data) {
                appendRow(
                  sheet: sheet,
                  trackerImei: data['tracker_imei'] ?? '',
                  assetId: data['asset_id'] ?? '',
                  simImei: data['sim_imei'] ?? '',
                  simNumber: data['phone'] ?? '',
                );
              }

              //  Save workbook
              final File file = await saveWorkbook(workbook, 'assets.xlsx');

              //  Move to Downloads (optional)
              await moveFileToDownloads(file);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Excel exported to Downloads')),
              );
            },
          ),
        ],
      ),
      body: _isUploading
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder(
              future: _assetLoad,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return AssetsList();
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: createAsset,
        child: Icon(Icons.add),
      ),
    );
  }
}
// Widget build(BuildContext context,WidgetRef ref) 