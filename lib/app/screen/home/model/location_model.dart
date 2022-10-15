class LocationResponse {
  LocationResponse({
    this.features,
  });

  List<Feature>? features;

  factory LocationResponse.fromJson(Map<String, dynamic> json) =>
      LocationResponse(
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "features": List<dynamic>.from(features!.map((x) => x.toJson())),
      };
}

class Feature {
  Feature({
    this.placeName,
    this.context,
  });

  String? placeName;
  List<Context>? context;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        placeName: json["place_name"],
        context:
            List<Context>.from(json["context"].map((x) => Context.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "place_name": placeName,
        "context": List<dynamic>.from(context!.map((x) => x.toJson())),
      };
}

class Context {
  Context({
    this.text,
  });

  String? text;

  factory Context.fromJson(Map<String, dynamic> json) => Context(
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
      };
}
