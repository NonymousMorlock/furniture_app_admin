enum OrderStatus {
  pending('Pending'),
  processing('Processing'),
  outForDelivery('Out for delivery'),
  shipped('Shipped'),
  delivered('Delivered'),
  cancelled('Cancelled');

  const OrderStatus(this.value);

  final String value;
}
