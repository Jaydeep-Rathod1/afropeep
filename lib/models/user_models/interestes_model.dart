class InterestModel {
  int intrestId;
  String intrestName;
  String createdAt;
  String updatedAt;

  InterestModel(
      {this.intrestId, this.intrestName, this.createdAt, this.updatedAt});

  InterestModel.fromJson(Map<String, dynamic> json) {
    intrestId = json['intrest_id'];
    intrestName = json['intrest_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intrest_id'] = this.intrestId;
    data['intrest_name'] = this.intrestName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
