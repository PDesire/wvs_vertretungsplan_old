import 'dart:convert';

import 'Result.dart';

class DsbNextModel {
  int responseTime;
  List<Result> result;

  DsbNextModel({
    this.responseTime,
    this.result,
  });

  factory DsbNextModel.fromRawJson(String str) => DsbNextModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DsbNextModel.fromJson(Map<String, dynamic> json) => DsbNextModel(
    responseTime: json["responseTime"] == null ? null : json["responseTime"],
    result: json["result"] == null ? null : List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "responseTime": responseTime == null ? null : responseTime,
    "result": result == null ? null : List<dynamic>.from(result.map((x) => x.toJson())),
  };
}