import 'package:assets/models/asset_object.dart';
import 'package:assets/pages/edit_asset.dart';
import 'package:flutter/material.dart';

class AssetTile extends StatefulWidget {
  const AssetTile({
    super.key,
    required this.assetObject,
  });
  final AssetObject assetObject;

  @override
  State<AssetTile> createState() => _AssetTileState();
}

class _AssetTileState extends State<AssetTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        Navigator.of(
          context,
        ).push(
          MaterialPageRoute(
            builder: (ctx) => EditAsset(asset: widget.assetObject),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Container(
          height: 100,
          width: double.infinity,
          child: Row(
            children: [
              Text('Asset Number'),
              SizedBox(
                width: 10,
              ),
              Text('Tracker Imei'),
              SizedBox(
                width: 10,
              ),
              Text('Sim Imei'),
              SizedBox(
                width: 10,
              ),
              Text('Phone'),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
