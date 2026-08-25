import 'package:oro/core/functions/json_parser.dart';

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
    ratingId = JsonParser.asInt(json['rating_id']);
    ratingStars = JsonParser.asString(json['rating_stars']) ?? '5';
    ratingComment = JsonParser.asString(json['rating_comment']) ?? '';
    ratingDatetime = JsonParser.asString(json['rating_datetime']);
    userId = JsonParser.asInt(json['user_id']);
    userName = JsonParser.asString(json['user_name']) ?? 'Usuario';
    userPfp = JsonParser.asString(json['user_pfp']);
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
