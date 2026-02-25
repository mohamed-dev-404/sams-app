abstract class ApiKeys {
  ApiKeys._();

  //! --- JSON KEYS (The names that Dio sends and receives) ---

  //? Common Keys
  static const String status = 'status';
  static const String data = 'data';
  static const String message = 'message';
  static const String validationErrors = 'validationErrors';

  //? User Model Keys
  static const String id = '_id';
  static const String name = 'name';
  static const String academicEmail = 'academicEmail';
  static const String academicId = 'academicId';
  static const String password = 'password';
  static const String profilePic = 'profilePic';
  static const String isActive = 'isActive';
  static const String role = 'role';

  //? Pagination Keys
  static const String pagination = 'pagination';
  static const String totalElements = 'totalElements';
  static const String currentPage = 'currentPage';
  static const String size = 'size';
  static const String totalPages = 'totalPages';
  static const String hasNextPage = 'hasNextPage';
  static const String hasPrevPage = 'hasPrevPage';

  //? Fetch Users Params Keys
  static const String page = 'page';
  static const String sortBy = 'sortBy';
  static const String sortOrder = 'sortOrder';
  static const String roleId = 'roleId';
  static const String search = 'search';

  //? Auth Keys
  static const String authorization = 'Authorization';
  static const String user = 'user';
  static const String expiresIn = 'expiresIn';
  static const String refreshToken = 'refreshToken';
  static const String accessToken = 'accessToken';
  static const String resetToken = 'resetToken';
  static const String code = 'code';
  static const String action = 'action';
  static const String newPassword = 'newPassword';
  static const String confirmNewPassword = 'confirmNewPassword';
  static const String roles = 'roles';
  static const String student = 'student';
  static const String confirmPassword = 'confirmPassword';

  // static String errorMessage = 'businessErrorDescription';
  // static String email = 'email';
  // static String password = 'password';
  // static String confirmPassword = 'confirmPassword';
  // static String newPassword = 'newPassword';
  // static String firstName = 'firstName';
  // static String lastName = 'lastName';
  // static String phone = 'phone';
  // static String token = 'token';
  // static String tempToken = 'tempToken';
  // static String authorities = 'authorities';
  // static String authorization = 'Authorization';
  // static String name = 'name';
  // static String category = 'category';
  // static String description = 'description';
  // static String file = 'file';
  // ... more keys
}

//! --- API VALUES (Fixed values that the server expects inside the fields) ---

abstract class ApiValues {
  ApiValues._();

  //?  Sorting Values
  static const String createdAt = 'createdAt';
  static const String desc = 'desc';
  static const String asc = 'asc';

  //? User Status Values
  static const String active = 'active';
  static const String inactive = 'inactive';

  //? Roles
  static const String admin = 'admin';
  static const String instructor = 'instructor';
  static const String student = 'student';

  //? verify oyp actions
  static const String resetPassword = 'RESET_PASSWORD';
  static const String activateAccount = 'ACTIVATE_ACCOUNT';
}
