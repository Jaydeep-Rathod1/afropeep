class GetMatchNewRequestModel {
  int reqId;
  int senderId;
  int receiveId;
  String type;
  String status;
  String sendtime;
  String updatetime;
  String createdAt;
  String updatedAt;
  String firstName;
  String lastName;
  String photoUrl1;
  String age;
  String address;

  GetMatchNewRequestModel(
      {this.reqId,
        this.senderId,
        this.receiveId,
        this.type,
        this.status,
        this.sendtime,
        this.updatetime,
        this.createdAt,
        this.updatedAt,
        this.firstName,
        this.lastName,
        this.photoUrl1,
        this.age,
        this.address});

  GetMatchNewRequestModel.fromJson(Map<String, dynamic> json) {
    reqId = json['req_id'];
    senderId = json['sender_id'];
    receiveId = json['receive_id'];
    type = json['type'];
    status = json['status'];
    sendtime = json['sendtime'];
    updatetime = json['updatetime'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    photoUrl1 = json['photoUrl1'];
    age = json['age'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['req_id'] = this.reqId;
    data['sender_id'] = this.senderId;
    data['receive_id'] = this.receiveId;
    data['type'] = this.type;
    data['status'] = this.status;
    data['sendtime'] = this.sendtime;
    data['updatetime'] = this.updatetime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['photoUrl1'] = this.photoUrl1;
    data['age'] = this.age;
    data['address'] = this.address;
    return data;
  }
}
