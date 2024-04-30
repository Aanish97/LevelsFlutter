import 'package:flutter/material.dart';
import 'package:levels_athletes_coaches/widgets/richText.dart';

Widget searchResultCard(
  String? name,
  String? sportName,
  String? location,
  String? profilePic,
  String description,
  BuildContext context,
  final Function() ontap,
) {
  return GestureDetector(
    onTap: ontap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: ClipOval(
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                color: Colors.red,
                                child: ClipOval(
                                  child: Container(
                                    color: Colors.white,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Image.asset(
                                        profilePic!,
                                        fit: BoxFit.cover,
                                        width: 70,
                                        height: 70,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Colors.white),
                              ),
                              richText('Sport:', sportName!),
                              richText('Location:', location!)
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          (description.isNotEmpty)
                              ? description
                              : "no bio exits",
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              )),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade600,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(5),
                  child: const Icon(
                    Icons.message_rounded,
                    color: Colors.black,
                    size: 22,
                  )),
            ),
          ),
        ],
      ),
    ),
  );
}
