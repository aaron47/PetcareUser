class ApiEndPoints {
  // AUTH URLS
  static const String BASE_URL = "https://us-central1-petcare-a1918.cloudfunctions.net/api/";
  static const String LOGIN_URL = "auth/login";
  static const String SIGN_UP_URL = "auth/signUp";
  static const String GET_USER_URL = "user/";

  // PETS URLS
  static const String ADD_PET_URL = "pets/addPet";
  static const String GET_PETS_URL = "pets/all/";

  // SERVICES URLS
  static const String ADD_SERVICE_URL = "services/create";
  static const String ADD_OFFERING_USER_URL = "services/addOfferingUser";
  static const String GET_SERVICES_URL = "services/findAll";
  static const String FIND_USER_SERVICES_URL = "services/findUserServices/";
}
