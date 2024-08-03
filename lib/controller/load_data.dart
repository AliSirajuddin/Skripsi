class Data {
  final String name;
  final String code;
  final String pass;

  const Data({
    required this.name,
    required this.code,
    required this.pass,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      name: json['name'] as String,
      code: json['code'] as String,
      pass: json['password'] as String,
    );
  }
}
