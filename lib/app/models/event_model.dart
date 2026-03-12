import 'ticket_type_model.dart';

enum EventStatus { pending, published, cancelled, completed }

class EventModel {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final EventStatus status;
  final List<TicketType> tickets; // Replaced basePrice and totalTickets
  final DateTime createdAt;
  final DateTime? updatedAt;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.startDate,
    required this.endDate,
    required this.location,
    this.status = EventStatus.pending,
    this.tickets = const [],
    required this.createdAt,
    this.updatedAt,
  });

  // Helper getters
  double get minTicketPrice {
    if (tickets.isEmpty) return 0.0;
    return tickets.map((t) => t.price).reduce((a, b) => a < b ? a : b);
  }

  int get totalTicketsCapacity {
    return tickets.fold(0, (sum, ticket) => sum + ticket.totalQuantity);
  }

  int get totalTicketsSold {
    return tickets.fold(0, (sum, ticket) => sum + ticket.soldQuantity);
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String?,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      location: json['location'] as String,
      status: EventStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => EventStatus.pending,
      ),
      tickets:
          (json['tickets'] as List<dynamic>?)
              ?.map((e) => TicketType.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'location': location,
      'status': status.name,
      'tickets': tickets.map((e) => e.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  EventModel copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    DateTime? startDate,
    DateTime? endDate,
    String? location,
    EventStatus? status,
    List<TicketType>? tickets,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      location: location ?? this.location,
      status: status ?? this.status,
      tickets: tickets ?? this.tickets,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
