class TicketType {
  final String id;
  final String name; // e.g., 'VIP', 'Standard', 'Early Bird'
  final String? description;
  final double price;
  final int totalQuantity;
  final int soldQuantity;

  TicketType({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.totalQuantity,
    this.soldQuantity = 0,
  });

  bool get isSoldOut => soldQuantity >= totalQuantity;
  int get remainingQuantity => totalQuantity - soldQuantity;

  factory TicketType.fromJson(Map<String, dynamic> json) {
    return TicketType(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num).toDouble(),
      totalQuantity: json['totalQuantity'] as int,
      soldQuantity: json['soldQuantity'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'totalQuantity': totalQuantity,
      'soldQuantity': soldQuantity,
    };
  }

  TicketType copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    int? totalQuantity,
    int? soldQuantity,
  }) {
    return TicketType(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      soldQuantity: soldQuantity ?? this.soldQuantity,
    );
  }
}
