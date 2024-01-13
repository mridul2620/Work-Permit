import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:work_permit/globalvarialbles.dart';


class Video {
  final int id;
  final String title;
  final String url;
  final String thumbnail;
  final String subtitle;

  Video({
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnail,
    required this.subtitle,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      title: json['title'],
      url: baseUrl + json['url'],
      thumbnail: baseUrl + json['thumbnail'],
      subtitle: json['description'] ?? '',
    );
  }
}

Future<List<Video>> fetchVideos(String token) async {
  final response = await http.get(
    Uri.parse(baseAPI + videoApi),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body)['data'];
    return data.map((video) => Video.fromJson(video)).toList();
  } else {
    throw Exception('Failed to load videos');
  }
}