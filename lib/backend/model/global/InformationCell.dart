import 'dart:convert';

class InformationCell {
  String date;
  String time;
  String day;
  String schoolClassBefore;
  String lessonBefore;
  String roomBefore;
  String type;
  String representative;
  String lessonAfter;
  String roomAfter;
  String text;
  bool cancelled;

  InformationCell({
    this.date,
    this.time,
    this.day,
    this.schoolClassBefore,
    this.lessonBefore,
    this.roomBefore,
    this.type,
    this.representative,
    this.lessonAfter,
    this.roomAfter,
    this.text,
    this.cancelled,
  });

  factory InformationCell.fromRawJson(String str) => InformationCell.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InformationCell.fromJson(Map<String, dynamic> json) => InformationCell(
    date: json["date"] == null ? null : json["date"],
    time: json["time"] == null ? null : json["time"],
    day: json["day"] == null ? null : json["day"],
    schoolClassBefore: json["school_class_before"] == null ? null : json["school_class_before"],
    lessonBefore: json["lesson_before"] == null ? null : json["lesson_before"],
    roomBefore: json["room_before"] == null ? null : json["room_before"],
    type: json["type"] == null ? null : json["type"],
    representative: json["representative"] == null ? null : json["representative"],
    lessonAfter: json["lesson_after"] == null ? null : json["lesson_after"],
    roomAfter: json["room_after"] == null ? null : json["room_after"],
    text: json["text"] == null ? null : json["text"],
    cancelled: json["cancelled"] == null ? null : json["cancelled"],
  );

  Map<String, dynamic> toJson() => {
    "date": date == null ? null : date,
    "time": time == null ? null : time,
    "day": day == null ? null : day,
    "school_class_before": schoolClassBefore == null ? null : schoolClassBefore,
    "lesson_before": lessonBefore == null ? null : lessonBefore,
    "room_before": roomBefore == null ? null : roomBefore,
    "type": type == null ? null : type,
    "representative": representative == null ? null : representative,
    "lesson_after": lessonAfter == null ? null : lessonAfter,
    "room_after": roomAfter == null ? null : roomAfter,
    "text": text == null ? null : text,
    "cancelled": cancelled == null ? null : cancelled,
  };
}