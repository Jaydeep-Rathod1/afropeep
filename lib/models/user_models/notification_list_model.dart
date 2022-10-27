class NotificationListModel {
  int notificationId;
  int userId;
  String message;
  String firebasetoken;
  String createdAt;
  String updatedAt;

  NotificationListModel(
      {this.notificationId,
        this.userId,
        this.message,
        this.firebasetoken,
        this.createdAt,
        this.updatedAt});

  NotificationListModel.fromJson(Map<String, dynamic> json) {
    notificationId = json['notification_id'];
    userId = json['user_id'];
    message = json['message'];
    firebasetoken = json['firebasetoken'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification_id'] = this.notificationId;
    data['user_id'] = this.userId;
    data['message'] = this.message;
    data['firebasetoken'] = this.firebasetoken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
