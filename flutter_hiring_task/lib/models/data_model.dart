class DataModel {
  int? id;
  String? title;
  String? description;
  String? address;
  String? postcode;
  String? phoneNumber;
  String? latitude;
  String? longitude;
  Image? image;

  DataModel(
      {this.id,
      this.title,
      this.description,
      this.address,
      this.postcode,
      this.phoneNumber,
      this.latitude,
      this.longitude,
      this.image});

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    address = json['address'];
    postcode = json['postcode'];
    phoneNumber = json['phoneNumber'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['address'] = address;
    data['postcode'] = postcode;
    data['phoneNumber'] = phoneNumber;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    return data;
  }
}

class Image {
  String? small;
  String? medium;
  String? large;

  Image({this.small, this.medium, this.large});

  Image.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    medium = json['medium'];
    large = json['large'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['small'] = small;
    data['medium'] = medium;
    data['large'] = large;
    return data;
  }
}
