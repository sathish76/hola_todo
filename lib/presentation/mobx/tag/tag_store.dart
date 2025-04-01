import 'dart:async';

import 'package:hola_todo/data/models/tag/tag.dart';
import 'package:hola_todo/data/repositories/tag_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:injectable/injectable.dart';

part 'tag_store.g.dart';

@injectable
class TagStore = _TagStore with _$TagStore;


abstract class _TagStore with Store {
  final TagRepository _tagRepository;

  _TagStore(this._tagRepository);

  @observable
  ObservableList<TagModel> tags = ObservableList<TagModel>();

  StreamSubscription<List<TagModel>>? subscription;

  @action
  Future<void> fetchTags() async {
    subscription = _tagRepository.getTags().listen((tagList) {
      tags = ObservableList.of(tagList);
    });
  }

  @action
  Future<void> addTag(String name) async {
    await _tagRepository.addTag(TagModel(id: 0, name: name));
  }
  
}
