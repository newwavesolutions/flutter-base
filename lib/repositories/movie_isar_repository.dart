import 'package:flutter_base/database/isar_helper.dart';
import 'package:flutter_base/models/entities/movie_isar_entity.dart';
import 'package:isar/isar.dart';

abstract class MovieIsarRepository {
  Future<MovieIsarEntity> getProfile();
  Future<void> createMovie({required MovieIsarEntity isarEntity});
  Future<List<MovieIsarEntity>?> getMovie();
}

class MovieIsarRepositoryImpl extends MovieIsarRepository {
  @override
  Future<MovieIsarEntity> getProfile() async {
    await Future.delayed(const Duration(seconds: 2));
    //Mock data
    return MovieIsarEntity();
  }

  @override
  Future<void> createMovie({required MovieIsarEntity isarEntity}) async {
    await IsarHelper.create(isarEntity);
  }

  @override
  Future<List<MovieIsarEntity>?> getMovie() async {
    return IsarHelper.getInstance(MovieIsarEntitySchema).then((value) async {
      final searchResult =
          await value?.collection<MovieIsarEntity>().where().findAll();
      return searchResult;
    }).catchError((e) {
      return null;
    });
  }
}
