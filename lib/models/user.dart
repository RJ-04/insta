class User {
  final String username;
  final String uid;
  final String email;
  final String bio;
  final String photoUrl;
  final List followers;
  final List following;

  const User({
    required this.bio,
    required this.followers,
    required this.following,
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photourl": photoUrl,
        "bio": bio,
        "followers": followers,
        "following": following
      };
}
