enum OrderStatus {
  pending('Pending'),
  processing('Processing'),
  shipped('Shipped'),
  delivered('Delivered'),
  outForDelivery('Out for delivery'),
  cancelled('Cancelled');

  const OrderStatus(this.value);

  final String value;
}
