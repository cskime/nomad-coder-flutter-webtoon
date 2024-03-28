class WebtoonModel {
  final String title, thumbnail, id;

  WebtoonModel.fromJSON(Map<String, dynamic> json)
      : title = json["title"],
        thumbnail = json["thumb"],
        id = json["id"];
}
