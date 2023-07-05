import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final datePublished;
  final String postUrl;
  final String profileImage;
  final likes;

  const Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profileImage,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "username": username,
        "postid": postId,
        "datepublished": datePublished,
        "profileimage": profileImage,
        "likes": likes,
        "posturl": postUrl,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      datePublished: snapshot['datepublished'],
      description: snapshot["description"],
      likes: snapshot["likes"],
      postId: snapshot["postid"],
      postUrl: snapshot["posturl"],
      profileImage: snapshot["profileimage"],
      uid: snapshot["uid"],
      username: snapshot["username"],
    );
  }
}
