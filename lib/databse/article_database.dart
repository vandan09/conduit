import 'package:first_app/databse/article_dao.dart';
import 'package:first_app/databse/article_table.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
part 'article_database.g.dart';

@Database(version: 1, entities: [ArticleFloor])
abstract class ArticleDatabase extends FloorDatabase {
  ArticleDao get articleDao;
}
