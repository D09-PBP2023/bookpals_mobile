class Endpoints {
  static const baseUrl =
      'http://10.0.2.2:8000'; // Or change to 'https://bookpals-d09-tk.pbp.cs.ui.ac.id/' for production
  static const loginUrl = '$baseUrl/login-mobile/';
  static const registerUrl = '$baseUrl/register-mobile/';
  static const logoutUrl = '$baseUrl/logout-mobile/';
  static const getBooksUrl = '$baseUrl/get-books/';
  static const requestSwap = '$baseUrl/create_swap_mobile/';
  static String searchBooksUrl(String name) =>
      '$baseUrl/get-books-by-name/$name';
  static String searchBookByGenresUrl(String genre) =>
      '$baseUrl/get-books-by-genre/$genre';
}
