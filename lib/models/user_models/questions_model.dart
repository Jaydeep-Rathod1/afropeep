class QuestionsModel {
  int qId;
  String qName;
  String createdAt;
  String updatedAt;

  QuestionsModel({this.qId, this.qName, this.createdAt, this.updatedAt});

  QuestionsModel.fromJson(Map<String, dynamic> json) {
    qId = json['q_id'];
    qName = json['q_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['q_id'] = this.qId;
    data['q_name'] = this.qName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
