// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:vihaanelectrix/providers/universal_provider.dart';
// import 'package:vihaanelectrix/widgets/search_widget.dart';
// import 'package:http/http.dart' as http;
// import 'package:vihaanelectrix/widgets/text_wid.dart';

// class OnlinePlaceSearch extends StatefulWidget {
//   final Function? onSave;
//   const OnlinePlaceSearch({Key? key, this.onSave}) : super(key: key);
//   @override
//   OnlinePlaceSearchState createState() => OnlinePlaceSearchState();
// }

// class OnlinePlaceSearchState extends State<OnlinePlaceSearch> {
//   // List<Places> geoLocations = [];
//   String query = '';
//   Timer? debouncer;
//   UniversalProvider? universalProvider;

//   @override
//   void initState() {
//     super.initState();
//     universalProvider = Provider.of<UniversalProvider>(context, listen: false);

//     init();
//   }

//   @override
//   void dispose() {
//     debouncer?.cancel();
//     super.dispose();
//   }

//   void debounce(
//     VoidCallback callback, {
//     Duration duration = const Duration(milliseconds: 1000),
//   }) {
//     if (debouncer != null) {
//       debouncer!.cancel();
//     }

//     debouncer = Timer(duration, callback);
//   }

//   Future init() async {
//     if (universalProvider!.geoLocations.isNotEmpty) return;
//     // var geoLocationss = await PlacesApi.getLoc(query);
//     universalProvider!.setLocationsLoader(true);
//     List getLoctions = await getAllLocations();
//     universalProvider!.setLocationsLoader(false);
//     universalProvider!.setProducts(getLoctions);
//     // setState(() => this.geoLocations = geoLocations);
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         body: Consumer<UniversalProvider>(builder: (context, data, child) {
//           return SafeArea(
//             child: Column(
//               children: [
//                 buildSearch(),
//                 data.locationsLoader
//                     ? SizedBox(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             CircularProgressIndicator(
//                               color: Colors.indigo[900],
//                               backgroundColor: Colors.grey[100],
//                             ),
//                             SizedBox(
//                               height: 25,
//                             ),
//                             TextWidget(
//                               text: 'Please Wait Data is Fetching ....',
//                             )
//                           ],
//                         ),
//                       )
//                     : Expanded(
//                         child: ListView.builder(
//                           itemCount: data.searchLocations.length,
//                           itemBuilder: (context, index) {
//                             final book = data.searchLocations[index];

//                             //return

//                             if (index == 0) {
//                               return ListTile(
//                                   onTap: () {
//                                     // Navigator.push(
//                                     //     context,
//                                     //     MaterialPageRoute(
//                                     //         builder: (context) => Maps(
//                                     //               isNavigate: false,
//                                     //               popBackTwice: true,
//                                     //               onSave: (cords, fullAddress) {
//                                     //                 if (widget.onSave == null)
//                                     //                   return snackbar(context,
//                                     //                       "something went wrong");
//                                     //                 widget.onSave(
//                                     //                     cords, fullAddress);
//                                     //                 Navigator.pop(context);
//                                     //               },
//                                     //             )));
//                                   },
//                                   leading: CircleAvatar(
//                                       backgroundColor: Colors.grey[200],
//                                       child: Icon(Icons.gps_fixed)),
//                                   title: TextWidget(
//                                     text: 'Your Location',
//                                     size: 15,
//                                     weight: FontWeight.w700,
//                                   ),
//                                   trailing: IconButton(
//                                     onPressed: () {},
//                                     icon: Icon(Icons.directions),
//                                   ));
//                             } else {
//                               return buildBook(book);
//                             }
//                           },
//                         ),
//                       ),
//               ],
//             ),
//           );
//         }),
//       );

//   Widget buildSearch() => SearchWidget(
//         text: query,
//         hintText: 'Find Place',
//         icon: Icons.location_searching,
//         onChanged: searchLocations,
//       );
//   searchLocations(String query) {
//     if (query.length > 3) {
//       dynamic searches = getArea(query, universalProvider!.geoLocations);
//       universalProvider!.setSearchLocations(searches);
//     } else if (query.isEmpty) {
//       universalProvider!.showAllLocation();
//     }
//   }

//   Future searchBook(String query) async => debounce(() async {
//         // final geoLocations = await PlacesApi.getLoc(query);

//         if (!mounted) return;

//         // setState(() {
//         //   this.query = query;
//         //   this.geoLocations = geoLocations;
//         // });
//       });

//   Widget buildBook(dynamic geo) => ListTile(
//       onTap: () {
//         log(geo['coordinates'].toString());

//         // Navigator.push(
//         //     context,
//         //     MaterialPageRoute(
//         //         builder: (context) => Maps(
//         //               coordinates: geo['coordinates'],
//         //               isNavigate: false,
//         //               isSearch: true,
//         //               popBackTwice: true,
//         //               onSave: (cords, fullAddress) {
//         //                 if (widget.onSave == null)
//         //                   return snackbar(context, "something went wrong");
//         //                 widget.onSave(cords, fullAddress);
//         //                 Navigator.pop(context);
//         //               },
//         //             )));
//       },
//       leading: CircleAvatar(
//         backgroundColor: Colors.grey[200],
//         child: Icon(
//           Icons.near_me,
//           color: Colors.grey[700],
//         ),
//       ),
//       title: TextWidget(
//         text: geo['subLocality'],
//         size: 15,
//         weight: FontWeight.w600,
//       ),
//       subtitle: TextWidget(
//         text: geo['addressLine'],
//         size: 12,
//       ),
//       trailing: IconButton(
//         onPressed: () {},
//         icon: Icon(Icons.directions),
//       ));
// }

// getArea(String searchAreaName, List geoLocationsList) {
//   // print(searchAreaName);
//   return geoLocationsList.where((geo) {
//     final subLocality = geo['subLocality'].toLowerCase();
//     final locality = geo['addressLine'].toLowerCase();
//     final coord = geo['coordinates'].toString();
//     final searchLower = searchAreaName.toLowerCase();

//     return subLocality.contains(searchLower) ||
//         locality.contains(searchLower) ||
//         coord.contains(searchLower);
//   }).toList();
// }

// Future<List> getAllLocations() async {
//   final url =
//       Uri.parse('https://vihaanserver.herokuapp.com/api/product/products/');
//   final response = await http.get(url);
//   // List data  = json.decode(response.body);

//   if (response.statusCode == 200) {
//     final List geoLocations = json.decode(response.body);
//     log('API Hit');
//     log(geoLocations.toString());

//     return geoLocations;
//   } else {
//     throw Exception();
//   }
// }
