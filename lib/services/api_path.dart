class APIPath {
  static String desp(String uid, String despId) => '/users/$uid/desp/$despId';
  static String despesas(String uid) => '/users/$uid/desp';
  static String ganho(String uid, String ganhoId) =>
      '/users/$uid/ganhos/$ganhoId';
  static String ganhos(String uid) => '/users/$uid/ganhos';
}
