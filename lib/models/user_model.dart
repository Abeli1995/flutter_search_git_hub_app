class User {
  final String login;
  final String avatarUrl;
  final String followersUrl;

  User({
    required this.login,
    required this.avatarUrl,
    required this.followersUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      login: json['login'],
      avatarUrl: json['avatar_url'],
      followersUrl: json['followers_url'],
    );
  }
}
