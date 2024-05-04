class Stats {
  int? totalMonthlySpend;
  CategorySpends? categorySpends;
  int? totalSpendAllTime;
  int? monthlyBudget;
  CategorySpends? categoryBudgets;

  Stats(
      {this.totalMonthlySpend = 0,
      this.categorySpends,
      this.totalSpendAllTime = 0,
      this.monthlyBudget = 0,
      this.categoryBudgets}) {
    this.categorySpends = CategorySpends();
    this.categoryBudgets = CategorySpends();
  }

  Stats.fromJson(Map<String, dynamic> json) {
    totalMonthlySpend = json['totalMonthlySpend'];
    categorySpends = json['categorySpends'] != null
        ? new CategorySpends.fromJson(json['categorySpends'])
        : null;
    totalSpendAllTime = json['totalSpendAllTime'];
    monthlyBudget = json['monthlyBudget'];
    categoryBudgets = json['categoryBudgets'] != null
        ? new CategorySpends.fromJson(json['categoryBudgets'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalMonthlySpend'] = this.totalMonthlySpend;
    if (this.categorySpends != null) {
      data['categorySpends'] = this.categorySpends!.toJson();
    }
    data['totalSpendAllTime'] = this.totalSpendAllTime;
    data['monthlyBudget'] = this.monthlyBudget;
    if (this.categoryBudgets != null) {
      data['categoryBudgets'] = this.categoryBudgets!.toJson();
    }
    return data;
  }
}

class CategorySpends {
  int? foodDining;
  int? housing;
  int? transportation;
  int? healthcare;
  int? entertainment;
  int? utilities;
  int? personalCare;
  int? others;

  CategorySpends(
      {this.foodDining = 0,
      this.housing = 0,
      this.transportation = 0,
      this.healthcare = 0,
      this.entertainment = 0,
      this.utilities = 0,
      this.personalCare = 0,
      this.others = 0});

  CategorySpends.fromJson(Map<String, dynamic> json) {
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
