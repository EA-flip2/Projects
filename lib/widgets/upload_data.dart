import 'package:assets/models/asset_object.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
// import 'package:path/path.dart';

Future<void> uploadAsset(AssetObject asset) async {
  final uri = Uri.parse(
    'https://n8n.srv1278199.hstgr.cloud/webhook/createAsset',
  );

  var request = http.MultipartRequest('POST', uri);

  String extension = p.extension(asset.Tracker.image.path);

  request.fields['description'] = asset.Tracker.description;
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
        filename: 'sim_dat$extension',
      ),
    );
  }

  try {
    final response = await request.send();

    if (response.statusCode == 200) {
      final body = await response.stream.bytesToString();
      print('✅ N8N Response: $body');
    } else {
      print('❌ Failed: ${response.statusCode}');
    }
  } catch (e) {
    print('❌ Error: $e');
  }
}
