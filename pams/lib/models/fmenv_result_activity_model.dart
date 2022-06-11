// To parse this JSON data, do
//
//     final fmenResultActivitiesModel = fmenResultActivitiesModelFromJson(jsonString);

import 'dart:convert';

FmenResultActivitiesModel fmenResultActivitiesModelFromJson(String str) => FmenResultActivitiesModel.fromJson(json.decode(str));

String fmenResultActivitiesModelToJson(FmenResultActivitiesModel data) => json.encode(data.toJson());

class FmenResultActivitiesModel {
    FmenResultActivitiesModel({
        this.status,
        this.message,
        this.returnObject,
    });

    final bool? status;
    final String? message;
    final List<ReturnObject>? returnObject;

    factory FmenResultActivitiesModel.fromJson(Map<String, dynamic> json) => FmenResultActivitiesModel(
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
    final dynamic imageDetails;

    factory ReturnObject.fromJson(Map<String, dynamic> json) => ReturnObject(
        id: json["id"],
        samplePointLocationId: json["samplePointLocationId"],
        clientName: json["clientName"],
        analystFullName: json["analystFullName"],
        samplePointName: json["samplePointName"],
        name: json["name"],
        location: Location.fromJson(json["location"]),
        time: DateTime.parse(json["time"]),
        fmenvSamples: List<FmenvSample>.from(json["fmenvSamples"].map((x) => FmenvSample.fromJson(x))),
        imageDetails: json["imageDetails"],
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
        "imageDetails": imageDetails,
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
