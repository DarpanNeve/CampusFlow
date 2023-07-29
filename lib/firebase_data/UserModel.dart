class UserModel {
  String? id;
  String? name;
  String? email;
  String? prn;
  String? rollNo;
  String? division;
  String? branch;

  UserModel.fromJson(dynamic json) {
    id = json["ID"].toString();
    name = json["Name"];
    email = json["Email"];
    prn = json["Prn"];
    rollNo = json["Roll No"];
    division = json["Division"];
    branch = json["Branch"];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data["ID"] = id;
    _data["Name"] = name;
    _data["Email"] = email;
    _data["Prn"] = prn;
    _data["Roll No"] = rollNo;
    _data["Division"] = division;
    _data["Branch"] = branch;
    return _data;
  }
}