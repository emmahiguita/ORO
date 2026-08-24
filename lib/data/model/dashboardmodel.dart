class DashboardModel {
  String? status;
  String? sales;
  int? order;
  int? items;
  int? customer;
  List<Orders>? orders;
  List<TopProducts>? topProducts;
  List<SalesOverWeek>? salesOverWeek;
  List<TopCategories>? topCategories;
  List<SalesOverMonth>? salesOverMonth;
  List<OrdersNumber>? ordersNumber;
  List<DeliveryWorkers>? deliveryWorkers;

  DashboardModel(
      {this.status,
      this.sales,
      this.order,
      this.items,
      this.customer,
      this.orders,
      this.topProducts,
      this.salesOverWeek,
      this.topCategories,
      this.salesOverMonth,
      this.ordersNumber,
      this.deliveryWorkers});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sales = json['sales'];
    order = json['order'];
    items = json['items'];
    customer = json['customer'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
    if (json['topProducts'] != null) {
      topProducts = <TopProducts>[];
      json['topProducts'].forEach((v) {
        topProducts!.add(TopProducts.fromJson(v));
      });
    }
    if (json['salesOverWeek'] != null) {
      salesOverWeek = <SalesOverWeek>[];
      json['salesOverWeek'].forEach((v) {
        salesOverWeek!.add(SalesOverWeek.fromJson(v));
      });
    }
    if (json['topCategories'] != null) {
      topCategories = <TopCategories>[];
      json['topCategories'].forEach((v) {
        topCategories!.add(TopCategories.fromJson(v));
      });
    }
    if (json['salesOverMonth'] != null) {
      salesOverMonth = <SalesOverMonth>[];
      json['salesOverMonth'].forEach((v) {
        salesOverMonth!.add(SalesOverMonth.fromJson(v));
      });
    }
    if (json['Orders_Number'] != null) {
      ordersNumber = <OrdersNumber>[];
      json['Orders_Number'].forEach((v) {
        ordersNumber!.add(OrdersNumber.fromJson(v));
      });
    }
    if (json['Delivery_Workers'] != null) {
      deliveryWorkers = <DeliveryWorkers>[];
      json['Delivery_Workers'].forEach((v) {
        deliveryWorkers!.add(DeliveryWorkers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['sales'] = sales;
    data['order'] = order;
    data['items'] = items;
    data['customer'] = customer;
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    if (topProducts != null) {
      data['topProducts'] = topProducts!.map((v) => v.toJson()).toList();
    }
    if (salesOverWeek != null) {
      data['salesOverWeek'] = salesOverWeek!.map((v) => v.toJson()).toList();
    }
    if (topCategories != null) {
      data['topCategories'] = topCategories!.map((v) => v.toJson()).toList();
    }
    if (salesOverMonth != null) {
      data['salesOverMonth'] = salesOverMonth!.map((v) => v.toJson()).toList();
    }
    if (ordersNumber != null) {
      data['Orders_Number'] = ordersNumber!.map((v) => v.toJson()).toList();
    }
    if (deliveryWorkers != null) {
      data['Delivery_Workers'] =
          deliveryWorkers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  int? orderId;
  int? orderTotalprice;
  double? orderStatus;
  String? userName;
  String? userPfp;

  Orders(
      {this.orderId,
      this.orderTotalprice,
      this.orderStatus,
      this.userName,
      this.userPfp});

  Orders.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderTotalprice = json['order_totalprice'];
    orderStatus = (json['order_status'] as num?)?.toDouble();
    userName = json['user_name'];
    userPfp = json['user_pfp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['order_totalprice'] = orderTotalprice;
    data['order_status'] = orderStatus;
    data['user_name'] = userName;
    data['user_pfp'] = userPfp;
    return data;
  }
}

class TopProducts {
  String? itemName;
  double? itemPrice;
  int? itemDiscount;
  String? itemImg;
  int? totalSold;

  TopProducts(
      {this.itemName,
      this.itemPrice,
      this.itemDiscount,
      this.itemImg,
      this.totalSold});

  TopProducts.fromJson(Map<String, dynamic> json) {
    itemName = json['item_name'];
    itemPrice = (json['item_price'] as num?)?.toDouble();
    itemDiscount = json['item_discount'];
    itemImg = json['item_img'];
    totalSold = json['total_sold'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_name'] = itemName;
    data['item_price'] = itemPrice;
    data['item_discount'] = itemDiscount;
    data['item_img'] = itemImg;
    data['total_sold'] = totalSold;
    return data;
  }
}

class SalesOverWeek {
  String? dayName;
  String? totalSales;
  int? orderCount;
  int? sortOrder;

  SalesOverWeek(
      {this.dayName, this.totalSales, this.orderCount, this.sortOrder});

  SalesOverWeek.fromJson(Map<String, dynamic> json) {
    dayName = json['day_name'];
    totalSales = json['total_sales'];
    orderCount = json['order_count'];
    sortOrder = json['sort_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day_name'] = dayName;
    data['total_sales'] = totalSales;
    data['order_count'] = orderCount;
    data['sort_order'] = sortOrder;
    return data;
  }
}

class TopCategories {
  int? totalSelling;
  String? categoryName;

  TopCategories({this.totalSelling, this.categoryName});

  TopCategories.fromJson(Map<String, dynamic> json) {
    totalSelling = json['Total_Selling'];
    categoryName = json['Category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Total_Selling'] = totalSelling;
    data['Category_name'] = categoryName;
    return data;
  }
}

class SalesOverMonth {
  String? monthShort;
  String? totalSales;

  SalesOverMonth({this.monthShort, this.totalSales});

  SalesOverMonth.fromJson(Map<String, dynamic> json) {
    monthShort = json['month_short'];
    totalSales = json['total_sales'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month_short'] = monthShort;
    data['total_sales'] = totalSales;
    return data;
  }
}

class OrdersNumber {
  int? ordersNumber;
  double? orderStatus;

  OrdersNumber({this.ordersNumber, this.orderStatus});

  OrdersNumber.fromJson(Map<String, dynamic> json) {
    ordersNumber = json['Orders_Number'];
    orderStatus = (json['order_status'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Orders_Number'] = ordersNumber;
    data['order_status'] = orderStatus;
    return data;
  }
}

class DeliveryWorkers {
  int? numberOfOrders;
  String? userName;
  String? userPfp;

  DeliveryWorkers({this.numberOfOrders, this.userName, this.userPfp});

  DeliveryWorkers.fromJson(Map<String, dynamic> json) {
    numberOfOrders = json['Number_Of_Orders'];
    userName = json['user_name'];
    userPfp = json['user_pfp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Number_Of_Orders'] = numberOfOrders;
    data['user_name'] = userName;
    data['user_pfp'] = userPfp;
    return data;
  }
}
