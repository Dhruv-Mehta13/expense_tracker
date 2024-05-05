class Expense {
  String? name;
  int? amount;
  String? currencyType;
  String? description;
  String? category;
  String? user;
  String? sId;
  String? date;
  int? iV;

  Expense(
      {this.name,
      this.amount,
      this.currencyType,
      this.description,
      this.category,
      this.user,
      this.sId,
      this.date,
      this.iV});

  Expense.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    amount = json['amount'];
    currencyType = json['currencyType'];
    description = json['description'];
    category = json['category'];
    user = json['user'];
    sId = json['_id'];
    date = json['date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['currencyType'] = this.currencyType;
    data['description'] = this.description;
    data['category'] = this.category;
    data['user'] = this.user;
    data['_id'] = this.sId;
    data['date'] = this.date;
    data['__v'] = this.iV;
    return data;
  }
}
