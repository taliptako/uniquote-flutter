import 'package:uniquote/config/sl.dart';
import 'package:uniquote/stores/root_store.dart';
import 'package:uniquote/stores/feed_store.dart';
import 'package:uniquote/stores/most_liked_store.dart';
import 'package:uniquote/stores/tag/tag_store.dart';
import 'package:uniquote/stores/tag/tag_recent_store.dart';
import 'package:uniquote/stores/tag/tag_mostliked_store.dart';

class Dependencies {
  static void register() {
    sl.registerSingleton<RootStore>(RootStore());

    sl.registerSingleton<FeedStore>(FeedStore());

    sl.registerLazySingleton<MostLikedStore>(() => MostLikedStore());

    sl.registerLazySingleton<TagStore>(() => TagStore());

    sl.registerLazySingleton<TagRecentStore>(() => TagRecentStore());

    sl.registerLazySingleton<TagMostLikedStore>(() => TagMostLikedStore());
  }
}
