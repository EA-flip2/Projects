import 'package:assets/models/asset_object.dart';
import 'package:assets/tools/upload_data.dart';
import 'package:flutter/material.dart';

class EditAsset extends StatefulWidget {
  const EditAsset({super.key, required this.asset});
  final AssetObject asset;

  @override
  State<EditAsset> createState() => _EditAssetState();
}

class _EditAssetState extends State<EditAsset> {
  @override
  Widget build(BuildContext context) {
    bool sent = false;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                widget.asset.assetId.image,
                fit: BoxFit.fitWidth,
                height: 300,
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                widget.asset.Tracker.image,
                fit: BoxFit.fitWidth,
                height: 300,
                width: double.infinity,
              ),
            ),

            SizedBox(
              height: 10,
            ),
            ...widget.asset.Sim.map((data) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  data.image,
                  fit: BoxFit.fitWidth,
                  height: 300,
                  width: double.infinity,
                ),
              );
            }),

            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: sent
                  // ignore: dead_code
                  ? null
                  : () {
                      setState(() => sent = true);
                      uploadAsset(widget.asset);
                    },
              child: sent ? Icon(Icons.done) : Icon(Icons.upload),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
