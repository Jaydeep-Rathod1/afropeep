class QuestionsModel {
  int qId;
  String qName;
  String op1;
  String op2;
  String op3;
  String op4;
  String createdAt;
  String updatedAt;

  QuestionsModel(
      {this.qId,
        this.qName,
        this.op1,
        this.op2,
        this.op3,
        this.op4,
        this.createdAt,
        this.updatedAt});

  QuestionsModel.fromJson(Map<String, dynamic> json) {
    qId = json['q_id'];
    qName = json['q_name'];
    op1 = json['op1'];
    op2 = json['op2'];
    op3 = json['op3'];
    op4 = json['op4'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['q_id'] = this.qId;
    data['q_name'] = this.qName;
    data['op1'] = this.op1;
    data['op2'] = this.op2;
    data['op3'] = this.op3;
    data['op4'] = this.op4;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
