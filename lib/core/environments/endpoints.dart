class Endpoints {
  static const baseUrl =
      'http://10.0.2.2:8000'; // Or change to 'https://bookpals-d09-tk.pbp.cs.ui.ac.id/' for production
  static const loginUrl = '$baseUrl/login-mobile/';
  static const registerUrl = '$baseUrl/register-mobile/';
  static const logoutUrl = '$baseUrl/logout-mobile/';
  static const getBooksUrl = '$baseUrl/get_books/';
  static const requestSwap = '$baseUrl/create_swap_mobile/';
  static const acceptSwap = '$baseUrl/accept_swap_mobile/';
  static const finishedSwap = '$baseUrl/finish_swap_mobile/';
  static const cancelSwap = '$baseUrl/cancel_swap_mobile/';
  static const getProcessedSwap = '$baseUrl/get_processed_book_json/';
  static const getWaitingSwap = '$baseUrl/get_waiting_accept_book_json/';
  static const getAcceptedSwap = '$baseUrl/get_accepted_book_json/';
  static const getFinishedSwap = '$baseUrl/get_finished_book_json/';
  static String searchBooksUrl(String name) =>
      '$baseUrl/get-books-by-name/$name';
  static String searchBookByGenresUrl(String genre) =>
      '$baseUrl/get-books-by-genre/$genre';
  static String searchProcessedSwapUrl(String name) =>
      '$baseUrl/get_processed_book_search/$name';
  static String searchWaitingSwapUrl(String name) =>
      '$baseUrl/get_waiting_accept_book_search/$name';
  static String searchAcceptedSwapUrl(String name) =>
      '$baseUrl/get_accepted_book_search/$name';
  static String searchFinishedSwapUrl(String name) =>
      '$baseUrl/get_finished_book_search/$name';
}
