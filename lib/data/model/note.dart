class Note {
  String id;
  String title;
  String content;

  Note(this.id, this.title, this.content);

  Note.map(dynamic object) {
    this.id = object['id'];
    this.title = object['title'];
    this.content = object['content'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['title'] = title;
    map['content'] = content;
    return map;
  }
}
