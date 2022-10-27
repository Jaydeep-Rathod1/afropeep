class ModeToStartModel {
  int modeId;
  String modeName;
  String createdAt;
  String updatedAt;

  ModeToStartModel(
      {this.modeId, this.modeName, this.createdAt, this.updatedAt});

  ModeToStartModel.fromJson(Map<String, dynamic> json) {
    modeId = json['mode_id'];
    modeName = json['mode_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mode_id'] = this.modeId;
    data['mode_name'] = this.modeName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
