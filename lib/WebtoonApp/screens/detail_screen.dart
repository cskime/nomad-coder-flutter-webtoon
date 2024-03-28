import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toonflix/WebtoonApp/models/webtoon_detail_model.dart';
import 'package:toonflix/WebtoonApp/models/webtoon_episode_model.dart';
import 'dart:io';
import 'package:toonflix/WebtoonApp/services/api_service.dart';
import 'package:toonflix/WebtoonApp/widgets/episode_widget.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumbnail, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumbnail,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final Future<WebtoonDetailModel> detailModel;
  late final Future<List<WebtoonEpisodeModel>> episodes;
  late final SharedPreferences prefs;
  bool isLiked = false;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList("likedToons");
    if (likedToons != null) {
      if (likedToons.contains(widget.id)) {
        setState(() {
          isLiked = true;
        });
      }
    } else {
      prefs.setStringList("likedToons", []);
    }
  }

  onHeartTap() async {
    final likedToons = prefs.getStringList("likedToons");
    if (likedToons != null) {
      if (isLiked) {
        likedToons.remove(widget.id);
      } else {
        likedToons.add(widget.id);
      }

      await prefs.setStringList("likedToons", likedToons);
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    detailModel = APIService.fetchToonById(widget.id);
    episodes = APIService.fetchEpisodesById(widget.id);
    initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.green,
        elevation: 2,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          IconButton(
            onPressed: onHeartTap,
            icon:
                Icon(isLiked ? Icons.favorite_rounded : Icons.favorite_outline),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Center(
                child: Hero(
                  tag: widget.id,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15,
                            offset: const Offset(10, 10),
                            color: Colors.black.withOpacity(0.5),
                          )
                        ]),
                    clipBehavior: Clip.hardEdge,
                    width: 250,
                    child: Image.network(
                      widget.thumbnail,
                      headers: const {
                        'User-Agent':
                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36',
                        HttpHeaders.refererHeader: "https://comic.naver.com",
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FutureBuilder(
                future: detailModel,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "${snapshot.data!.genre} / ${snapshot.data!.age}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    );
                  } else {
                    return const Text("...");
                  }
                },
              ),
              const SizedBox(height: 24),
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // episode가 10개밖에 안되니까 ListView를 사용하지 않아도 최적화 문제가 없다.
                    // Column만 사용해도 충분함
                    return Column(
                      children: snapshot.data!
                          .map((e) => Episode(episode: e, webtoonId: widget.id))
                          .toList(),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
