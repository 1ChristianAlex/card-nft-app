class CardModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? likes;
  Tier? tier;
  List<ThumbnailModel>? thumbnail;

  CardModel(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.likes,
      this.tier,
      this.thumbnail});

  CardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    likes = json['likes'];
    tier = json['tier'] != null ? Tier.fromJson(json['tier']) : null;
    if (json['thumbnail'] != null) {
      thumbnail = <ThumbnailModel>[];
      json['thumbnail'].forEach((v) {
        thumbnail!.add(ThumbnailModel.fromJson(v));
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

class ThumbnailModel {
  int? id;
  String? description;
  String? path;
  int? position;

  ThumbnailModel({this.id, this.description, this.path, this.position});

  ThumbnailModel.fromJson(Map<String, dynamic> json) {
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
