// To parse this JSON data, do
//
//     final runSimpleTestResponseModel = runSimpleTestResponseModelFromJson(jsonString);

import 'dart:convert';

RunSimpleTestResponseModel runSimpleTestResponseModelFromJson(String str) => RunSimpleTestResponseModel.fromJson(json.decode(str));

String runSimpleTestResponseModelToJson(RunSimpleTestResponseModel data) => json.encode(data.toJson());

class RunSimpleTestResponseModel {
    RunSimpleTestResponseModel({
        this.status,
        this.message,
        this.returnObject,
    });

    final bool? status;
    final String? message;
    final String? returnObject;

    factory RunSimpleTestResponseModel.fromJson(Map<String, dynamic> json) => RunSimpleTestResponseModel(
        status: json["status"],
        message: json["message"],
        returnObject: json["returnObject"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "returnObject": returnObject,
    };
}
