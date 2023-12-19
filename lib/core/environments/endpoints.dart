class Endpoints {
  static const baseUrl =
      'https://bookpals-d09-tk.pbp.cs.ui.ac.id'; // Or change to 'https://bookpals-d09-tk.pbp.cs.ui.ac.id' for production
  static const loginUrl = '$baseUrl/login-mobile/';
  static const registerUrl = '$baseUrl/register-mobile/';
  static const logoutUrl = '$baseUrl/logout-mobile/';
  static const getBooksUrl = '$baseUrl/get-books/';
  static const getProfile = '$baseUrl/profileflutter/';
  static String editFav(int id) => '$baseUrl/fav-mobile/$id';

  // static bookmarkUrl = '$baseUrl/bookmarkflutter/';
  static String bookmarkUrl(int id) => '$baseUrl/bookmarkflutter/$id';
  static const editProfile = '$baseUrl/editprofile-mobile/';
  static String searchBooksUrl(String name) =>
      '$baseUrl/get-books-by-name/$name';
  static String searchBookByGenresUrl(String genre) =>
      '$baseUrl/get-books-by-genre/$genre';
  static const addReview = '$baseUrl/add-review-flutter/';
  static String getReview(int id) => '$baseUrl/get_review/$id';
  static String getAverageRating(int id) => '$baseUrl/get_average_rating/$id';
}
