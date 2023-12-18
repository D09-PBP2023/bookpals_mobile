class Endpoints {
  static const baseUrl =
      'http://127.0.0.1:8000'; // Or change to 'https://bookpals-d09-tk.pbp.cs.ui.ac.id/' for production
  static const loginUrl = '$baseUrl/login-mobile/';
  static const registerUrl = '$baseUrl/register-mobile/';
  static const logoutUrl = '$baseUrl/logout-mobile/';

  static const getProfile = '$baseUrl/profileflutter/';
  // static bookmarkUrl = '$baseUrl/bookmarkflutter/';
  static String bookmarkUrl(int id) =>
      '$baseUrl/bookmarkflutter/$id';
  static const getBooksUrl = '$baseUrl/get-books/';
  static String searchBooksUrl(String name) =>
      '$baseUrl/get-books-by-name/$name';
  static String searchBookByGenresUrl(String genre) =>
      '$baseUrl/get-books-by-genre/$genre';
}
