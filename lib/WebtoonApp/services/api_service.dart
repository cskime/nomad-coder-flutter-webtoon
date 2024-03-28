import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/WebtoonApp/models/webtoon_detail_model.dart';
import 'package:toonflix/WebtoonApp/models/webtoon_episode_model.dart';
import 'package:toonflix/WebtoonApp/models/webtoon_model.dart';

class APIService {
  static const baseURL = "https://webtoon-crawler.nomadcoders.workers.dev";
  static const todayPath = "today";
  static const episodePath = "episode";

  static Future<List<WebtoonModel>> fetchTodaysToons() async {
    List<WebtoonModel> models = [];

    final url = Uri.parse("$baseURL/$todayPath");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (final webtoon in webtoons) {
        final model = WebtoonModel.fromJSON(webtoon);
        models.add(model);
      }
      return models;
    } else {
      throw Error();
    }
  }

  static Future<WebtoonDetailModel> fetchToonById(String id) async {
    final url = Uri.parse("$baseURL/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final toonDetail = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(toonDetail);
    } else {
      throw Error();
    }
  }

  static Future<List<WebtoonEpisodeModel>> fetchEpisodesById(String id) async {
    final url = Uri.parse("$baseURL/$id/episodes");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> jsonArray = jsonDecode(response.body);
      return jsonArray
          .map((element) => WebtoonEpisodeModel.fromJson(element))
          .toList();
    } else {
      throw Error();
    }
  }
}
