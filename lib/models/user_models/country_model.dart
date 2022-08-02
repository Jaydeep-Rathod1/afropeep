class CountryModel {
  int countryId;
  String countryName;
  int countryCode;
  String countryShortname;
  String createdAt;
  String updatedAt;

  CountryModel(
      {this.countryId,
        this.countryName,
        this.countryCode,
        this.countryShortname,
        this.createdAt,
        this.updatedAt});

  CountryModel.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    countryName = json['country_name'];
    countryCode = json['country_code'];
    countryShortname = json['country_shortname'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_id'] = this.countryId;
    data['country_name'] = this.countryName;
    data['country_code'] = this.countryCode;
    data['country_shortname'] = this.countryShortname;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
