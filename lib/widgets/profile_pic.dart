import 'dart:io';

import 'package:flutter/material.dart';
import 'package:levels_athletes_coaches/constants.dart';
import 'package:levels_athletes_coaches/helper/utils.dart';

class ProfilePicWidget extends StatefulWidget {
  String? imagePath;
  Function onClicked;

  ProfilePicWidget({
    super.key,
    this.imagePath,
    required
    this.onClicked,
  });

  @override
  _ProfilePicWidgetState createState() => _ProfilePicWidgetState();
}

class _ProfilePicWidgetState extends State<ProfilePicWidget> {

  String profileImage = (Constants.isAthlete)
      ? Constants.athleteModel?.profileImage ?? ''
      : Constants.coachModel?.profileImage ?? '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          ClipOval(
            child: Container(
              padding: const EdgeInsets.all(5),
              color: Colors.red,
              child: ClipOval(
                child: Container(
                  color: Colors.white,
                  child: Material(
                    color: Colors.transparent,
                    child: widget.imagePath!.isNotEmpty ? Image.file(
                      File(widget.imagePath!),
                      fit: BoxFit.cover,
                      width: 120,
                      height: 120,
                    ): profileImage.isNotEmpty
                        ? Image.network(
                      insertAuthPath(profileImage),
                      fit: BoxFit.cover,
                      width: 120,
                      height: 120,
                    )
                        : Image.asset(
                      'assets/images/demo.png',
                      fit: BoxFit.cover,
                      width: 120,
                      height: 120,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(),
          ),
        ],
      ),
    );
  }

  Widget buildEditIcon() =>
      buildCircle(
        color: Colors.red,
        all: 3,
        child: buildCircle(
          color: Colors.red,
          all: 8,
          child: const Icon(
            Icons.add_a_photo,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      InkWell(
        onTap: () {
          widget.onClicked();
        },
        child: ClipOval(
          child: Container(
            padding: EdgeInsets.all(all),
            color: color,
            child: child,
          ),
        ),
      );
}
