// To parse this JSON data, do
//
//     final customerResponseModel = customerResponseModelFromJson(jsonString);

import 'dart:convert';

CustomerResponseModel customerResponseModelFromJson(String str) => CustomerResponseModel.fromJson(json.decode(str));

String customerResponseModelToJson(CustomerResponseModel data) => json.encode(data.toJson());

class CustomerResponseModel {
    CustomerResponseModel({
        this.status,
        this.message,
        this.returnObject,
    });

    final bool? status;
    final String? message;
    final List<CustomerReturnObject>? returnObject;

    factory CustomerResponseModel.fromJson(Map<String, dynamic> json) => CustomerResponseModel(
        status: json["status"],
        message: json["message"],
        returnObject: List<CustomerReturnObject>.from(json["returnObject"].map((x) => CustomerReturnObject.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "returnObject": List<dynamic>.from(returnObject!.map((x) => x.toJson())),
    };
}

class CustomerReturnObject {
    CustomerReturnObject({
        this.id,
        this.name,
        this.email,
        this.address,
        this.samplePointLocations,
    });

    final String? id;
    final String? name;
    final String? email;
    final String? address;
    final List<SamplePointLocation>? samplePointLocations;

    factory CustomerReturnObject.fromJson(Map<String, dynamic> json) => CustomerReturnObject(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        address: json["address"],
        samplePointLocations: List<SamplePointLocation>.from(json["samplePointLocations"].map((x) => SamplePointLocation.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "address": address,
        "samplePointLocations": List<dynamic>.from(samplePointLocations!.map((x) => x.toJson())),
    };
}

class SamplePointLocation {
    SamplePointLocation({
        this.sampleLocationId,
        this.name,
        this.description,
        this.fmenvSamples,
        this.dprSamples,
        this.nesreaSamples,
    });

    final int? sampleLocationId;
    final String? name;
    final String? description;
    final SampleTemplate? fmenvSamples;
    final SampleTemplate? dprSamples;
    final SampleTemplate? nesreaSamples;

    factory SamplePointLocation.fromJson(Map<String, dynamic> json) => SamplePointLocation(
        sampleLocationId: json["sampleLocationId"],
        name: json["name"],
        description: json["description"],
        fmenvSamples: SampleTemplate.fromJson(json["fmenvSamples"]),
        dprSamples: SampleTemplate.fromJson(json["dprSamples"]),
        nesreaSamples: SampleTemplate.fromJson(json["nesreaSamples"]),
    );

    Map<String, dynamic> toJson() => {
        "sampleLocationId": sampleLocationId,
        "name": name,
        "description": description,
        "fmenvSamples": fmenvSamples!.toJson(),
        "dprSamples": dprSamples!.toJson(),
        "nesreaSamples": nesreaSamples!.toJson(),
    };
}

class SampleTemplate {
    SampleTemplate({
        this.id,
        this.samplePointLocationId,
        this.name,
        this.dprSamples,
        this.fmenvSamples,
        this.nesreaSamples,
    });

    final int? id;
    final int? samplePointLocationId;
    final String? name;
    final List<Sample>? dprSamples;
    final List<Sample>? fmenvSamples;
    final List<Sample>? nesreaSamples;

    factory SampleTemplate.fromJson(Map<String, dynamic> json) => SampleTemplate(
        id: json["id"],
        samplePointLocationId: json["samplePointLocationId"],
        name: json["name"],
        dprSamples: json["dprSamples"] == null ? null : List<Sample>.from(json["dprSamples"].map((x) => Sample.fromJson(x))),
        fmenvSamples: json["fmenvSamples"] == null ? null : List<Sample>.from(json["fmenvSamples"].map((x) => Sample.fromJson(x))),
        nesreaSamples: json["nesreaSamples"] == null ? null : List<Sample>.from(json["nesreaSamples"].map((x) => Sample.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "samplePointLocationId": samplePointLocationId,
        "name": name,
        "dprSamples": dprSamples == null ? null : List<dynamic>.from(dprSamples!.map((x) => x.toJson())),
        "fmenvSamples": fmenvSamples == null ? null : List<dynamic>.from(fmenvSamples!.map((x) => x.toJson())),
        "nesreaSamples": nesreaSamples == null ? null : List<dynamic>.from(nesreaSamples!.map((x) => x.toJson())),
    };
}

class Sample {
    Sample({
        this.dprFieldId,
        this.id,
        this.testName,
        this.testUnit,
        this.testLimit,
        this.testResult,
        this.fmenvFieldId,
        this.nesreaFieldId,
    });

    final int? dprFieldId;
    final int? id;
    final String? testName;
    final String? testUnit;
    final String? testLimit;
    final String? testResult;
    final int? fmenvFieldId;
    final int? nesreaFieldId;

    factory Sample.fromJson(Map<String, dynamic> json) => Sample(
        dprFieldId: json["dprFieldId"] == null ? null : json["dprFieldId"],
        id: json["id"],
        testName: json["testName"],
        testUnit: json["testUnit"],
        testLimit: json["testLimit"],
        testResult: json["testResult"],
        fmenvFieldId: json["fmenvFieldId"] == null ? null : json["fmenvFieldId"],
        nesreaFieldId: json["nesreaFieldId"] == null ? null : json["nesreaFieldId"],
    );

    Map<String, dynamic> toJson() => {
        "dprFieldId": dprFieldId == null ? null : dprFieldId,
        "id": id,
        "testName": testName,
        "testUnit": testUnit,
        "testLimit": testLimit,
        "testResult": testResult,
        "fmenvFieldId": fmenvFieldId == null ? null : fmenvFieldId,
        "nesreaFieldId": nesreaFieldId == null ? null : nesreaFieldId,
    };
}
