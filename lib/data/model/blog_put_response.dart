class BlogPutResponse {
  final int id;
  final String title;
  final String body;
  final String result;

  BlogPutResponse({
    required this.id,
    required this.title,
    required this.body,
    required this.result,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['body'] = body;
    map['result'] = result; // Include the "result" field in the JSON
    return map;
  }
}
