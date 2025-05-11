class Transaction {
  final String id;
  final String description;
  final double amount;
  final int date;

  Transaction({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      description: json['description'],
      amount: json['amount'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "amount": amount,
    "date": date,
  };
}
