import 'package:assets/models/asset_object.dart';
import 'package:assets/provider.dart';
import 'package:assets/widgets/image_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateAsset extends ConsumerStatefulWidget {
  const CreateAsset({super.key});

  @override
  ConsumerState<CreateAsset> createState() => _CreateAssetState();
}

class _CreateAssetState extends ConsumerState<CreateAsset> {
  Map<String, AssetDataObject> assetData = {}; //simimei, tracker, phone
  bool isChecked = false;

  void passedData(String mapKey, AssetDataObject asset) {
    assetData[mapKey] = asset;
  }

  void save() {
    final newAssetObject = AssetObject(
      Tracker: assetData['tracker']!,
      Sim: [
        assetData['sim_imei']!,
        if (assetData.containsKey('sim_data')) assetData['sim_data']!,
      ],

      assetId: assetData['assetId']!,
    );
    ref.read(assetRecordsProvider.notifier).addAsset(newAssetObject);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Asset'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ImageBox(
              mapKey: "assetId",
              passImage: passedData,
              description: "Picture of Asset Number",
            ),
            SizedBox(
              height: 16,
            ),
            ImageBox(
              mapKey: "tracker",
              passImage: passedData,
              description: "Picture of Tracker IMEI",
            ),
            SizedBox(height: 16),
            ImageBox(
              mapKey: "sim_imei",
              passImage: passedData,
              description: "Picture of SIM",
            ),

            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                ),
                const Text('Add extra data'),
              ],
            ),

            //  Conditional widget
            if (isChecked)
              ImageBox(
                mapKey: "sim_data",
                passImage: passedData,
                description: "Picture of SIM (extra data)",
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"),
                ),
                SizedBox(width: 30),
                ElevatedButton(
                  onPressed: () {
                    save();
                    Navigator.of(context).pop();
                  },
                  child: Text("Save"),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
