class Notes {
  var id;
  String? image, title, subtitle, content, lastModified;

  Notes({
    this.id = -1,
    this.image,
    this.title,
    this.subtitle,
    this.content,
    required this.lastModified,
  });

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
      id: map['id'],
      image: map['image'],
      title: map['title'],
      subtitle: map['subtitle'],
      content: map['content'],
      lastModified: map['last_modified'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'title': title,
      'subtitle': subtitle,
      'content': content,
      'last_modified': lastModified,
    };
  }
}
