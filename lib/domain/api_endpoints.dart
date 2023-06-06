class ApiEndPoints {
  static const String baseUrl =
      'https://rent-house-production-82fe.up.railway.app/';
}

abstract class AuthEndPoints {
  static const String signUp = 'api/auth/signup';
  static const String signIn = 'api/auth/signin';
  static const String sendOtp = 'api/auth/otp';
  static const String checkOtp = 'api/auth/otp/check';
  static const String isExist = 'api/auth/is-exist';
}

abstract class HouseEndPoints {
  static const String uploadImage = 'aws';
  static const String createHouse = 'houses';
  static const String savedHouses = 'houses/saved';
}

abstract class ApiParameters {
  static const String cityIdAlmaty = '2c918118885dfac501885e0b1a110005';
  static const String cityIdAstana = '2c918118885dfac501885dfcfdf80001';
}
