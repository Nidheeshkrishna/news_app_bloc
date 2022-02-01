import 'package:flutter_application_3/model/api_result_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class ArticleRepository {
  Future<List<Article>> getArticles();
}

class ArticleRepositoryImpl implements ArticleRepository {
  @override
  Future<List<Article>> getArticles() async {
    var response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?sources=espn-cric-info&apiKey=54aa8fcae35f49f5b55c54d8f71541f6"));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Article> articles = ApiResultModel.fromJson(data).articles;
      return articles;
    } else {
      throw Exception();
    }
  }
}
