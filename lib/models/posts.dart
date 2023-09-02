import 'dart:convert';

class Post {
  final String id;
  final String titre;
  final String description;
  final String image;
  final String userId;

  Post({
     this.id,
     this.titre,
     this.description,
     this.image,
     this.userId,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      titre: json['titre'],
      description: json['description'],
      image: json['image'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'titre': titre,
      'description': description,
      'image': image,
      'userId': userId,
    };
  }

  static List<Post> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((jsonData) => Post.fromJson(jsonData)).toList();
  }

  static String toJsonList(List<Post> posts) {
    final List<Map<String, dynamic>> postList = posts.map((post) => post.toJson()).toList();
    return json.encode(postList);
  }
}