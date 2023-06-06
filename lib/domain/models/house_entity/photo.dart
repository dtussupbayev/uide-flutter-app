import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo.g.dart';

@JsonSerializable()
class Photo {
  String? id;
  String? link;
  String? localDate;

  Photo({this.id, this.link, this.localDate});

  @override
  String toString() => 'Photo(id: $id, link: $link, localDate: $localDate)';

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Photo) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => id.hashCode ^ link.hashCode ^ localDate.hashCode;
}
