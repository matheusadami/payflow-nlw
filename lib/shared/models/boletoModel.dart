import 'dart:convert';

class BoletoModel {
  final String? name;
  final double? value;
  final String? dueDate;
  final String? barcode;
  final bool? isPay;

  BoletoModel({
    this.name,
    this.isPay = false,
    this.value,
    this.dueDate,
    this.barcode,
  });

  BoletoModel copyWith({
    String? name,
    double? value,
    String? dueDate,
    String? barcode,
    bool? isPay,
  }) {
    return BoletoModel(
      name: name ?? this.name,
      isPay: isPay ?? this.isPay,
      value: value ?? this.value,
      dueDate: dueDate ?? this.dueDate,
      barcode: barcode ?? this.barcode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isPay': isPay,
      'value': value,
      'dueDate': dueDate,
      'barcode': barcode,
    };
  }

  factory BoletoModel.fromMap(Map<String, dynamic> map) {
    return BoletoModel(
      name: map['name'],
      value: map['value'],
      isPay: map['isPay'],
      dueDate: map['dueDate'],
      barcode: map['barcode'],
    );
  }

  factory BoletoModel.fromJson(String json) {
    return BoletoModel.fromMap(jsonDecode(json));
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator == (Object other) {
    if (identical(this, other)) return true;
  
    return other is BoletoModel &&
      other.name == name &&
      other.isPay == isPay &&
      other.value == value &&
      other.dueDate == dueDate &&
      other.barcode == barcode;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      isPay.hashCode ^
      value.hashCode ^
      dueDate.hashCode ^
      barcode.hashCode;
  }
}
