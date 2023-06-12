// ignore_for_file: file_names

class UserClass {
  String? userID;
  String? firstname;
  String? lastname;
  String? username;
  String? email;
  String? profileURL;
  String? gender;
  int? age;
  double? userRating;
  String? bio;
  List? interests;

  String? joinedAt;
  List? posts;
  int? cupcakes;
  int? postCount;
  Map? votes;

  UserClass({
    this.userID,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.postCount,
    required this.email,
    required this.profileURL,
    required this.gender,
    required this.age,
    required this.bio,
    required this.interests,
    this.userRating,
    this.joinedAt,
    this.cupcakes,
    this.posts,
    this.votes,
  });

  factory UserClass.fromJson(Map<dynamic, dynamic> userData) {
    return UserClass(
        userID: userData["_id"],
        postCount: userData["posts"].length,
        firstname: userData["firstname"],
        lastname: userData["lastname"],
        username: userData["username"] ?? "null",
        email: userData["email"] ?? "null",
        profileURL: userData["profileURL"] ?? "null",
        gender: userData["gender"] ?? "null",
        age: userData["age"] ?? -1,
        bio: userData["bio"] ?? "This is my bio",
        interests: userData["interests"] ?? [],
        userRating: userData["userRating"],
        joinedAt: userData["joinedAt"],
        cupcakes: userData["cupcakes"],
        posts: userData["posts"],
        votes: userData["votes"]);
  }

  static Map<String, dynamic> toJson(UserClass user) {
    return {
      "joinedAt": user.joinedAt,
      "_id": user.userID,
      "firstname": user.firstname,
      "postCount": user.postCount,
      "lastname": user.lastname,
      "username": user.username,
      "profileURL": user.profileURL,
      "cupcakes": user.cupcakes,
      "email": user.email,
      "gender": user.gender,
      "age": user.age,
      "bio": user.bio,
      "userRating": user.userRating,
      "interests": user.interests,
      "posts": user.posts,
      "votes": user.votes,
    };
  }
}
