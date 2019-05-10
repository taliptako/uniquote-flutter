import 'package:mobx/mobx.dart';

import 'package:uniquote/models/profession_model.dart';

// Include generated file
part 'user_store.g.dart';

// This is the class used by rest of your codebase
class UserStore = AbstractUserStore with _$UserStore;

// The store-class
abstract class AbstractUserStore implements Store {

  final int id;
  final String name;
  final String email;
  final String nationality;
  final String religion;
  final String bio;
  final String bioUrl;
  final DateTime born;
  final String avatarLg;
  final String avatarSm;
  final String password;
  final String apiToken;

  final int favoriteCount;

  final List professions;

  AbstractUserStore(
      {this.id,
      this.name,
      this.email,
      this.nationality,
      this.religion,
      this.bio,
      this.bioUrl,
      this.born,
      this.avatarLg,
      this.avatarSm,
      this.password,
      this.apiToken,
      this.followerCount,
      this.followingCount,
      this.quoteCount,
      this.favoriteCount,
      this.isFollowed,
      this.professions});

  static UserStore fromJson(Map<String, dynamic> json) {
    return UserStore(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        nationality: json['nationality'],
        religion: json['religion'],
        bio: json['bio'],
        bioUrl: json['bio_url'],
        born: json['born'] != null ? DateTime.parse(json['born']) : null,
        avatarLg: json['avatar_lg'],
        avatarSm: json['avatar_sm'],
        password: json['password'],
        apiToken: json['api_token'],
        followerCount:
            json['follower_count'] != null ? json['follower_count'] : 0,
        followingCount:
            json['following_count'] != null ? json['following_count'] : 0,
        quoteCount: json['quote_count'] != null ? json['quote_count'] : 0,
        favoriteCount: json['favorite_count'] != null ? json['favorite_count'] : 0,
        isFollowed: json['isFollowed'] != null ? json['isFollowed'] : false,
        professions: json['professions'] != null
            ? json['professions']
                .map<Profession>((json) => Profession.fromJson(json))
                .toList()
            : null);
  }

  @observable
  bool isFollowed;

  @observable
  int followerCount;

  @observable
  int followingCount;

  @observable
  int quoteCount;

}
