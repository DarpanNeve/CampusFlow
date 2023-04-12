class Model {
  late String day;
  late String division;
  late String start;
  late String end;
  late String subject;
  late String batch;
  late String classroom;
  late String teacher;
  late String type;
  Model({

      required this.day,

      required this.division,

      required this.start,

      required this.end,

      required this.subject,

      required this.batch,

      required this.classroom,

      required this.teacher,

      required this.type,});

  Model.fromJson(dynamic json) {

    day = json['Day'];
    division = json['Division'];
    start = json['Start'];
    end = json['End'];
    subject = json['Subject'];
    batch = json['Batch'];
    classroom = json['Classroom'];
    teacher = json['Teacher'];
    type = json['Type'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Day'] = day;
    map['Division'] = division;
    map['Start'] = start;
    map['End'] = end;
    map['Subject'] = subject;
    map['Batch'] = batch;
    map['Classroom'] = classroom;
    map['Teacher'] = teacher;
    map['Type'] = type;
    return map;
  }

}