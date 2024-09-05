import 'dart:convert';
class Pdf {
  final String customer;
  final List<String> pdfs;
  final String? id;
  Pdf({
    required this.customer,
    required this.pdfs,
    this.id,
  });


  Map<String, dynamic> toMap() {
    return {
      'customer': customer,
      'pdfs': pdfs,
      'id': id,
    };
  }

  factory Pdf.fromMap(Map<String, dynamic> map) {
    return Pdf(
      customer: map['customer'] ?? '',
      pdfs: List<String>.from(map['pdfs']),
      id: map['_id'],
    );
  }
  String toJson() => json.encode(toMap());

  factory Pdf.fromJson(String source) => Pdf.fromMap(json.decode(source));
}
