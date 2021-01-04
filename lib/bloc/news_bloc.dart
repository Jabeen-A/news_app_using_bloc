import 'dart:async';

import 'package:bloc_task/model/news.dart';
import 'package:bloc_task/repo/news_repo.dart';

enum NewsAction { Fetch }

class NewsBloc {
  final _stateStreamController = StreamController<News>();
  StreamSink<News> get _newsSink => _stateStreamController.sink;
  Stream<News> get newsStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<NewsAction>();
  StreamSink<NewsAction> get eventSink => _eventStreamController.sink;
  Stream<NewsAction> get _eventStream => _eventStreamController.stream;

  NewsBloc() {
    _eventStream.listen((event) async {
      if (event == NewsAction.Fetch) {
        try {
          NewsRepo newsRepo = NewsRepo();
          var news = await newsRepo.getNews();
          _newsSink.add(news);
        } catch (e) {
          _newsSink.addError('Unable to fetch News!');
        }
      }
    });
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
