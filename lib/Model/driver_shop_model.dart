class DriverShop {
  final String online;
  final String discount;
  final String shopName;
  final String checkamt;
  final int salesid;
  final String transactionDate;
  final String cash;
  final String balance;
  final int shopId;

  DriverShop({
    required this.online,
    required this.discount,
    required this.shopName,
    required this.checkamt,
    required this.salesid,
    required this.transactionDate,
    required this.cash,
    required this.balance,
    required this.shopId,
  });

  factory DriverShop.fromJson(Map<String, dynamic> json) {
    return DriverShop(
      online: json['online'] ?? '0.00',
      discount: json['discount'] ?? '0.00',
      shopName: json['shopname'] ?? '',
      checkamt: json['checkamt'] ?? '0.00',
      salesid: json['salesid'],
      transactionDate: json['transactiondate'] ?? '',
      cash: json['cash'] ?? '0.00',
      balance: json['balance'] ?? '0.00',
      shopId: json['shopid'],
    );
  }
}
