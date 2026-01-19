import 'package:assets/pages/create_asset.dart';
import 'package:assets/widgets/assets_list.dart';
import 'package:assets/widgets/upload_data.dart';
import 'package:flutter/material.dart';
import 'package:assets/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<void> _assetLoad;
  bool _isUploading = false;

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

              for (final asset in uploadAssets) {
                await uploadAsset(asset);
              }

              setState(() {
                _isUploading = false;
                _showDialog(context);
              });
            },
          ),

          IconButton(
            onPressed: () {
              // ref.read(assetRecordsProvider.notifier).clearDatabase();
            },
            icon: Icon(Icons.download),
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