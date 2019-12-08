import 'dart:convert';

import 'package:wvs_plan/backend/model/global/InformationCell.dart';

class DsbTodayModel {
  int responseTime;
  List<InformationCell> result;

  DsbTodayModel({
    this.responseTime,
    this.result,
  });

  factory DsbTodayModel.fromRawJson(String str) => DsbTodayModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DsbTodayModel.fromJson(Map<String, dynamic> json) => DsbTodayModel(
    responseTime: json["responseTime"] == null ? null : json["responseTime"],
    result: json["result"] == null ? null : List<InformationCell>.from(json["result"].map((x) => InformationCell.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "responseTime": responseTime == null ? null : responseTime,
    "result": result == null ? null : List<dynamic>.from(result.map((x) => x.toJson())),
  };
}