// import 'package:expansion_tile_card/expansion_tile_card.dart';
// import 'package:flutter/material.dart';
// import 'package:levels_athletes_coaches/Screens/Athelete/booktime_screen.dart';
// import 'package:levels_athletes_coaches/constants.dart';
// import 'package:levels_athletes_coaches/helper/utils.dart';
// import 'package:levels_athletes_coaches/widgets/richText.dart';
// import 'package:levels_athletes_coaches/constants/app_images.dart';
//
// class CoachProfileScreen extends StatefulWidget {
//   const CoachProfileScreen({super.key});
//
//   @override
//   State<CoachProfileScreen> createState() => _CoachProfileScreenState();
// }
//
// class _CoachProfileScreenState extends State<CoachProfileScreen> {
//   final GlobalKey<ExpansionTileCardState> cardAvailability = GlobalKey();
//   final GlobalKey<ExpansionTileCardState> cardContent = GlobalKey();
//   final GlobalKey<ExpansionTileCardState> cardTrainingProgram = GlobalKey();
//   bool isExpandedAvailability = false;
//   bool isExpandedContent = false;
//   bool isExpandedTrainingProgram = false;
//   List<String> images = [
//     AppImages.backgroundImage,
//     AppImages.backgroundImage,
//     AppImages.backgroundImage
//   ];
//
//   String profileImage = (Constants.isAthlete)
//       ? Constants.athleteModel!.profileImage!
//       : Constants.coachModel!.profileImage!;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//             image: AssetImage(AppImages.backgroundImage),
//             fit: BoxFit.fill),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.black.withOpacity(0.5),
//         body: Column(
//           children: [
//             SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 12.0),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Image.asset(
//                     'assets/images/logo.png',
//                     height: 90,
//                     width: 90,
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: SizedBox(
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       const Text(
//                         'COACH',
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.white),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Center(
//                         child: Stack(
//                           children: [
//                             ClipOval(
//                               child: Container(
//                                 padding: const EdgeInsets.all(5),
//                                 color: Colors.red,
//                                 child: ClipOval(
//                                   child: Container(
//                                     color: Colors.white,
//                                     child: Material(
//                                       color: Colors.transparent,
//                                       child: profileImage.isNotEmpty
//                                           ? Image.network(
//                                         insertAuthPath(profileImage),
//                                         fit: BoxFit.cover,
//                                         width: 50,
//                                         height: 50,
//                                       )
//                                           : Image.asset(
//                                         'assets/images/demo.png',
//                                         fit: BoxFit.cover,
//                                         width: 50,
//                                         height: 50,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const Positioned(
//                               bottom: 2,
//                               right: 3,
//                               child: Icon(
//                                 Icons.verified,
//                                 color: Colors.red,
//                                 size: 30,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                         child: Container(
//                           height: 130,
//                           width: MediaQuery.of(context).size.width * 1,
//                           decoration: BoxDecoration(
//                             color: Colors.black.withOpacity(0.8),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   'MALIK SCOTT',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 18),
//                                 ),
//                                 richText('Sport: ', 'BOXING'),
//                                 richText('Location: ', 'Los Angeles'),
//                                 richText('Gym(s): ', 'Brickhouse Boxing Club'),
//                                 richText(
//                                     'Available for online training: ', 'Yes'),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                         child: ExpansionTileCard(
//                           baseColor: Colors.black,
//                           expandedColor: Colors.black,
//                           expandedTextColor: Colors.white,
//                           key: cardAvailability,
//                           title: const Text(
//                             'Availability',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           trailing: isExpandedAvailability
//                               ? const Icon(
//                                   Icons.arrow_drop_down,
//                                   color: Colors.red,
//                                 )
//                               : const Icon(
//                                   Icons.arrow_forward_ios_rounded,
//                                   color: Colors.red,
//                                 ),
//                           onExpansionChanged: (expanded) {
//                             setState(() {
//                               isExpandedAvailability = expanded;
//                             });
//                           },
//                           children: <Widget>[
//                             Padding(
//                               padding: const EdgeInsets.only(bottom: 12.0),
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: SingleChildScrollView(
//                                   scrollDirection: Axis.horizontal,
//                                   child: Row(
//                                     children: [
//                                       const SizedBox(
//                                         width: 18,
//                                       ),
//                                       dateBox('June', '01', 'Los Angeles', () {
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     const BookATime()));
//                                       }),
//                                       const SizedBox(
//                                         width: 5,
//                                       ),
//                                       dateBox('June', '02', 'Los Angeles', () {
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) => BookATime()));
//                                       }),
//                                       const SizedBox(
//                                         width: 5,
//                                       ),
//                                       dateBox('June', '03', 'Los Angeles', () {
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     const BookATime()));
//                                       }),
//                                       const SizedBox(
//                                         width: 5,
//                                       ),
//                                       dateBox('June', '05', 'Los Angeles', () {
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     const BookATime()));
//                                       }),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                         child: ExpansionTileCard(
//                           baseColor: Colors.black,
//                           expandedColor: Colors.black,
//                           expandedTextColor: Colors.white,
//                           key: cardContent,
//                           title: const Text(
//                             'Content',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           trailing: isExpandedContent
//                               ? const Icon(
//                                   Icons.arrow_drop_down,
//                                   color: Colors.red,
//                                 )
//                               : const Icon(
//                                   Icons.arrow_forward_ios_rounded,
//                                   color: Colors.red,
//                                 ),
//                           onExpansionChanged: (expanded) {
//                             setState(() {
//                               isExpandedContent = expanded;
//                             });
//                           },
//                           children: <Widget>[
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 10.0),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     color: Colors.grey,
//                                     borderRadius: BorderRadius.circular(10)),
//                                 child: ListTile(
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10)),
//                                   leading: const Icon(
//                                     Icons.restore_page,
//                                     color: Colors.white,
//                                   ),
//                                   title: const Text(
//                                     'Certificate 01',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                   onTap: () {},
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 10.0),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     color: Colors.grey,
//                                     borderRadius: BorderRadius.circular(10)),
//                                 child: ListTile(
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10)),
//                                   leading: const Icon(
//                                     Icons.restore_page,
//                                     color: Colors.white,
//                                   ),
//                                   title: const Text(
//                                     'Certificate 02',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                   onTap: () {},
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                         child: ExpansionTileCard(
//                           baseColor: Colors.black,
//                           expandedColor: Colors.black,
//                           expandedTextColor: Colors.white,
//                           key: cardTrainingProgram,
//                           title: const Text(
//                             'Training Programs',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           trailing: isExpandedTrainingProgram
//                               ? const Icon(
//                                   Icons.arrow_drop_down,
//                                   color: Colors.red,
//                                 )
//                               : const Icon(
//                                   Icons.arrow_forward_ios_rounded,
//                                   color: Colors.red,
//                                 ),
//                           onExpansionChanged: (expanded) {
//                             setState(() {
//                               isExpandedTrainingProgram = expanded;
//                             });
//                           },
//                           children: <Widget>[
//                             SingleChildScrollView(
//                               scrollDirection: Axis.horizontal,
//                               child: Row(
//                                 children: images
//                                     .map(
//                                       (image) => Stack(
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 vertical: 8.0, horizontal: 8),
//                                             child: ClipRRect(
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                               child: SizedBox(
//                                                 width: 80,
//                                                 height: 70,
//                                                 child: Image.asset(image,
//                                                     fit: BoxFit.cover),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                     .toList(),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget dateBox(String month, String date, String city, Function() onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           Container(
//             width: 90,
//             height: 30,
//             color: Colors.red,
//             child: Center(
//               child: Text(
//                 month,
//                 style: const TextStyle(
//                     color: Colors.white, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//           Container(
//             width: 90,
//             height: 50,
//             color: Colors.white,
//             child: Center(
//               child: Text(
//                 date,
//                 style:
//                     const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
//               ),
//             ),
//           ),
//           SizedBox(
//             child: Center(
//               child: Text(
//                 city,
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
