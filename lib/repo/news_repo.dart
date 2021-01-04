import 'package:bloc_task/constants.dart';
import 'package:bloc_task/model/news.dart';
import 'package:http/http.dart' as http;

class NewsRepo {
  Future<News> getNews() async {
    News news = News();
    var newsResponse = await http.Client().get(kAPIURL);

    if (newsResponse.statusCode == 200) {
      news = newsFromJson(newsResponse.body);
      return news;
    }

    return null;
  }
}
