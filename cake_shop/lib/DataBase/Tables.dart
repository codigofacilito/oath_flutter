class Tables{
  static const COUNT = "count";
  static const USER = "user";

  static const TABLES =
  [
    "CREATE TABLE IF NOT EXISTS " +
        COUNT +
        "("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "access_token TEXT,"
            "refresh_token TEXT,"
            "token_type TEXT,"
            "expire_time TEXT,"
            "created_at TEXT,"
            "expires_in TEXT"
            ")",
    "CREATE TABLE IF NOT EXISTS " +
        USER +
        "("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "email TEXT,"
            "username TEXT,"
            "name TEXT"
            ")"
  ];

}