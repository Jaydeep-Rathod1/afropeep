class UserSubscritionModel {
  int paymentId;
  int subscriptionId;
  int userId;
  String payDate;
  String expireDate;
  String payId;
  String transactionNumber;
  String createdAt;
  String updatedAt;

  UserSubscritionModel(
      {this.paymentId,
        this.subscriptionId,
        this.userId,
        this.payDate,
        this.expireDate,
        this.payId,
        this.transactionNumber,
        this.createdAt,
        this.updatedAt});

  UserSubscritionModel.fromJson(Map<String, dynamic> json) {
    paymentId = json['payment_id'];
    subscriptionId = json['subscription_id'];
    userId = json['user_id'];
    payDate = json['pay_date'];
    expireDate = json['expire_date'];
    payId = json['pay_id'];
    transactionNumber = json['transaction_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_id'] = this.paymentId;
    data['subscription_id'] = this.subscriptionId;
    data['user_id'] = this.userId;
    data['pay_date'] = this.payDate;
    data['expire_date'] = this.expireDate;
    data['pay_id'] = this.payId;
    data['transaction_number'] = this.transactionNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
