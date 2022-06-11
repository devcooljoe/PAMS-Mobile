// To parse this JSON data, do
//
//     final nesreaResultActivitiesModel = nesreaResultActivitiesModelFromJson(jsonString);

import 'dart:convert';

NesreaResultActivitiesModel nesreaResultActivitiesModelFromJson(String str) => NesreaResultActivitiesModel.fromJson(json.decode(str));

String nesreaResultActivitiesModelToJson(NesreaResultActivitiesModel data) => json.encode(data.toJson());

class NesreaResultActivitiesModel {
    NesreaResultActivitiesModel({
        this.status,
        this.message,
        this.returnObject,
    });

    final bool? status;
    final String? message;
    final List<ReturnObject>? returnObject;

    factory NesreaResultActivitiesModel.fromJson(Map<String, dynamic> json) => NesreaResultActivitiesModel(
        status: json["status"],
        message: json["message"],
        returnObject: List<ReturnObject>.from(json["returnObject"].map((x) => ReturnObject.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "returnObject": List<dynamic>.from(returnObject!.map((x) => x.toJson())),
    };
}

class ReturnObject {
    ReturnObject({
        this.id,
        this.samplePointLocationId,
        this.analystFullName,
        this.clientName,
        this.samplePointName,
        this.name,
        this.location,
        this.time,
        this.nesreaSamples,
        this.imageDetails,
    });

    final int? id;
    final int? samplePointLocationId;
    final String? analystFullName;
    final String? clientName;
    final String? samplePointName;
    final String? name;
    final Location? location;
    final DateTime? time;
    final List<NesreaSample>? nesreaSamples;
    final ImageDetails? imageDetails;

    factory ReturnObject.fromJson(Map<String, dynamic> json) => ReturnObject(
        id: json["id"],
        samplePointLocationId: json["samplePointLocationId"],
        analystFullName: json["analystFullName"],
        clientName: json["clientName"],
        samplePointName: json["samplePointName"],
        name: json["name"],
        location: Location.fromJson(json["location"]),
        time: DateTime.parse(json["time"]),
        nesreaSamples: List<NesreaSample>.from(json["nesreaSamples"].map((x) => NesreaSample.fromJson(x))),
        imageDetails: ImageDetails.fromJson(json["imageDetails"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "samplePointLocationId": samplePointLocationId,
        "analystFullName": analystFullName,
        "clientName": clientName,
        "samplePointName": samplePointName,
        "name": name,
        "location": location!.toJson(),
        "time": time!.toIso8601String(),
        "nesreaSamples": List<dynamic>.from(nesreaSamples!.map((x) => x.toJson())),
        "imageDetails": imageDetails!.toJson(),
    };
}

class ImageDetails {
    ImageDetails({
        this.fullName,
        this.fileBase64,
    });

    final dynamic fullName;
    final dynamic fileBase64;

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

class NesreaSample {
    NesreaSample({
        this.nesreaFieldId,
        this.id,
        this.testName,
        this.testUnit,
        this.testLimit,
        this.testResult,
    });

    final int? nesreaFieldId;
    final int? id;
    final String? testName;
    final String? testUnit;
    final String? testLimit;
    final String? testResult;

    factory NesreaSample.fromJson(Map<String, dynamic> json) => NesreaSample(
        nesreaFieldId: json["nesreaFieldId"],
        id: json["id"],
        testName: json["testName"],
        testUnit: json["testUnit"],
        testLimit: json["testLimit"],
        testResult: json["testResult"],
    );

    Map<String, dynamic> toJson() => {
        "nesreaFieldId": nesreaFieldId,
        "id": id,
        "testName": testName,
        "testUnit": testUnit,
        "testLimit": testLimit,
        "testResult": testResult,
    };
}
