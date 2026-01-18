import 'package:assets/models/asset_object.dart';
import 'package:assets/provider.dart';
import 'package:assets/widgets/assetTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssetsList extends ConsumerStatefulWidget {
  const AssetsList({super.key});

  @override
  ConsumerState<AssetsList> createState() => _AssetsListState();
}

class _AssetsListState extends ConsumerState<AssetsList> {
  Future<void> _deleteAsset(AssetObject thisAsset) async {
    await ref.read(assetRecordsProvider.notifier).removeAsset(thisAsset.id);
    // print('Asset Deleted');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final messenger = ScaffoldMessenger.of(context);

      messenger.removeCurrentSnackBar();

      messenger.showSnackBar(
        SnackBar(
          content: const Text('Asset deleted'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              ref.read(assetRecordsProvider.notifier).addAsset(thisAsset);
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final assetsList = ref.watch(assetRecordsProvider);

    if (assetsList.isEmpty) {
      return Center(
        child: Text("No asset addded"),
      );
    }

    return ListView.builder(
      itemCount: assetsList.length,
      itemBuilder: (ctx, index) {
        return Dismissible(
          onDismissed: (direction) {
            _deleteAsset(assetsList[index]);
          },
          key: ValueKey(assetsList[index].id),

          background: Container(
            color: Colors.grey,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),

          child: AssetTile(assetObject: assetsList[index]),
        );
      },
    );
  }
}
