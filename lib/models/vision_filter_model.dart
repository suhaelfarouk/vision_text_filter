// To parse this JSON data, do
//
//     final visionFilter = visionFilterFromJson(jsonString);

import 'dart:convert';

VisionFilter visionFilterFromJson(String str) =>
    VisionFilter.fromJson(json.decode(str));

String visionFilterToJson(VisionFilter data) => json.encode(data.toJson());

class VisionFilter {
  VisionFilter({
    required this.responses,
  });

  List<Response> responses;

  factory VisionFilter.fromJson(Map<String, dynamic> json) => VisionFilter(
        responses: List<Response>.from(
            json["responses"].map((x) => Response.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "responses": List<dynamic>.from(responses.map((x) => x.toJson())),
      };
}

class Response {
  Response({
    required this.safeSearchAnnotation,
  });

  SafeSearchAnnotation safeSearchAnnotation;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        safeSearchAnnotation:
            SafeSearchAnnotation.fromJson(json["safeSearchAnnotation"]),
      );

  Map<String, dynamic> toJson() => {
        "safeSearchAnnotation": safeSearchAnnotation.toJson(),
      };
}

class SafeSearchAnnotation {
  SafeSearchAnnotation({
    required this.adult,
    required this.spoof,
    required this.medical,
    required this.violence,
    required this.racy,
  });

  String adult;
  String spoof;
  String medical;
  String violence;
  String racy;

  factory SafeSearchAnnotation.fromJson(Map<String, dynamic> json) =>
      SafeSearchAnnotation(
        adult: json["adult"],
        spoof: json["spoof"],
        medical: json["medical"],
        violence: json["violence"],
        racy: json["racy"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "spoof": spoof,
        "medical": medical,
        "violence": violence,
        "racy": racy,
      };
}
