// To parse this JSON data, do
//
//     final fmenvResultActivitiesModel = fmenvResultActivitiesModelFromJson(jsonString);

import 'dart:convert';

List<FmenvResultActivitiesModel> fmenvResultActivitiesModelFromJson(String str) => List<FmenvResultActivitiesModel>.from(json.decode(str).map((x) => FmenvResultActivitiesModel.fromJson(x)));

String fmenvResultActivitiesModelToJson(List<FmenvResultActivitiesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FmenvResultActivitiesModel {
    FmenvResultActivitiesModel({
        this.id,
        this.samplePointLocationId,
        this.clientName,
        this.analystFullName,
        this.samplePointName,
        this.name,
        this.location,
        this.time,
        this.fmenvSamples,
        this.imageDetails,
    });

    final int? id;
    final int? samplePointLocationId;
    final String? clientName;
    final String? analystFullName;
    final String? samplePointName;
    final String? name;
    final Location? location;
    final DateTime? time;
    final List<FmenvSample>? fmenvSamples;
    final ImageDetails? imageDetails;

    factory FmenvResultActivitiesModel.fromJson(Map<String, dynamic> json) => FmenvResultActivitiesModel(
        id: json["id"],
        samplePointLocationId: json["samplePointLocationId"],
        clientName: json["clientName"],
        analystFullName: json["analystFullName"],
        samplePointName: json["samplePointName"],
        name: json["name"],
        location: Location.fromJson(json["location"]),
        time: DateTime.parse(json["time"]),
        fmenvSamples: List<FmenvSample>.from(json["fmenvSamples"].map((x) => FmenvSample.fromJson(x))),
        imageDetails: ImageDetails.fromJson(json["imageDetails"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "samplePointLocationId": samplePointLocationId,
        "clientName": clientName,
        "analystFullName": analystFullName,
        "samplePointName": samplePointName,
        "name": name,
        "location": location!.toJson(),
        "time": time!.toIso8601String(),
        "fmenvSamples": List<dynamic>.from(fmenvSamples!.map((x) => x.toJson())),
        "imageDetails": imageDetails!.toJson(),
    };
}

class FmenvSample {
    FmenvSample({
        this.fmenvFieldId,
        this.id,
        this.testName,
        this.testUnit,
        this.testLimit,
        this.testResult,
    });

    final int? fmenvFieldId;
    final int? id;
    final String? testName;
    final String? testUnit;
    final String? testLimit;
    final String? testResult;

    factory FmenvSample.fromJson(Map<String, dynamic> json) => FmenvSample(
        fmenvFieldId: json["fmenvFieldId"],
        id: json["id"],
        testName: json["testName"],
        testUnit: json["testUnit"],
        testLimit: json["testLimit"],
        testResult: json["testResult"],
    );

    Map<String, dynamic> toJson() => {
        "fmenvFieldId": fmenvFieldId,
        "id": id,
        "testName": testName,
        "testUnit": testUnit,
        "testLimit": testLimit,
        "testResult": testResult,
    };
}

class ImageDetails {
    ImageDetails({
        this.fullName,
        this.fileBase64,
    });

    final String? fullName;
    final String? fileBase64;

    factory ImageDetails.fromJson(Map<String, dynamic> json) => ImageDetails(
        fullName: json["fullName"],
        fileBase64: json["fileBase64"],
    );

    Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "fileBase64": fileBase64,
    };
}

class Location {
    Location({
        this.latitude,
        this.longitude,
    });
    final String? latitude;
    final String? longitude;
    factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"],
        longitude: json["longitude"],
    );
    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
    };
}
