class GetAllPostResponse {
  GetAllPostResponse({
      this.id, 
      this.title,});

  GetAllPostResponse.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
  }
  num? id;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    return map;
  }

}