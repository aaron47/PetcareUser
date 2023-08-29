import 'package:get/get.dart';
import 'package:pet_user_app/models/reservation.dart';
import 'package:pet_user_app/network/remote/Requests/create_pet_request.dart';
import 'package:pet_user_app/network/remote/Requests/signup_request.dart';

import '../models/pet.dart';
import '../models/response_helper.dart';
import '../models/service.dart';
import '../models/user.dart';
import '../network/remote/Requests/login_request.dart';
import '../network/services/ApiService.dart';

class ApiController extends GetxController {
  var isLoading = false.obs;
  var status = true.obs;
  var error = ''.obs;
  var user = User().obs;
  var pets = <Pet>[].obs;
  var services = <Service>[].obs;
  var usersInService = <String>[].obs;
  var users = <User>[].obs;
  var userServices = <Service>[].obs;
  var reservations = <Reservation>[].obs;
  var reservationsUsers = <User>[].obs;
  var reservationsServices = <Service>[].obs;
  var reservationsPets = <Pet>[].obs;

  Future<ResponseHelper> loginUser(String email, String password) async {
    isLoading.value = true;
    try {
      var loggedInUser = await ApiService.login(LoginRequest(
        email: email,
        password: password,
      ));
      user.value = loggedInUser;
    } catch (e) {
      error.value = 'Error logging in';
    }

    isLoading.value = false;

    if (user.value.email == null) {
      status.value = false;
      return ResponseHelper(status: false, isLoading: isLoading.value);
    }

    status.value = true;
    return ResponseHelper(status: true, isLoading: isLoading.value);
  }

  Future<void> signUpUser(
    String fullName,
    String email,
    String gender,
    String role,
    String phone,
    String imageLink,
    String address,
    String password,
  ) async {
    isLoading.value = true;
    try {
      var signUpRequest = new SignUpRequest(
          fullName: fullName,
          email: email,
          phone: phone,
          imageLink: imageLink,
          address: address,
          password: password,
          gender: gender,
          role: role);
      await ApiService.signUp(signUpRequest);
    } catch (e) {
      error.value = 'Error signing up';
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addPet(CreatePetRequest createPetRequest) async {
    isLoading.value = true;
    try {
      var pet = await ApiService.addPet(createPetRequest);
      pets.add(pet);
    } catch (e) {
      error.value = 'Error adding pet';
    } finally {
      isLoading.value = false;
    }

    return isLoading.value;
  }

  Future<void> fetchUserPets(String userEmail) async {
    if (pets.length > 0) {
      return;
    }
    isLoading.value = true;
    try {
      pets.clear();
      var userPets = await ApiService.findAllUserPets(userEmail);
      pets.addAll(userPets);
      print("Fetched pets: ${pets.length}");
    } catch (e) {
      error.value = 'Error fetching user pets: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchUserServices(String userEmail) async {
    isLoading.value = true;
    try {
      var userServices = await ApiService.findUserServices(userEmail);
      services.value = userServices;
    } catch (e) {
      error.value = 'Error fetching user services';
    } finally {
      isLoading.value = false;
    }
  }

  Future<ResponseHelper> findUsersInService(String serviceId) async {
    isLoading.value = true;
    try {
      var usersInServiceResponse =
          await ApiService.findAllUsersInService(serviceId);
      usersInService.value = usersInServiceResponse;
      for (var email in usersInService) {
        var user = await ApiService.getUser(email);
        users.add(user);
      }
    } catch (e) {
      error.value = 'Error fetching users in service';
    }

    isLoading.value = false;

    status.value = true;
    return ResponseHelper(status: true, isLoading: isLoading.value);
  }

  Future<void> fetchAllReservations() async {
    isLoading.value = true;
    try {
      var allReservations = await ApiService.findAllReservations();
      reservations.addAll(allReservations);

      for (var reservation in allReservations) {
        var user = await ApiService.getUserById(reservation.sitterId);
        reservationsUsers.add(user);
        var service = await ApiService.getService(reservation.serviceId);
        reservationsServices.add(service);
        var pet = await ApiService.getPet(reservation.petId);
        reservationsPets.add(pet);
      }
    } catch (e) {
      error.value = 'Error fetching reservations';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> declineReservation(String id) async {
    isLoading.value = true;
    try {
      await ApiService.declineReservation(id);
    } catch (e) {
      error.value = 'Error declining reservation';
    } finally {
      isLoading.value = false;
    }
  }

  void clearUsersList() {
    users.clear();
  }

  void clearReservationsList() {
    reservations.clear();
    reservationsUsers.clear();
    reservationsServices.clear();
    reservationsPets.clear();
  }
}
