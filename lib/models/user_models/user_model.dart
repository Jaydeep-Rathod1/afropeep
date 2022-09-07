import 'dart:ffi';

class UserModel {
  int uerId;
  int countryId;
  String mobileNumber;
  int modeId;
  String gender;
  String firstname;
  String password;
  String changepass;
  String lastname;
  String birthDate;
  String age;
  String intrest;
  String lookingFor;
  String address;
  String lattitude;
  String longitude;
  String status;
  String regiDatetime;
  String emailId;
  String distance;
  String createdAt;
  String updatedAt;
  String countryName;
  int countryCode;
  String countryShortname;
  String modeName;
  int photoId;
  String photoUrl1;
  String photoUrl2;
  String photoUrl3;
  String photoUrl4;
  Null photoUrl5;
  Null photoUrl6;
  String adddatetime;
  int userId;
  String bio;
  String religion;
  String occupation;
  String height;

  UserModel(
      {this.uerId,
        this.countryId,
        this.mobileNumber,
        this.modeId,
        this.gender,
        this.firstname,
        this.password,
        this.changepass,
        this.lastname,
        this.birthDate,
        this.age,
        this.intrest,
        this.lookingFor,
        this.address,
        this.lattitude,
        this.longitude,
        this.status,
        this.regiDatetime,
        this.emailId,
        this.distance,
        this.createdAt,
        this.updatedAt,
        this.countryName,
        this.countryCode,
        this.countryShortname,
        this.modeName,
        this.photoId,
        this.photoUrl1,
        this.photoUrl2,
        this.photoUrl3,
        this.photoUrl4,
        this.photoUrl5,
        this.photoUrl6,
        this.adddatetime,
        this.userId,
        this.bio,
        this.religion,
        this.occupation,
        this.height});

  UserModel.fromJson(Map<String, dynamic> json) {
    uerId = json['uer_id'];
    countryId = json['country_id'];
    mobileNumber = json['mobile_number'];
    modeId = json['mode_id'];
    gender = json['gender'];
    firstname = json['firstname'];
    password = json['password'];
    changepass = json['changepass'];
    lastname = json['lastname'];
    birthDate = json['birth_date'];
    age = json['age'];
    intrest = json['intrest'];
    lookingFor = json['looking_for'];
    address = json['address'];
    lattitude = json['lattitude'];
    longitude = json['longitude'];
    status = json['status'];
    regiDatetime = json['regi_datetime'];
    emailId = json['email_id'];
    distance = json['distance'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    countryName = json['country_name'];
    countryCode = json['country_code'];
    countryShortname = json['country_shortname'];
    modeName = json['mode_name'];
    photoId = json['photo_id'];
    photoUrl1 = json['photo_url1'];
    photoUrl2 = json['photo_url2'];
    photoUrl3 = json['photo_url3'];
    photoUrl4 = json['photo_url4'];
    photoUrl5 = json['photo_url5'];
    photoUrl6 = json['photo_url6'];
    adddatetime = json['adddatetime'];
    userId = json['user_id'];
    bio = json['bio'];
    religion = json['religion'];
    occupation = json['Occupation'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uer_id'] = this.uerId;
    data['country_id'] = this.countryId;
    data['mobile_number'] = this.mobileNumber;
    data['mode_id'] = this.modeId;
    data['gender'] = this.gender;
    data['firstname'] = this.firstname;
    data['password'] = this.password;
    data['changepass'] = this.changepass;
    data['lastname'] = this.lastname;
    data['birth_date'] = this.birthDate;
    data['age'] = this.age;
    data['intrest'] = this.intrest;
    data['looking_for'] = this.lookingFor;
    data['address'] = this.address;
    data['lattitude'] = this.lattitude;
    data['longitude'] = this.longitude;
    data['status'] = this.status;
    data['regi_datetime'] = this.regiDatetime;
    data['email_id'] = this.emailId;
    data['distance'] = this.distance;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['country_name'] = this.countryName;
    data['country_code'] = this.countryCode;
    data['country_shortname'] = this.countryShortname;
    data['mode_name'] = this.modeName;
    data['photo_id'] = this.photoId;
    data['photo_url1'] = this.photoUrl1;
    data['photo_url2'] = this.photoUrl2;
    data['photo_url3'] = this.photoUrl3;
    data['photo_url4'] = this.photoUrl4;
    data['photo_url5'] = this.photoUrl5;
    data['photo_url6'] = this.photoUrl6;
    data['adddatetime'] = this.adddatetime;
    data['user_id'] = this.userId;
    data['bio'] = this.bio;
    data['religion'] = this.religion;
    data['Occupation'] = this.occupation;
    data['height'] = this.height;
    return data;
  }
}
