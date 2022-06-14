// import 'package:first_app/databse/article_database.dart';
import 'package:first_app/databse/article_table.dart';
import 'package:floor/floor.dart';

@dao
abstract class ArticleDao {
  @Query('select * from article')
  Stream<List<ArticleFloor>> getAllFloorArticle();
  @insert
  Future<void> insertArticle(ArticleFloor articleFloor);
}
