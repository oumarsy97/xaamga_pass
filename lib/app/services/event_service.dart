import 'package:get/get.dart';
import '../models/event_model.dart';
import '../models/ticket_type_model.dart';

class EventService extends GetxService {
  // This will eventually connect to an API (Dio/http) or Database (Firebase/Supabase)
  // For now, we use a delayed mock to simulate network requests.

  Future<List<EventModel>> fetchEvents() async {
    await Future.delayed(const Duration(seconds: 1)); // Network simulation

    return [
      EventModel(
        id: 'evt_001',
        title: 'Tech Conference Dakar 2026',
        description:
            'La plus grande conférence Tech pour l\'Afrique de l\'Ouest.',
        imageUrl:
            'https://images.unsplash.com/photo-1540575467063-178a50c2df87?q=80&w=2070',
        startDate: DateTime.now().add(const Duration(days: 30)),
        endDate: DateTime.now().add(const Duration(days: 32)),
        location: 'Centre International du Commerce Extérieur (CICES)',
        status: EventStatus.published,
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        tickets: [
          TicketType(
            id: 'tkt_001_s',
            name: 'Standard',
            price: 15000,
            totalQuantity: 1000,
            soldQuantity: 450,
          ),
          TicketType(
            id: 'tkt_001_v',
            name: 'VIP Pass',
            price: 50000,
            totalQuantity: 100,
            soldQuantity: 85,
          ),
        ],
      ),
      EventModel(
        id: 'evt_002',
        title: 'Festival Xaamga Music',
        description:
            'Concert en plein air avec les plus grands artistes Afrobeat.',
        imageUrl:
            'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?q=80&w=2070',
        startDate: DateTime.now().add(const Duration(days: 15, hours: 20)),
        endDate: DateTime.now().add(const Duration(days: 16, hours: 2)),
        location: 'Monument de la Renaissance Africaine',
        status: EventStatus.published,
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        tickets: [
          TicketType(
            id: 'tkt_002_eb',
            name: 'Early Bird',
            price: 5000,
            totalQuantity: 500,
            soldQuantity: 500,
          ), // Sold out
          TicketType(
            id: 'tkt_002_n',
            name: 'Normal',
            price: 10000,
            totalQuantity: 2000,
            soldQuantity: 1120,
          ),
        ],
      ),
      EventModel(
        id: 'evt_003',
        title: 'Gala de Charité (En attente)',
        description: 'Soirée de bienfaisance - Planification en cours.',
        imageUrl:
            'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?q=80&w=2069',
        startDate: DateTime.now().add(const Duration(days: 90)),
        endDate: DateTime.now().add(const Duration(days: 90, hours: 5)),
        location: 'Hôtel King Fahd Palace',
        status: EventStatus.pending,
        createdAt: DateTime.now(),
        tickets: [
          TicketType(
            id: 'tkt_003_p',
            name: 'Premium Table',
            price: 250000,
            totalQuantity: 50,
          ),
        ],
      ),
    ];
  }

  Future<EventModel> getEventById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final allEvents = await fetchEvents();
    return allEvents.firstWhere((e) => e.id == id);
  }

  Future<bool> createEvent(EventModel event) async {
    await Future.delayed(const Duration(seconds: 1));
    // Simulated success
    return true;
  }
}
