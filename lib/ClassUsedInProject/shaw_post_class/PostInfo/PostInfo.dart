
class PostInfo{

  String postId;
  String content;
  String status;
  String createdAt;
  String userId;
  String yearAndSectionId;
  List<dynamic> postLike;
  List<dynamic> postComment;

  PostInfo({this.postId,this.userId,this.content,this.createdAt,this.status,
  this.yearAndSectionId,this.postComment,this.postLike});
}