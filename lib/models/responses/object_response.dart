import 'package:equatable/equatable.dart';

class ObjectResponse<T> extends Equatable {
  final bool success;
  final int code;
  final String locale;
  final String message;
  final String returnCode;
  final T data;

  bool get isSuccess {
    return returnCode == "10000";
  }

  ObjectResponse({this.success, this.code, this.locale, this.message, this.returnCode, this.data});

  ObjectResponse<T> copyWith({
    bool success,
    int code,
    String locale,
    String message,
    String returnCode,
    T data,
  }) =>
      ObjectResponse<T>(
        success: success ?? this.success,
        code: code ?? this.code,
        locale: locale ?? this.locale,
        message: message ?? this.message,
        returnCode: returnCode ?? this.returnCode,
        data: data ?? this.data,
      );

  factory ObjectResponse.fromJson(Map<String, dynamic> json, T Function(Object json) objectFromJson) {
    ObjectResponse<T> resultGeneric = ObjectResponse<T>(
      success: json['success'] as bool ?? false,
      code: json['code'] as int ?? 0,
      locale: json['locale'] as String ?? '',
      message: json['message'] as String ?? '',
      returnCode: json['returnCode'] as String ?? '',
    );
    if (json['data'] != null) {
      if (json['data'] is String) {
        return resultGeneric.copyWith(
          data: null,
        );
      } else if (json['data'] is! List) {
        return resultGeneric.copyWith(
          data: objectFromJson(json['data']),
        );
      }
    }
    return resultGeneric;
  }

  @override
  List<Object> get props => [this.success, this.code, this.locale, this.data];
}
