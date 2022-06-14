import 'package:first_app/model/all_article_model.dart';
import 'package:floor/floor.dart';

@entity
class ArticleFloor {
  @primaryKey
  String? slug;
  String? title;
  String? description;
  String? body;
  // List<String>? tagList;
  // DateTime? createdAt;
  // DateTime? updatedAt;
  bool? favorited;
  int? favoritesCount;
  // Author? author;

  ArticleFloor(
    this.slug,
    this.title,
    this.description,
    this.body,
    // this.tagList,
    // this.createdAt,
    // this.updatedAt,
    this.favorited,
    this.favoritesCount,
    // this.author
  );
}
