import 'package:get/get.dart';
import '../models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/ticket_type_model.dart';
import '../core/theme/app_theme.dart';
import '../services/event_service.dart';

class EventsController extends GetxController {
  final EventService _eventService = Get.find<EventService>();

  final RxList<EventModel> events = <EventModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;

  // --- DETAIL STATE ---
  final Rx<EventModel?> currentEvent = Rx<EventModel?>(null);
  final RxBool isLoadingDetails = false.obs;
  final RxString detailErrorMessage = ''.obs;

  // --- FORM STATE (CREATE / EDIT) ---
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController ticketNameController = TextEditingController();
  final TextEditingController ticketPriceController = TextEditingController();
  final TextEditingController ticketQuantityController =
      TextEditingController();

  EventModel? originalEvent;
  bool get isEditMode => originalEvent != null;

  final Rx<File?> selectedImage = Rx<File?>(null);
  final Rx<String?> currentImageUrl = Rx<String?>(null);
  final Rx<DateTime?> eventDate = Rx<DateTime?>(null);
  final Rx<TimeOfDay?> startTime = Rx<TimeOfDay?>(null);
  final Rx<TimeOfDay?> endTime = Rx<TimeOfDay?>(null);
  final RxList<TicketType> tickets = <TicketType>[].obs;
  final RxBool isSubmitting = false.obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    loadEvents();
  }

  @override
  void onClose() {
    titleController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    ticketNameController.dispose();
    ticketPriceController.dispose();
    ticketQuantityController.dispose();
    super.onClose();
  }

  // ==========================================
  // --- MODULE DETAILS ---
  // ==========================================

  Future<void> loadEventDetails(String id) async {
    try {
      isLoadingDetails.value = true;
      detailErrorMessage.value = '';

      // Check local cache first
      try {
        final localEvent = events.firstWhere((e) => e.id == id);
        currentEvent.value = localEvent;
        return;
      } catch (_) {}

      final fetchedEvent = await _eventService.getEventById(id);
      currentEvent.value = fetchedEvent;
    } on StateError {
      detailErrorMessage.value =
          "Cet événement n'existe plus ou est introuvable.";
    } catch (e) {
      detailErrorMessage.value =
          "Impossible de charger les détails de l'événement.";
    } finally {
      isLoadingDetails.value = false;
    }
  }

  void showTicketOptions(TicketType ticket) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(AppTheme.spacingL),
        decoration: const BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Gestion: ${ticket.name}', style: AppTheme.heading2),
            const SizedBox(height: AppTheme.spacingM),
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.white),
              title: const Text(
                'Modifier le billet',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Get.back();
                Get.snackbar('En dev', 'Formulaire de modification à venir');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.pause_circle_outline,
                color: AppTheme.goldColor,
              ),
              title: const Text(
                'Mettre en pause les ventes',
                style: TextStyle(color: AppTheme.goldColor),
              ),
              onTap: () {
                Get.back();
                Get.snackbar('Action', 'Ventes suspendues pour ce billet');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.delete_outline,
                color: Colors.redAccent,
              ),
              title: const Text(
                'Supprimer ce billet',
                style: TextStyle(color: Colors.redAccent),
              ),
              onTap: () {
                Get.back();
                Get.snackbar(
                  'Suppression',
                  'Billet retiré avec succès',
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white,
                );
              },
            ),
            const SizedBox(height: AppTheme.spacingM),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  // ==========================================
  // --- MODULE CREATE / EDIT ---
  // ==========================================

  void initCreateForm() {
    originalEvent = null;
    titleController.clear();
    locationController.clear();
    descriptionController.clear();
    selectedImage.value = null;
    currentImageUrl.value = null;
    eventDate.value = null;
    startTime.value = null;
    endTime.value = null;
    tickets.clear();
  }

  void initEditForm(EventModel event) {
    originalEvent = event;
    titleController.text = event.title;
    locationController.text = event.location;
    descriptionController.text = event.description;
    currentImageUrl.value = event.imageUrl;

    eventDate.value = event.startDate;
    startTime.value = TimeOfDay.fromDateTime(event.startDate);
    endTime.value = TimeOfDay.fromDateTime(event.endDate);

    tickets.clear();
    tickets.addAll(event.tickets);
  }

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image != null) {
        selectedImage.value = File(image.path);
      }
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Impossible de sélectionner l\'image : $e',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  void removeImage() {
    selectedImage.value = null;
    if (isEditMode) {
      currentImageUrl.value = null;
    }
  }

  Future<void> selectEventDate() async {
    final context = Get.context!;
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: eventDate.value ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime(2030),
      builder: (context, child) => _buildDarkDatePickerTheme(context, child),
    );
    if (pickedDate != null) eventDate.value = pickedDate;
  }

  Future<void> selectStartTime() async {
    final context = Get.context!;
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: startTime.value ?? TimeOfDay.now(),
      builder: (context, child) => _buildDarkDatePickerTheme(context, child),
    );
    if (pickedTime != null) {
      startTime.value = pickedTime;
      if (endTime.value == null) {
        int endHour = pickedTime.hour + 4;
        if (endHour > 23) endHour -= 24;
        endTime.value = TimeOfDay(hour: endHour, minute: pickedTime.minute);
      }
    }
  }

  Future<void> selectEndTime() async {
    final context = Get.context!;
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: endTime.value ?? (startTime.value ?? TimeOfDay.now()),
      builder: (context, child) => _buildDarkDatePickerTheme(context, child),
    );
    if (pickedTime != null) endTime.value = pickedTime;
  }

  Widget _buildDarkDatePickerTheme(BuildContext context, Widget? child) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: const ColorScheme.dark(
          primary: AppTheme.goldColor,
          onPrimary: Colors.black,
          surface: AppTheme.surfaceDark,
          onSurface: Colors.white,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: AppTheme.goldColor),
        ),
      ),
      child: child!,
    );
  }

  String? validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) return 'Ce champ est requis';
    return null;
  }

  void addTicket() {
    if (ticketNameController.text.trim().isEmpty ||
        ticketPriceController.text.trim().isEmpty ||
        ticketQuantityController.text.trim().isEmpty) {
      Get.snackbar(
        'Erreur',
        'Veuillez remplir tous les champs du billet.',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }
    final price = double.tryParse(ticketPriceController.text.trim()) ?? 0.0;
    final quantity = int.tryParse(ticketQuantityController.text.trim()) ?? 0;
    final newTicket = TicketType(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: ticketNameController.text.trim(),
      price: price,
      totalQuantity: quantity,
    );
    tickets.add(newTicket);
    ticketNameController.clear();
    ticketPriceController.clear();
    ticketQuantityController.clear();
    Get.back();
  }

  void removeTicket(TicketType ticket) => tickets.remove(ticket);

  Future<void> saveFormEvent() async {
    if (!formKey.currentState!.validate()) {
      Get.snackbar(
        'Erreur',
        'Veuillez remplir tous les champs.',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }
    if (eventDate.value == null ||
        startTime.value == null ||
        endTime.value == null) {
      Get.snackbar(
        'Erreur',
        'Veuillez définir la date et les horaires.',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isSubmitting.value = true;
      final d = eventDate.value!;
      final sT = startTime.value!;
      final eT = endTime.value!;

      final finalStartDate = DateTime(
        d.year,
        d.month,
        d.day,
        sT.hour,
        sT.minute,
      );
      DateTime finalEndDate = DateTime(
        d.year,
        d.month,
        d.day,
        eT.hour,
        eT.minute,
      );
      if (finalEndDate.isBefore(finalStartDate)) {
        finalEndDate = finalEndDate.add(const Duration(days: 1));
      }

      String finalImageUrl = '';
      if (isEditMode) {
        finalImageUrl = originalEvent!.imageUrl ?? '';
      }
      if (selectedImage.value != null) {
        finalImageUrl = selectedImage.value!.path;
      } else if (isEditMode && currentImageUrl.value == null) {
        finalImageUrl = '';
      }

      if (isEditMode) {
        final updatedEvent = originalEvent!.copyWith(
          title: titleController.text.trim(),
          description: descriptionController.text.trim(),
          startDate: finalStartDate,
          endDate: finalEndDate,
          location: locationController.text.trim(),
          imageUrl: finalImageUrl,
          tickets: tickets.toList(),
        );

        await Future.delayed(const Duration(seconds: 1));
        final index = events.indexWhere((e) => e.id == updatedEvent.id);
        if (index != -1) events[index] = updatedEvent;

        if (currentEvent.value?.id == updatedEvent.id) {
          currentEvent.value = updatedEvent;
        }

        Get.until((route) => route.isFirst);
        Get.snackbar(
          'Succès',
          'Événement mis à jour',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        return;
      }

      final newEvent = EventModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        startDate: finalStartDate,
        endDate: finalEndDate,
        location: locationController.text.trim(),
        imageUrl: finalImageUrl,
        status: EventStatus.pending,
        tickets: tickets.toList(),
        createdAt: DateTime.now(),
      );

      await _eventService.createEvent(newEvent);
      events.insert(0, newEvent);

      Get.back();
      Get.snackbar(
        'Succès',
        'Événement créé',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Échec: $e',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> loadEvents() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final fetchedEvents = await _eventService.fetchEvents();
      events.assignAll(fetchedEvents);
    } catch (e) {
      errorMessage.value = 'Erreur lors du chargement des événements: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  // Filtered Events
  List<EventModel> get filteredEvents {
    if (searchQuery.value.trim().isEmpty) {
      return events;
    }
    final query = searchQuery.value.toLowerCase();
    return events
        .where(
          (event) =>
              event.title.toLowerCase().contains(query) ||
              event.location.toLowerCase().contains(query),
        )
        .toList();
  }
}
