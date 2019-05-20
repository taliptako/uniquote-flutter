import 'package:mobx/mobx.dart';

import 'package:uniquote/config/sl.dart';
import 'package:uniquote/stores/root_store.dart';
import 'package:uniquote/models/user_store.dart';
import 'package:uniquote/data/quote_api.dart';

// Include generated file
part 'quote_store.g.dart';

// This is the class used by rest of your codebase
class QuoteStore = AbstractQuoteStore with _$QuoteStore;

// The store-class
abstract class AbstractQuoteStore implements Store {
  final QuoteApi _quoteApi = QuoteApi();
  final RootStore _rootStore = sl<RootStore>();

  AbstractQuoteStore(
      {this.id,
      this.quote,
      this.likeCount,
      this.dislikeCount,
      this.hasFavorited,
      this.hasLiked,
      this.hasDisliked,
      this.user});

  final int id;
  final String quote;
  final UserStore user;

  @observable
  int likeCount;

  @observable
  int dislikeCount;

  @observable
  bool hasFavorited;

  @observable
  bool hasLiked;

  @observable
  bool hasDisliked;

  @action
  favorite() async {
    hasFavorited = true;
    _rootStore.user.favoriteCount++;
    bool result = await _quoteApi.interact('favorite', id);
    if (!result) {
      hasFavorited = false;
      _rootStore.user.favoriteCount--;
    }
  }

  @action
  unFavorite() async {
    hasFavorited = false;
    _rootStore.user.favoriteCount--;
    bool result = await _quoteApi.interact('unfavorite', id);
    if (!result) {
      hasFavorited = true;
      _rootStore.user.favoriteCount++;
    }
  }

  @action
  like() async {
    hasLiked = true;
    likeCount++;
    bool result = await _quoteApi.interact('like', id);
    if (!result) {
      hasLiked = false;
      likeCount--;
    }
  }

  @action
  unLike() async {
    hasLiked = false;
    likeCount--;
    bool result = await _quoteApi.interact('unlike', id);
    if (!result) {
      hasLiked = true;
      likeCount++;
    }
  }

  @action
  disLike() async {
    hasDisliked = true;
    dislikeCount++;
    bool result = await _quoteApi.interact('dislike', id);
    if (!result) {
      hasDisliked = false;
      dislikeCount--;
    }
  }

  @action
  unDisLike() async {
    hasDisliked = false;
    dislikeCount--;
    bool result = await _quoteApi.interact('undislike', id);
    if (!result) {
      hasDisliked = true;
      dislikeCount++;
    }
  }

  static QuoteStore fromJson(Map<String, dynamic> json) {
    return QuoteStore(
        id: json['id'],
        quote: json['quote'],
        likeCount: json['like_count'] != null ? json['like_count'] : 0,
        dislikeCount: json['dislike_count'] != null ? json['dislike_count'] : 0,
        hasFavorited: json['has_favorited'],
        hasLiked: json['has_liked'],
        hasDisliked: json['has_disliked'],
        user: AbstractUserStore.fromJson(json['user']));
  }
}
