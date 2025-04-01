// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TagStore on _TagStore, Store {
  late final _$tagsAtom = Atom(name: '_TagStore.tags', context: context);

  @override
  ObservableList<TagModel> get tags {
    _$tagsAtom.reportRead();
    return super.tags;
  }

  @override
  set tags(ObservableList<TagModel> value) {
    _$tagsAtom.reportWrite(value, super.tags, () {
      super.tags = value;
    });
  }

  late final _$fetchTagsAsyncAction =
      AsyncAction('_TagStore.fetchTags', context: context);

  @override
  Future<void> fetchTags() {
    return _$fetchTagsAsyncAction.run(() => super.fetchTags());
  }

  late final _$addTagAsyncAction =
      AsyncAction('_TagStore.addTag', context: context);

  @override
  Future<void> addTag(String name) {
    return _$addTagAsyncAction.run(() => super.addTag(name));
  }

  @override
  String toString() {
    return '''
tags: ${tags}
    ''';
  }
}
