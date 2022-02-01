import 'package:equatable/equatable.dart';
import 'package:flutter_application_3/model/api_result_model.dart';

import 'package:meta/meta.dart';

class ArticleState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ArticleInitialState extends ArticleState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ArticleLoadingState extends ArticleState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ArticleLoadedState extends ArticleState {
  List<Article> articles;

  ArticleLoadedState({required this.articles});

  @override
  // TODO: implement props
  List<Object> get props => [articles];
}

class ArticleErrorState extends ArticleState {
  String message;

  ArticleErrorState({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
