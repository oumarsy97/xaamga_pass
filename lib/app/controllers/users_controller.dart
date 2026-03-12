import 'package:get/get.dart';
import '../models/user_model.dart';

class UsersController extends GetxController {
  final users = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadMockUsers();
  }

  void _loadMockUsers() {
    users.assignAll([
      UserModel(
        id: 125,
        nom: null, // Nom inconnu
        role: UserRole.drink,
        username: 'Pass1694',
      ),
      UserModel(
        id: 49,
        nom: null,
        role: UserRole.checking,
        username: 'pass126',
      ),
      UserModel(
        id: 124,
        nom: null,
        role: UserRole.guichet,
        username: 'Pass9379',
      ),
      UserModel(id: 48, nom: null, role: UserRole.guichet, username: 'pass125'),
      UserModel(id: 50, nom: null, role: UserRole.food, username: 'pass127'),
    ]);
  }

  void toggleUserStatus(int id) {
    // Mock toggle logic
  }
}
