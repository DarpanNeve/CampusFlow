class RoommateModel {
  late String iD;
  late String name;
  late String message;
  late String timestamp;
  late String docs;

  RoommateModel(
      {required this.iD,
      required this.name,
      required this.message,
      required this.timestamp,
      required this.docs});

  RoommateModel.fromJson(dynamic json) {
    iD = json['ID'];
    name = json['Name'];
    message = json['Message'];
    timestamp = json['Timestamp'];
    docs = json['Docs'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ID'] = iD;
    data['Name'] = name;
    data['Message'] = message;
    data['Timestamp'] = timestamp;
    data['Doc_1'] = docs;
    return data;
  }
}
