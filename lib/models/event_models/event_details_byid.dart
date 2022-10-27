class EventDetailsById {
  int eventId;
  int userId;
  String eventName;
  String eventDate;
  String latitude;
  double longitude;
  String aboutEvent;
  String eventImg;
  String createdAt;
  String updatedAt;
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
  String event_address;
  double lattitude;
  String status;
  String regiDatetime;
  String emailId;
  String distance;
  String college;
  String school;
  int photoId;
  String photoUrl1;
  String photoUrl2;
  String photoUrl3;
  String photoUrl4;
  String photoUrl5;
  String photoUrl6;
  String adddatetime;

  EventDetailsById(
      {this.eventId,
        this.userId,
        this.eventName,
        this.eventDate,
        this.latitude,
        this.longitude,
        this.aboutEvent,
        this.eventImg,
        this.createdAt,
        this.updatedAt,
        this.uerId,

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
        this.event_address,
        this.lattitude,
        this.status,
        this.regiDatetime,
        this.emailId,
        this.distance,
        this.college,
        this.school,
        this.photoId,
        this.photoUrl1,
        this.photoUrl2,
        this.photoUrl3,
        this.photoUrl4,
        this.photoUrl5,
        this.photoUrl6,
        this.adddatetime});

  EventDetailsById.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    userId = json['user_id'];
    eventName = json['event_name'];
    eventDate = json['event_Date'];
    latitude = json['latitude'];
    longitude = json['longitude'] ;
    aboutEvent = json['about_event'];
    eventImg = json['event_img'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    event_address = json['event_address'];
    lattitude = json['lattitude'];
    status = json['status'];
    regiDatetime = json['regi_datetime'];
    emailId = json['email_id'];
    distance = json['distance'];
    college = json['college'];
    school = json['school'];
    photoId = json['photo_id'];
    photoUrl1 = json['photo_url1'];
    photoUrl2 = json['photo_url2'];
    photoUrl3 = json['photo_url3'];
    photoUrl4 = json['photo_url4'];
    photoUrl5 = json['photo_url5'];
    photoUrl6 = json['photo_url6'];
    adddatetime = json['adddatetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['user_id'] = this.userId;
    data['event_name'] = this.eventName;
    data['event_Date'] = this.eventDate;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['about_event'] = this.aboutEvent;
    data['event_img'] = this.eventImg;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
    data['event_address'] = this.event_address;
    data['lattitude'] = this.lattitude;
    data['status'] = this.status;
    data['regi_datetime'] = this.regiDatetime;
    data['email_id'] = this.emailId;
    data['distance'] = this.distance;
    data['college'] = this.college;
    data['school'] = this.school;
    data['photo_id'] = this.photoId;
    data['photo_url1'] = this.photoUrl1;
    data['photo_url2'] = this.photoUrl2;
    data['photo_url3'] = this.photoUrl3;
    data['photo_url4'] = this.photoUrl4;
    data['photo_url5'] = this.photoUrl5;
    data['photo_url6'] = this.photoUrl6;
    data['adddatetime'] = this.adddatetime;
    return data;
  }
}
