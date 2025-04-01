import 'package:drift/drift.dart';
import 'package:hola_todo/data/database/app_database.dart';
import 'package:hola_todo/data/models/tag/tag.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class TagRepository {
  final AppDatabase _database;

  TagRepository(this._database);

  Stream<List<TagModel>> getTags() {
    return _database.select(_database.tags).watch();
  }

  Future<void> addTag(TagModel tag) async {
    await _database.tags.insertOne(
      TagsCompanion.insert(
        name: tag.name,
      ),
    );
  }
}