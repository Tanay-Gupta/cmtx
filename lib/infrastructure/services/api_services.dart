import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/post_model.dart';

class ApiService {
  final String baseUrl = "https://jsonplaceholder.typicode.com";

  Future<List<PostModel>> fetchComments() async {
    final response = await http.get(Uri.parse('$baseUrl/comments'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }
}
