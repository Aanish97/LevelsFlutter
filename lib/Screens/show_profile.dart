import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:levels_athletes_coaches/constants.dart';
import 'package:levels_athletes_coaches/helper/utils.dart';
import 'package:levels_athletes_coaches/models/coach_model.dart';
import 'package:levels_athletes_coaches/models/user_model.dart';
import 'package:levels_athletes_coaches/widgets/richText.dart';

class ShowProfileScreen extends StatefulWidget {
  final CoachModel? coachModel;
  final AthleteModel? athleteModel;
  final bool isCoach;

  const ShowProfileScreen(
      {super.key, this.coachModel, this.athleteModel, required this.isCoach});

  @override
  State<ShowProfileScreen> createState() => _ShowProfileScreenState();
}

class _ShowProfileScreenState extends State<ShowProfileScreen> {
  List<String> images = [
    backgroundImage,
    backgroundImage,
    backgroundImage
  ];

  String profileImage = (Constants.isAthlete)
      ? Constants.athleteModel!.profileImage!
      : Constants.coachModel!.profileImage!;

  @override
  Widget build(BuildContext context) {
    print(widget.coachModel!.dateJoined);
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SafeArea(
                child: Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: const Icon(Icons.arrow_back_ios_new_rounded, size: 30,color: Colors.white,),
                          )),
                      Image.asset(
                        'assets/images/logo.png',
                        height: 200,
                        width: 200,
                      ),
                      SizedBox(width: 30,)
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: SizedBox(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            widget.isCoach ? 'COACH' : 'ATHLETE',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ClipOval(
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              color: Colors.red,
                              child: ClipOval(
                                child: Container(
                                  color: Colors.white,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: profileImage.isNotEmpty
                                        ? Image.network(
                                            insertAuthPath(profileImage),
                                            fit: BoxFit.cover,
                                            width: 50,
                                            height: 50,
                                          )
                                        : Image.asset(
                                            'assets/images/demo.png',
                                            fit: BoxFit.cover,
                                            width: 50,
                                            height: 50,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 130,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${widget.isCoach ? widget.coachModel!.name : widget.athleteModel?.name}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(height: 10,),
                                  richText('Date Joined: ',
                                      "${widget.isCoach ? (widget.coachModel!.dateJoined != null ? DateFormat('yyyy-MM-dd').format(widget.coachModel!.dateJoined!) : '') : (widget.athleteModel?.dateJoined != null ? DateFormat('yyyy-MM-dd').format(widget.athleteModel!.dateJoined!) : '')}"),
                                  // richText(
                                  //     'Training Jui-Jitsu since: ', '2023'),
                                  // richText('Attainment: ', 'Black Belt'),
                                  richText('Gym(s): ', "${widget.isCoach ? widget.coachModel!.location : widget.athleteModel?.location}"),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // Container(
                          //   padding: const EdgeInsets.all(8),
                          //   width: MediaQuery.of(context).size.width * 0.8,
                          //   decoration: BoxDecoration(
                          //     color: Colors.black.withOpacity(0.8),
                          //     borderRadius: BorderRadius.circular(15),
                          //   ),
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: Column(
                          //       children: [
                          //         const Text(
                          //           'UPLOAD CONTENT',
                          //           style: TextStyle(
                          //               color: Colors.white,
                          //               fontWeight: FontWeight.bold,
                          //               fontSize: 18),
                          //         ),
                          //         Container(
                          //           decoration: BoxDecoration(
                          //               color: Colors.grey,
                          //               borderRadius:
                          //                   BorderRadius.circular(10)),
                          //           child: ListTile(
                          //             shape: RoundedRectangleBorder(
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             leading: const Icon(
                          //               Icons.restore_page,
                          //               color: Colors.white,
                          //             ),
                          //             title: const Text(
                          //               'Certificate 01',
                          //               style: TextStyle(color: Colors.white),
                          //             ),
                          //             trailing: Container(
                          //                 decoration: BoxDecoration(
                          //                   color: Colors.grey.shade600,
                          //                   shape: BoxShape.circle,
                          //                 ),
                          //                 padding: const EdgeInsets.all(5),
                          //                 child: const Icon(
                          //                   Icons.delete,
                          //                   color: Colors.black,
                          //                 )),
                          //             onTap: () {},
                          //           ),
                          //         ),
                          //         const SizedBox(
                          //           height: 10,
                          //         ),
                          //         Container(
                          //           decoration: BoxDecoration(
                          //               color: Colors.grey,
                          //               borderRadius:
                          //                   BorderRadius.circular(10)),
                          //           child: ListTile(
                          //             shape: RoundedRectangleBorder(
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             leading: const Icon(
                          //               Icons.restore_page,
                          //               color: Colors.white,
                          //             ),
                          //             title: const Text(
                          //               'Certificate 02',
                          //               style: TextStyle(color: Colors.white),
                          //             ),
                          //             trailing: Container(
                          //                 decoration: BoxDecoration(
                          //                   color: Colors.grey.shade600,
                          //                   shape: BoxShape.circle,
                          //                 ),
                          //                 padding: const EdgeInsets.all(5),
                          //                 child: const Icon(
                          //                   Icons.delete,
                          //                   color: Colors.black,
                          //                 )),
                          //             onTap: () {},
                          //           ),
                          //         ),
                          //         const SizedBox(
                          //           height: 10,
                          //         ),
                          //         Wrap(
                          //           spacing: 8,
                          //           children: images
                          //               .map(
                          //                 (image) => Stack(
                          //                   children: [
                          //                     Padding(
                          //                       padding:
                          //                           const EdgeInsets.symmetric(
                          //                               vertical: 8.0),
                          //                       child: ClipRRect(
                          //                         borderRadius:
                          //                             BorderRadius.circular(5),
                          //                         child: SizedBox(
                          //                           width: 80,
                          //                           height: 70,
                          //                           child: Image.asset(image,
                          //                               fit: BoxFit.cover),
                          //                         ),
                          //                       ),
                          //                     ),
                          //                     Positioned(
                          //                       top: 2,
                          //                       right: 2,
                          //                       child: GestureDetector(
                          //                         onTap: () {},
                          //                         child: Container(
                          //                             decoration: BoxDecoration(
                          //                               color: Colors
                          //                                   .grey.shade600,
                          //                               shape: BoxShape.circle,
                          //                             ),
                          //                             padding:
                          //                                 const EdgeInsets.all(
                          //                                     5),
                          //                             child: const Icon(
                          //                               Icons.delete,
                          //                               color: Colors.black,
                          //                               size: 12,
                          //                             )),
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //               )
                          //               .toList(),
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
