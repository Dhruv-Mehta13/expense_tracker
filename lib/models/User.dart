class User {
  String? sId;
  String? username;
  String? email;
  String? password;
  int? monthlyBudget;
  CategoryBudgets? categoryBudgets;
  int? iV;

  User(
      {this.sId,
      this.username,
      this.email,
      this.password,
      this.monthlyBudget,
      this.categoryBudgets,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    monthlyBudget = json['monthlyBudget'];
    categoryBudgets = json['categoryBudgets'] != null
        ? new CategoryBudgets.fromJson(json['categoryBudgets'])
        : null;
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['monthlyBudget'] = this.monthlyBudget;
    if (this.categoryBudgets != null) {
      data['categoryBudgets'] = this.categoryBudgets!.toJson();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class CategoryBudgets {
  int? foodDining;
  int? housing;
  int? transportation;
  int? healthcare;
  int? entertainment;
  int? utilities;
  int? personalCare;
  int? others;

  CategoryBudgets(
      {this.foodDining,
      this.housing,
      this.transportation,
      this.healthcare,
      this.entertainment,
      this.utilities,
      this.personalCare,
      this.others});

  CategoryBudgets.fromJson(Map<String, dynamic> json) {
    foodDining = json['Food & Dining'];
    housing = json['Housing'];
    transportation = json['Transportation'];
    healthcare = json['Healthcare'];
    entertainment = json['Entertainment'];
    utilities = json['Utilities'];
    personalCare = json['Personal Care'];
    others = json['Others'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Food & Dining'] = this.foodDining;
    data['Housing'] = this.housing;
    data['Transportation'] = this.transportation;
    data['Healthcare'] = this.healthcare;
    data['Entertainment'] = this.entertainment;
    data['Utilities'] = this.utilities;
    data['Personal Care'] = this.personalCare;
    data['Others'] = this.others;
    return data;
  }
}
