import 'package:equatable/equatable.dart';

abstract class ArticleEvent extends Equatable {}

class FetchArticlesEvent extends ArticleEvent {
  @override
  List<Object> get props => [];
}
