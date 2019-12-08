import 'dart:convert';

import 'package:wvs_plan/backend/model/global/InformationCell.dart';

class Result {
  String date;
  List<InformationCell> data;

  Result({
    this.date,
    this.data,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    date: json["date"] == null ? null : json["date"],
    data: json["data"] == null ? null : List<InformationCell>.from(json["data"].map((x) => InformationCell.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date == null ? null : date,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}