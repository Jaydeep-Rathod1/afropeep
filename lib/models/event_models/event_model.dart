class EventModel {
  int eventId;
  int userId;
  String eventName;
  String eventDate;
  String latitude;
  String longitude;
  String event_address;
  String aboutEvent;
  String eventImg;
  String createdAt;
  String updatedAt;

  EventModel(
      {this.eventId,
        this.userId,
        this.eventName,
        this.eventDate,
        this.latitude,
        this.longitude,
        this.event_address,
        this.aboutEvent,
        this.eventImg,
        this.createdAt,
        this.updatedAt});

  EventModel.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    userId = json['user_id'];
    eventName = json['event_name'];
    eventDate = json['event_Date'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    event_address = json['event_address'];
    aboutEvent = json['about_event'];
    eventImg = json['event_img'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['user_id'] = this.userId;
    data['event_name'] = this.eventName;
    data['event_Date'] = this.eventDate;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['event_address'] = this.event_address;
    data['about_event'] = this.aboutEvent;
    data['event_img'] = this.eventImg;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
