import 'package:flutter/material.dart';
import 'package:flutter_application_3/bloc/article_bloc.dart';
import 'package:flutter_application_3/bloc/article_event.dart';
import 'package:flutter_application_3/bloc/article_state.dart';
import 'package:flutter_application_3/model/api_result_model.dart';
import 'package:flutter_application_3/repository/ArticleRepository.dart';
import 'package:flutter_application_3/ui/pages/about_page.dart';
import 'package:flutter_application_3/ui/pages/article_detail_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ArticleBloc? articleBloc;
  ArticleRepository? repository;

  @override
  void initState() {
    super.initState();
    //var blocProvider = BlocProvider;
    articleBloc = BlocProvider.of(context);
    //articleBloc!.add(FetchArticlesEvent());
    BlocProvider.of<ArticleBloc>(context).add(FetchArticlesEvent());

    //  squareBloc = SquareBloc(homeRepo);
    // squareBloc.add(FetchSquares(1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cricket"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                articleBloc!.add(FetchArticlesEvent());
              },
            ),
            IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                navigateToAoutPage(context);
              },
            )
          ],
        ),
        body:
            BlocConsumer<ArticleBloc, ArticleState>(listener: (context, state) {
          if (state is ArticleErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                duration: Duration(milliseconds: 300),
              ),
            );
          }
        }, builder: (context, state) {
          if (state is ArticleInitialState) {
            return buildLoading();
          } else if (state is ArticleLoadingState) {
            return buildLoading();
          } else if (state is ArticleLoadedState) {
            return buildArticleList(state.articles);
          } else if (state is ArticleErrorState) {
            return buildErrorUi(state.message);
          } else {
            return Container();
            //         }
          }
        }));
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildArticleList(List<Article> articles) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: articles.length,
      itemBuilder: (ctx, pos) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: ListTile(
              leading: ClipOval(
                child: Hero(
                  tag: articles[pos].urlToImage,
                  child: Image.network(
                    articles[pos].urlToImage,
                    fit: BoxFit.cover,
                    height: 70.0,
                    width: 70.0,
                  ),
                ),
              ),
              title: Text(articles[pos].title),
              subtitle: Text(articles[pos].publishedAt.toString()),
            ),
            onTap: () {
              navigateToArticleDetailPage(context, articles[pos]);
            },
          ),
        );
      },
    );
  }

  void navigateToArticleDetailPage(BuildContext context, Article article) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ArticleDetailPage(
        article: article,
      );
    }));
  }

  void navigateToAoutPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AboutPage();
    }));
  }
}
