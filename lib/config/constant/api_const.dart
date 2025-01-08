const String baseUrl = 'https://lomfu.pythonanywhere.com/';
const String version = 'api/v1';

const int connectTimeout = 5000;
const int receiveTimeout = 5000;

Map<String, String> apps = {
  'accounts': '$version/accounts',
  'teachers': '$version/teachers',
  'courses': '$version/courses',
};

class Endpoints {
  // accounts
  static String login = '${apps['accounts']}/login/';
  static String register = '${apps['accounts']}/token/refresh/';
  static String refresh = '${apps['accounts']}/token/verify/';
  static String logout = '${apps['accounts']}/logout/';

  // teachers
  static String courses = '${apps['teachers']}/courses/';
  static String course = '${apps['teachers']}/courses/';
  static String courseCreate = '${apps['teachers']}/courses/create/';

  // courses
  static String subject = '${apps['courses']}/subjects/';
}
