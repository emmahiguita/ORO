class RatingModel {
  int? ratingId;
  String? ratingStars;
  String? ratingComment;
  String? ratingDatetime;
  int? userId;
  String? userName;
  String? userPfp;

  RatingModel(
      {this.ratingId,
      this.ratingStars,
      this.ratingComment,
      this.ratingDatetime,
      this.userId,
      this.userName,
      this.userPfp});

  RatingModel.fromJson(Map<String, dynamic> json) {
    ratingId = json['rating_id'];
    ratingStars = json['rating_stars'];
    ratingComment = json['rating_comment'];
    ratingDatetime = json['rating_datetime'];
    userId = json['user_id'];
    userName = json['user_name'];
    userPfp = json['user_pfp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rating_id'] = ratingId;
    data['rating_stars'] = ratingStars;
    data['rating_comment'] = ratingComment;
    data['rating_datetime'] = ratingDatetime;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['user_pfp'] = userPfp;
    return data;
  }
}
