class Quote {
  String? id;
   String? content;
   String? author;
  List<String>? tags;
  String? authorSlug;
  int? length;
  DateTime? dateAdded;
  DateTime? dateModified;

  Quote({
     this.id,
     this.content,
     this.author,
     this.tags,
     this.authorSlug,
     this.length,
     this.dateAdded,
     this.dateModified,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json["_id"],
      content: json["content"],
      author: json["author"],
      tags: List<String>.from(json["tags"].map((x) => x)),
      authorSlug: json["authorSlug"],
      length: json["length"],
      dateAdded: DateTime.parse(json["dateAdded"]),
      dateModified: DateTime.parse(json["dateModified"]),
    );
  }
}

// {
// "_id": "kbd0ItzHwGdq",
// "content": "If you change the way you look at things, the things you look at change.",
// "author": "Wayne Dyer",
// "tags": [
// "Change",
// "Wisdom"
// ],
// "authorSlug": "wayne-dyer",
// "length": 72,
// "dateAdded": "2020-07-10",
// "dateModified": "2023-04-14"
// }
