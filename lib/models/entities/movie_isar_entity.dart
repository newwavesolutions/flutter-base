import 'package:isar/isar.dart';

part 'movie_isar_entity.g.dart';

@collection
class MovieIsarEntity {
  Id? id;
  @Index()
  String? name;
  @Index()
  String? star;

  MovieIsarEntity({
    this.id = Isar.autoIncrement,
    this.name,
    this.star,
  });
}
