class NewsModel {
  int id;
  int posterId;
  String posterName;
  String posterAvatar;
  String title;
  String image;
  String time;
  int totalComment;

  NewsModel(this.id, this.posterId, this.posterName, this.posterAvatar,
      this.title, this.image, this.time, this.totalComment);
}
