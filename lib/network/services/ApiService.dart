import 'package:dio/dio.dart';
import 'package:pet_user_app/network/remote/Requests/add_offering_user_request.dart';
import 'package:pet_user_app/network/remote/Requests/create_pet_request.dart';
import 'package:pet_user_app/network/remote/Requests/create_service_request.dart';
import 'package:pet_user_app/network/remote/Requests/login_request.dart';
import 'package:pet_user_app/network/remote/Requests/signup_request.dart';
import 'package:pet_user_app/network/remote/api_endpoints.dart';

import '../../models/pet.dart';
import '../../models/user.dart';
import '../../models/service.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();

  factory ApiService() => _instance;

  ApiService._internal();

  static final _options = BaseOptions(
    baseUrl: ApiEndPoints.BASE_URL,
    contentType: 'application/json; charset=UTF-8',
    //connectTimeout: 15000,
    //receiveTimeout: 15000,
    responseType: ResponseType.json,
  );

  // dio instance
  static final Dio _dio = Dio(_options)..interceptors.add(LogInterceptor());

  // AUTH
  static Future<User> login(LoginRequest loginRequest) {
    return _dio
        .post(
          ApiEndPoints.LOGIN_URL,
          data: loginRequest.toJson(),
        )
        .then((value) => User.fromJson(value.data));
  }

  static Future<User> signUp(SignUpRequest signUpRequest) {
    return _dio
        .post(
          ApiEndPoints.SIGN_UP_URL,
          data: signUpRequest.toJson(),
        )
        .then((value) => User.fromJson(value.data));
  }

  static Future<User> getUser(String email) {
    return _dio
        .get(
          ApiEndPoints.GET_USER_URL + email,
        )
        .then((value) => User.fromJson(value.data));
  }

  // PETS
  static Future<Pet> addPet(CreatePetRequest createPetRequest) {
    return _dio
        .post(
          ApiEndPoints.ADD_PET_URL,
          data: createPetRequest.toJson(),
        )
        .then((value) => Pet.fromJson(value.data));
  }

  static Future<List<Pet>> findAllUserPets(String userEmail) async {
    try {
      final response = await _dio.get(ApiEndPoints.GET_PETS_URL + userEmail);
      List<Pet> pets = (response.data as List)
          .map((json) => Pet.fromJson(json))
          .toList();
      return pets;
    } catch (error) {
      throw Exception("Error fetching user pets: $error");
    }
  }

  // SERVICES
  static Future<Service> addService(CreateServiceRequest createServiceRequest) {
    return _dio
        .post(
          ApiEndPoints.ADD_SERVICE_URL,
          data: createServiceRequest.toJson(),
        )
        .then((value) => Service.fromJson(value.data));
  }

  static Future<Service> addOfferingUser(
      AddOfferingUserRequest addOfferingUserRequest) {
    return _dio
        .post(
          ApiEndPoints.ADD_OFFERING_USER_URL,
          data: addOfferingUserRequest.toJson(),
        )
        .then((value) => Service.fromJson(value.data));
  }

  static Future<List<Service>> findUserServices(String userEmail) {
    return _dio
        .get(
          ApiEndPoints.FIND_USER_SERVICES_URL + userEmail,
        )
        .then((value) =>
            List<Service>.from(value.data.map((x) => Service.fromJson(x))));
  }

  static Future<List<Service>> findAllServices(String userEmail) {
    return _dio
        .get(
          ApiEndPoints.GET_SERVICES_URL + userEmail,
        )
        .then((value) =>
            List<Service>.from(value.data.map((x) => Service.fromJson(x))));
  }
}
