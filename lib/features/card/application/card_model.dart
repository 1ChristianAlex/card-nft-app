class Card {
  int? id;
  String? name;
  String? description;
  int? price;
  int? likes;
  Tier? tier;
  List<Thumbnail>? thumbnail;

  Card(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.likes,
      this.tier,
      this.thumbnail});

  Card.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    likes = json['likes'];
    tier = json['tier'] != null ? Tier.fromJson(json['tier']) : null;
    if (json['thumbnail'] != null) {
      thumbnail = <Thumbnail>[];
      json['thumbnail'].forEach((v) {
        thumbnail!.add(Thumbnail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['likes'] = likes;
    if (tier != null) {
      data['tier'] = tier!.toJson();
    }
    if (thumbnail != null) {
      data['thumbnail'] = thumbnail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tier {
  int? id;
  String? name;
  String? description;
  int? value;

  Tier({this.id, this.name, this.description, this.value});

  Tier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['value'] = value;
    return data;
  }
}

class Thumbnail {
  int? id;
  String? description;
  String? path;
  int? position;

  Thumbnail({this.id, this.description, this.path, this.position});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    path = json['path'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['path'] = path;
    data['position'] = position;
    return data;
  }
}
