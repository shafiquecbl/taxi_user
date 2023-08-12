class Order {
  final int orderId;
  final String orderStatus;
  final DateTime orderDateTime;
  final String orderType;
  final int itemCount;
  final double orderAmount;
  final String deliveryAddress;

  Order({
    required this.orderId,
    required this.orderStatus,
    required this.orderDateTime,
    required this.orderType,
    required this.itemCount,
    required this.orderAmount,
    required this.deliveryAddress,
  });
}

List<Order> get orders => [
      Order(
        orderId: 1,
        orderStatus: 'Pending',
        orderDateTime: DateTime(2023, 10, 8, 11, 30),
        orderType: 'Take Away',
        itemCount: 3,
        orderAmount: 42.50,
        deliveryAddress: '123 Main St, City, Country',
      ),
      Order(
        orderId: 2,
        orderStatus: 'Pending',
        orderDateTime: DateTime(2023, 10, 8, 12, 15),
        orderType: 'Delivery',
        itemCount: 2,
        orderAmount: 30.00,
        deliveryAddress: '456 Elm St, City, Country',
      ),
      Order(
        orderId: 3,
        orderStatus: 'Pending',
        orderDateTime: DateTime(2023, 10, 8, 14, 45),
        orderType: 'Scheduled',
        itemCount: 4,
        orderAmount: 55.00,
        deliveryAddress: '789 Oak St, City, Country',
      ),
      Order(
        orderId: 4,
        orderStatus: 'Pending',
        orderDateTime: DateTime(2023, 10, 8, 15, 30),
        orderType: 'Take Away',
        itemCount: 1,
        orderAmount: 15.00,
        deliveryAddress: '987 Pine St, City, Country',
      ),
      Order(
        orderId: 5,
        orderStatus: 'Pending',
        orderDateTime: DateTime(2023, 10, 8, 16, 10),
        orderType: 'Delivery',
        itemCount: 3,
        orderAmount: 40.00,
        deliveryAddress: '654 Maple St, City, Country',
      ),
      // Similar orders for other statuses
      // ...
    ];

class OrderItem {
  final String image;
  final String name;
  final double price;
  final int quantity;
  final List<String> addons;
  final String variation;

  OrderItem({
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
    required this.addons,
    required this.variation,
  });
}
