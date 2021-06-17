import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/entities/movie_entity.dart';

class ArrayResponse<T> extends Equatable {
  final int page;
  final int pageSize;
  final int totalPages;
  final List<T> results;

  ArrayResponse({
    this.page,
    this.pageSize,
    this.totalPages,
    this.results,
  });

  ArrayResponse<T> copyWith({int page, int pageSize, int total, int totalPages, T result, List<T> results}) => ArrayResponse<T>(
        page: page ?? this.page,
        pageSize: pageSize ?? this.pageSize,
        totalPages: totalPages ?? this.totalPages,
        results: results ?? this.results,
      );

  factory ArrayResponse.fromJson(Map<String, dynamic> json, T Function(Object json) objectFromJson) {
    ArrayResponse<T> resultGeneric = ArrayResponse<T>(
      page: json['page'] as int ?? 1,
      pageSize: json['page_size'] as int ?? 1,
      totalPages: json['total_pages'] as int ?? 1,
    );
    if (json['results'] != null) {
      if (json['results'] is List) {
        return resultGeneric.copyWith(
          results: (json['results'] as List)?.map(objectFromJson)?.toList(),
        );
      }
    }
    return resultGeneric;
  }

  @override
  List<Object> get props => [
        page,
        pageSize,
        totalPages,
        results,
      ];
}
