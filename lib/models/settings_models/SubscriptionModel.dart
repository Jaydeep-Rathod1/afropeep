class SubscritionModel {
  int subId;
  String subName;
  String duration;
  String price;
  String discription;
  String isactive;
  String createdAt;
  String updatedAt;

  SubscritionModel(
      {this.subId,
        this.subName,
        this.duration,
        this.price,
        this.discription,
        this.isactive,
        this.createdAt,
        this.updatedAt});

  SubscritionModel.fromJson(Map<String, dynamic> json) {
    subId = json['sub_id'];
    subName = json['sub_name'];
    duration = json['duration'];
    price = json['price'];
    discription = json['discription'];
    isactive = json['isactive'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_id'] = this.subId;
    data['sub_name'] = this.subName;
    data['duration'] = this.duration;
    data['price'] = this.price;
    data['discription'] = this.discription;
    data['isactive'] = this.isactive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
