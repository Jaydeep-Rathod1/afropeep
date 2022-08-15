class GetMatchRequestModel {
  int reqId;
  int senderId;
  int receiveId;
  String type;
  String status;
  String sendtime;
  String updatetime;
  String createdAt;
  String updatedAt;

  GetMatchRequestModel(
      {this.reqId,
        this.senderId,
        this.receiveId,
        this.type,
        this.status,
        this.sendtime,
        this.updatetime,
        this.createdAt,
        this.updatedAt});

  GetMatchRequestModel.fromJson(Map<String, dynamic> json) {
    reqId = json['req_id'];
    senderId = json['sender_id'];
    receiveId = json['receive_id'];
    type = json['type'];
    status = json['status'];
    sendtime = json['sendtime'];
    updatetime = json['updatetime'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return data;
  }
}
