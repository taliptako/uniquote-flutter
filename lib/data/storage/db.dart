import 'dart:convert';

import 'package:frideos_kvprx/frideos_kvprx.dart';

class DB {
  Future<KeyValueProvider> kvpDb(String table) async {
    final dbProvider = DbProvider();
    await dbProvider.init();
    final kvpDb = KeyValueProvider(dbProvider: dbProvider, table: table);
    await kvpDb.init();
    return kvpDb;
  }

  Future<void> deleteDB() async {
    final dbProvider = DbProvider();
    await dbProvider.init();
    await dbProvider.truncate('quotes');
    await dbProvider.truncate('users');
    await dbProvider.truncate('tags');
  }

  Future get(String table, String key) async {
    final kvp = await kvpDb(table);
    final kv = await kvp.getByKey(key);

    final keyDate = await kvp.getByKey(key + "date");
    if (keyDate != null) {
      final keyDate2 = DateTime.parse(keyDate.value);

      if (DateTime.now().difference(keyDate2).inHours > 55) {
        await remove(table, key);
        return false;
      }
    }

    if (kv != null) {
      return kv.value;
    }
    return false;
  }

  Future<bool> set(String table, String key, String value) async {
    final kvp = await kvpDb(table);

    await kvp.insertKeyValue(key + "date", DateTime.now().toString());

    return await kvp.insertKeyValue(key, value);
  }

  Future remove(String table, String key) async {
    final kvp = await kvpDb(table);
    await kvp.deleteByKey(key);
    await kvp.deleteByKey(key + "date");
  }

  Future<void> removeByPrefix(String table, String prefix) async {
    final kvp = await kvpDb(table);
    await kvp.bulkDeleteKeysStartWith(prefix);
  }


  Future<void> truncateTable(String table) async {
    final kvp = await kvpDb(table);
    await kvp.truncate();
  }

  decode(String data) {
    return jsonDecode(data);
  }
}
