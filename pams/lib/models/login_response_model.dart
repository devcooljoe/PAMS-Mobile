// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
    LoginResponseModel({
        this.status,
        this.message,
        this.returnObject,
    });

    final bool? status;
    final String? message;
    final ReturnObject? returnObject;

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        status: json["status"],
        message: json["message"],
        returnObject: ReturnObject.fromJson(json["returnObject"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "returnObject": returnObject!.toJson(),
    };
}

class ReturnObject {
    ReturnObject({
        this.email,
        this.fullname,
        this.role,
        this.userId,
        this.token,
        this.expiryTime,
        this.totalAmountInvoiced,
        this.totalCustomers,
        this.invoices,
        this.imageDetails,
    });

    final String? email;
    final String? fullname;
    final List<String>? role;
    final String? userId;
    final String? token;
    final DateTime? expiryTime;
    final int? totalAmountInvoiced;
    final int? totalCustomers;
    final List<Invoice>? invoices;
    final ImageDetails? imageDetails;

    factory ReturnObject.fromJson(Map<String, dynamic> json) => ReturnObject(
        email: json["email"],
        fullname: json["fullname"],
        role: List<String>.from(json["role"].map((x) => x)),
        userId: json["userId"],
        token: json["token"],
        expiryTime: DateTime.parse(json["expiryTime"]),
        totalAmountInvoiced: json["totalAmountInvoiced"],
        totalCustomers: json["totalCustomers"],
        invoices: List<Invoice>.from(json["invoices"].map((x) => Invoice.fromJson(x))),
        imageDetails: ImageDetails.fromJson(json["imageDetails"]),
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "fullname": fullname,
        "role": List<dynamic>.from(role!.map((x) => x)),
        "userId": userId,
        "token": token,
        "expiryTime": expiryTime!.toIso8601String(),
        "totalAmountInvoiced": totalAmountInvoiced,
        "totalCustomers": totalCustomers,
        "invoices": List<dynamic>.from(invoices!.map((x) => x.toJson())),
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

class Invoice {
    Invoice({
        this.companyName,
        this.contactPerson,
        this.amountDue,
        this.status,
        this.invoiceId,
    });

    final String? companyName;
    final String? contactPerson;
    final int? amountDue;
    final String? status;
    final String? invoiceId;

    factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        companyName: json["companyName"],
        contactPerson: json["contactPerson"],
        amountDue: json["amountDue"],
        status: json["status"],
        invoiceId: json["invoiceId"],
    );

    Map<String, dynamic> toJson() => {
        "companyName": companyName,
        "contactPerson": contactPerson,
        "amountDue": amountDue,
        "status": status,
        "invoiceId": invoiceId,
    };
}
