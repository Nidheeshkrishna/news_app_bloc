import 'package:bloc/bloc.dart';
import 'package:flutter_application_3/bloc/article_event.dart';
import 'package:flutter_application_3/bloc/article_state.dart';
import 'package:flutter_application_3/model/api_result_model.dart';
import 'package:flutter_application_3/repository/ArticleRepository.dart';

import 'package:meta/meta.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleRepository repository;

//  ArticleBloc({required this.repository}) : super(ArticleState());
  // ArticleBloc(ArticleRepository repo, {ArticleRepositoryImpl? repository})
  // : this.repository = repo,
  //   super(ArticleState());
  ArticleBloc({required this.repository}) : super(ArticleInitialState()) {
    on<FetchArticlesEvent>((event, emit) async* {
      if (event is FetchArticlesEvent) {
        yield ArticleLoadingState();
        try {
          List<Article> articles = await repository.getArticles();
          yield ArticleLoadedState(articles: articles);
        } catch (e) {
          yield ArticleErrorState(message: e.toString());
        }
      }
    });
  }
  @override
  // TODO: implement initialState
  ArticleState get initialState => ArticleInitialState();
}
