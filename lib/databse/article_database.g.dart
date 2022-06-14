// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorArticleDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$ArticleDatabaseBuilder databaseBuilder(String name) =>
      _$ArticleDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$ArticleDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$ArticleDatabaseBuilder(null);
}

class _$ArticleDatabaseBuilder {
  _$ArticleDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$ArticleDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$ArticleDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<ArticleDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$ArticleDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$ArticleDatabase extends ArticleDatabase {
  _$ArticleDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ArticleDao? _articleDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `article` (`slug` TEXT, `title` TEXT, `description` TEXT, `body` TEXT, `favorited` INTEGER, `favoritesCount` INTEGER, PRIMARY KEY (`slug`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ArticleDao get articleDao {
    return _articleDaoInstance ??= _$ArticleDao(database, changeListener);
  }
}

class _$ArticleDao extends ArticleDao {
  _$ArticleDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _articleFloorInsertionAdapter = InsertionAdapter(
            database,
            'article',
            (ArticleFloor item) => <String, Object?>{
                  'slug': item.slug,
                  'title': item.title,
                  'description': item.description,
                  'body': item.body,
                  'favorited':
                      item.favorited == null ? null : (item.favorited! ? 1 : 0),
                  'favoritesCount': item.favoritesCount
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ArticleFloor> _articleFloorInsertionAdapter;

  @override
  Stream<List<ArticleFloor>> getAllFloorArticle() {
    return _queryAdapter.queryListStream('select * from article',
        mapper: (Map<String, Object?> row) => ArticleFloor(
            row['slug'] as String?,
            row['title'] as String?,
            row['description'] as String?,
            row['body'] as String?,
            row['favorited'] == null ? null : (row['favorited'] as int) != 0,
            row['favoritesCount'] as int?),
        queryableName: 'article',
        isView: false);
  }

  @override
  Future<void> insertArticle(ArticleFloor articleFloor) async {
    await _articleFloorInsertionAdapter.insert(
        articleFloor, OnConflictStrategy.abort);
  }
}
