// @dart=2.9
class NoteBook {
  int id;
  String title;
  String content;
  String date;

  NoteBook({this.content, this.title, this.id, this.date});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "Title": title,
      "Content": content,
      "Date": date,
    };
  }
}
