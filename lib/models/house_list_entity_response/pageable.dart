import 'package:json_annotation/json_annotation.dart';

import 'sort.dart';

part 'pageable.g.dart';

@JsonSerializable()
class Pageable {
  Sort? sort;
  int? offset;
  int? pageNumber;
  int? pageSize;
  bool? paged;
  bool? unpaged;

  Pageable({
    this.sort,
    this.offset,
    this.pageNumber,
    this.pageSize,
    this.paged,
    this.unpaged,
  });

  factory Pageable.fromJson(Map<String, dynamic> json) {
    return _$PageableFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PageableToJson(this);
}
