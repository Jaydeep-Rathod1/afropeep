class EventModel {
  int eventId;
  int userId;
  String eventName;
  String eventDate;
  String latitude;
  String longitude;
  String aboutEvent;
  String createdAt;
  String updatedAt;

  EventModel(
      {this.eventId,
        this.userId,
        this.eventName,
        this.eventDate,
        this.latitude,
        this.longitude,
        this.aboutEvent,
        this.createdAt,
        this.updatedAt});

  EventModel.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    userId = json['user_id'];
    eventName = json['event_name'];
    eventDate = json['event_Date'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    aboutEvent = json['about_event'];
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
    data['about_event'] = this.aboutEvent;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
