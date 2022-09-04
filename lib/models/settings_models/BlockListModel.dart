class BlockListModel {
  int blockId;
  int senderId;
  int receiveId;
  String remarks;
  String blocaktime;
  String createdAt;
  String updatedAt;
  int uerId;
  int countryId;
  String mobileNumber;
  int modeId;
  String gender;
  String firstname;
  String lastname;
  String birthDate;
  String intrest;
  String lookingFor;
  String address;
  String lattitude;
  String longitude;
  String status;
  String regiDatetime;
  String emailId;
  String about;
  String height;
  String region;
  String distance;
  String profession;
  int photoId;
  String photoUrl1;
  String photoUrl2;
  String photoUrl3;
  String photoUrl4;
  String photoUrl5;
  String photoUrl6;
  String adddatetime;
  int userId;

  BlockListModel(
      {this.blockId,
        this.senderId,
        this.receiveId,
        this.remarks,
        this.blocaktime,
        this.createdAt,
        this.updatedAt,
        this.uerId,
        this.countryId,
        this.mobileNumber,
        this.modeId,
        this.gender,
        this.firstname,
        this.lastname,
        this.birthDate,
        this.intrest,
        this.lookingFor,
        this.address,
        this.lattitude,
        this.longitude,
        this.status,
        this.regiDatetime,
        this.emailId,
        this.about,
        this.height,
        this.region,
        this.distance,
        this.profession,
        this.photoId,
        this.photoUrl1,
        this.photoUrl2,
        this.photoUrl3,
        this.photoUrl4,
        this.photoUrl5,
        this.photoUrl6,
        this.adddatetime,
        this.userId});

  BlockListModel.fromJson(Map<String, dynamic> json) {
    blockId = json['block_id'];
    senderId = json['sender_id'];
    receiveId = json['receive_id'];
    remarks = json['remarks'];
    blocaktime = json['blocaktime'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    uerId = json['uer_id'];
    countryId = json['country_id'];
    mobileNumber = json['mobile_number'];
    modeId = json['mode_id'];
    gender = json['gender'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    birthDate = json['birth_date'];
    intrest = json['intrest'];
    lookingFor = json['looking_for'];
    address = json['address'];
    lattitude = json['lattitude'];
    longitude = json['longitude'];
    status = json['status'];
    regiDatetime = json['regi_datetime'];
    emailId = json['email_id'];
    about = json['about'];
    height = json['height'];
    region = json['region'];
    distance = json['distance'];
    profession = json['profession'];
    photoId = json['photo_id'];
    photoUrl1 = json['photo_url1'];
    photoUrl2 = json['photo_url2'];
    photoUrl3 = json['photo_url3'];
    photoUrl4 = json['photo_url4'];
    photoUrl5 = json['photo_url5'];
    photoUrl6 = json['photo_url6'];
    adddatetime = json['adddatetime'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['block_id'] = this.blockId;
    data['sender_id'] = this.senderId;
    data['receive_id'] = this.receiveId;
    data['remarks'] = this.remarks;
    data['blocaktime'] = this.blocaktime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['uer_id'] = this.uerId;
    data['country_id'] = this.countryId;
    data['mobile_number'] = this.mobileNumber;
    data['mode_id'] = this.modeId;
    data['gender'] = this.gender;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['birth_date'] = this.birthDate;
    data['intrest'] = this.intrest;
    data['looking_for'] = this.lookingFor;
    data['address'] = this.address;
    data['lattitude'] = this.lattitude;
    data['longitude'] = this.longitude;
    data['status'] = this.status;
    data['regi_datetime'] = this.regiDatetime;
    data['email_id'] = this.emailId;
    data['about'] = this.about;
    data['height'] = this.height;
    data['region'] = this.region;
    data['distance'] = this.distance;
    data['profession'] = this.profession;
    data['photo_id'] = this.photoId;
    data['photo_url1'] = this.photoUrl1;
    data['photo_url2'] = this.photoUrl2;
    data['photo_url3'] = this.photoUrl3;
    data['photo_url4'] = this.photoUrl4;
    data['photo_url5'] = this.photoUrl5;
    data['photo_url6'] = this.photoUrl6;
    data['adddatetime'] = this.adddatetime;
    data['user_id'] = this.userId;
    return data;
  }
}
