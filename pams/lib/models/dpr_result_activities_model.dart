// To parse this JSON data, do
//
//     final dprResultActivitiesModel = dprResultActivitiesModelFromJson(jsonString);

import 'dart:convert';

DprResultActivitiesModel dprResultActivitiesModelFromJson(String str) => DprResultActivitiesModel.fromJson(json.decode(str));

String dprResultActivitiesModelToJson(DprResultActivitiesModel data) => json.encode(data.toJson());

class DprResultActivitiesModel {
    DprResultActivitiesModel({
        this.status,
        this.message,
        this.returnObject,
    });

    final bool? status;
    final String? message;
    final List<ReturnObject>? returnObject;

    factory DprResultActivitiesModel.fromJson(Map<String, dynamic> json) => DprResultActivitiesModel(
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
        this.dprSamples,
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
    final List<DprSample>? dprSamples;
    final dynamic imageDetails;

    factory ReturnObject.fromJson(Map<String, dynamic> json) => ReturnObject(
        id: json["id"],
        samplePointLocationId: json["samplePointLocationId"],
        analystFullName: json["analystFullName"],
        clientName: json["clientName"],
        samplePointName: json["samplePointName"],
        name: json["name"],
        location: Location.fromJson(json["location"]),
        time: DateTime.parse(json["time"]),
        dprSamples: List<DprSample>.from(json["dprSamples"].map((x) => DprSample.fromJson(x))),
        imageDetails: json["imageDetails"],
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
        "dprSamples": List<dynamic>.from(dprSamples!.map((x) => x.toJson())),
        "imageDetails": imageDetails,
    };
}

class DprSample {
    DprSample({
        this.dprFieldId,
        this.id,
        this.testName,
        this.testUnit,
        this.testLimit,
        this.testResult,
    });

    final int? dprFieldId;
    final int? id;
    final String? testName;
    final String? testUnit;
    final String? testLimit;
    final String? testResult;

    factory DprSample.fromJson(Map<String, dynamic> json) => DprSample(
        dprFieldId: json["dprFieldId"],
        id: json["id"],
        testName: json["testName"],
        testUnit: json["testUnit"],
        testLimit: json["testLimit"],
        testResult: json["testResult"],
    );

    Map<String, dynamic> toJson() => {
        "dprFieldId": dprFieldId,
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
