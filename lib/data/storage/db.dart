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

  Future get(String table, String key) async {
    final kvp = await kvpDb(table);
    final kv = await kvp.getByKey(key);

    if (kv.value.isNotEmpty) {
      return kv.value;
    }
    return false;
  }

  Future<bool> set(String table, String key, String value) async {
    final kvp = await kvpDb(table);

    return await kvp.insertKeyValue(key, value);
  }

  Future remove(String table, String key) async {
    final kvp = await kvpDb(table);
    await kvp.deleteByKey(key);
  }

  decode(String data) {
    return jsonDecode(data);
  }
}
