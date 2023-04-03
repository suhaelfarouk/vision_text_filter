import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

import '../models/vision_filter_model.dart';

class VisionFilterProvider extends ChangeNotifier {
  VisionFilter? visionFilterModel;
  File? _imageFile;
  String? _uploadedImageUrl;

  File? get imageFile => _imageFile;
  String? get uploadedImageUrl => _uploadedImageUrl;

  Future<void> pickImage() async {
    //clear previous image
    _imageFile = null;
    _uploadedImageUrl = null;
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _imageFile = pickedFile != null ? File(pickedFile.path) : null;
    notifyListeners();
  }

  Future<void> fetchVisionData() async {
    var apiKey = dotenv.env['GOOGLE_API_SERVICE_KEY'];
    var url = 'https://vision.googleapis.com/v1/images:annotate?key=$apiKey';

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };

    var data = {
      'parent': '',
      'requests': [
        {
          'image': {
            'source': {'imageUri': '$_uploadedImageUrl'}
          },
          'features': [
            {'type': 'SAFE_SEARCH_DETECTION'}
          ]
        }
      ]
    };

    var response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) {
      visionFilterModel = visionFilterFromJson(response.body);
    } else {
      debugPrint('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> uploadImage() async {
    if (_imageFile == null) {
      return;
    }
    final fileName = path.basename(_imageFile!.path);
    var accessToken = dotenv.env['GOOGLE_OAUTH_ACCESS_TOKEN'];
    const bucketName = 'profanity-382504';
    final url =
        'https://storage.googleapis.com/upload/storage/v1/b/$bucketName/o?uploadType=media&name=$fileName';
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };

    final response = await http.post(Uri.parse(url),
        headers: headers, body: await _imageFile!.readAsBytes());
    if (response.statusCode == 200) {
      String json = response.body;
      Map<String, dynamic> jsonObject = jsonDecode(json);
      String mediaLink = jsonObject['mediaLink'];
      _uploadedImageUrl = mediaLink;
    } else {
      debugPrint('Upload failed with status: ${response.statusCode}');
    }
    await fetchVisionData();
    notifyListeners();
  }
}
