import 'package:firebase_auth/firebase_auth.dart';

class API {
  static var uid = FirebaseAuth.instance.currentUser!.uid; //user id
  static var host = 'vihaanserver.herokuapp.com/api'; //server path

  /* -------------------------------- USERS ------------------------------- */

  static var newUser = "/user/new-user"; //new user
  static var userDetails = "/user/users/"; //user details
  static var loginUser = "/user/users/"; //login user
  static var updateUser = "/user/users/"; //update user
  static var allUsers = "/user/all-users"; //all users

  /* -------------------------------- PRODUCTS -------------------------------- */

  static var newProduct = "/product/new-product"; //new product
  static var productDetails = "/product/products/"; //product details
  static var allProducts = "/product/all-products"; //all products
  static var updateProduct = "/product/products/"; //update product
  static var deleteProduct = "/product/products/"; //delete product
  static var allProductsByCategory = "/product/category-id/"; //product by category
  static var allProductsModelId = "/product/model-id/"; //product by model

  /* ------------------------------- TEST RIDES ------------------------------- */

  static var newTestRide = "/test-ride/new-test-ride-request"; //new test ride
  static var testRideDetails = "/test-ride/test-rides/"; //test ride details
  static var updateTestRide = "/test-ride/test-rides/"; //update test ride
  static var deleteTestRide = "/test-ride/test-rides/"; //delete test ride
  static var allTestRides = "/test-ride/all-test-rides"; //all test rides

  /* -------------------------------- SETTINGS -------------------------------- */
  static var newSettings = "/settings/new-settings"; //new settings
  static var settingsById = "/settings/settings/"; //settings by id
  static var settingsByDocId = "/settings/doc-id/"; //settings by doc id
  static var allSettings = "/settings/all-settings"; //all settings

}
