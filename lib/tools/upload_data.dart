import 'package:assets/models/asset_object.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
// import 'package:path/path.dart';

Future<({int statusCode, String body})> uploadAsset(AssetObject asset) async {
  final uri = Uri.parse(
    'https://n8n.srv1278199.hstgr.cloud/webhook/clould-vision',
  );

  var request = http.MultipartRequest('POST', uri);

  String extension = p.extension(asset.Tracker.image.path);

  request.fields['description'] = asset.Tracker.description;
  request.files.add(
    await http.MultipartFile.fromPath(
      asset.assetId.description, // assetId
      asset.assetId.image.path,
      filename: 'asset_id$extension',
    ),
  );

  extension = p.extension(asset.assetId.image.path);
  request.files.add(
    await http.MultipartFile.fromPath(
      asset.Tracker.description, // Tracker
      asset.Tracker.image.path,
      filename: 'tracker_imei$extension',
    ),
  );

  for (final simfile in asset.Sim) {
    extension = p.extension(simfile.image.path);
    request.fields['description'] = "Sim_Card";
    request.files.add(
      await http.MultipartFile.fromPath(
        'Sim_Card', // Tracker
        simfile.image.path,
        filename: 'sim_data$extension',
      ),
    );
  }

  final response = await request.send();
  final body = await response.stream.bytesToString();

  return (
    statusCode: response.statusCode,
    body: body,
  );
}
