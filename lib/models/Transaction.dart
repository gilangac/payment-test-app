class Transaction {
  Transaction({
    this.idTransaction,
    this.bankName,
    this.nominal,
    this.date,
  });

  int? idTransaction;
  String? bankName;
  String? nominal;
  DateTime? date;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        idTransaction: json["id_Transaction"],
        bankName: json["bank_name"],
        nominal: json["nominal"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id_Transaction": idTransaction,
        "bank_name": bankName,
        "nominal": nominal,
        "date": date!.toIso8601String(),
      };
}
