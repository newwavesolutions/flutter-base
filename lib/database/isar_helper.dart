import 'package:flutter_base/utils/logger.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarHelper {
  static Isar? _isar;

  static Future<Isar?> getInstance<T extends CollectionSchema>(
      T dataClass) async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final isarDir = appDocumentDir.path;
    _isar = await Isar.open(
      [dataClass],
      directory: isarDir,
      inspector: true,
    );

    return _isar;
  }

  static bool checkIsarCollectionType<T>(T dataClass) {
    return _isar?.collection<T>() is IsarCollection<T>;
  }

  static Future<void> create<T>(T data) async {
    try {
      await _isar?.writeTxn(() async {
        final success = await _isar?.collection<T>().put(data);
        MyLogger().d('Isar created: $success');
      });
    } catch (e) {
      MyLogger().e(e);
    }
  }

  static Future<List?> read<T>(T dataClass) async {
    try {
      var data = await _isar?.collection<T>().where().findAll();
      MyLogger().d('Isar read: $data');
      return data;
    } catch (e) {
      MyLogger().e(e);
    }
    return null;
  }

  static Future<void> update<T>(T data) async {
    try {
      await _isar?.writeTxn(() async {
        final success = await _isar?.collection<T>().put(data);
        MyLogger().d('Isar updated: $success');
      });
    } catch (e) {
      MyLogger().e(e);
    }
  }

  static Future<void> delete<T>({
    required int id,
    required T dataClass,
  }) async {
    try {
      await _isar?.writeTxn(() async {
        final success = await _isar?.collection<T>().delete(id);
        MyLogger().d('Isar deleted: $success');
      });
    } catch (e) {
      MyLogger().e(e);
    }
  }
}
