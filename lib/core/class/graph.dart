class SalesData {
  final String day;
  final double sales;
  SalesData(this.day, this.sales);
}

class CategorySales {
  final String category;
  final double salesPercent;
  CategorySales(this.category, this.salesPercent);
}

class RevenueData {
  final String month;
  final double amount;
  RevenueData(this.month, this.amount);
}

class OrderStatusData {
  final String status;
  final double percent;
  OrderStatusData(this.status, this.percent);
}

class DeliveryWorkerData {
  final String userName;
  final int numberOfOrders;
  final String userPfpUrl;

  DeliveryWorkerData(this.userName, this.numberOfOrders, this.userPfpUrl);
}
