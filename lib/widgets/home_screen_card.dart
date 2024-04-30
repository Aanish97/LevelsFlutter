import 'package:flutter/material.dart';

class ClickableCard extends StatefulWidget {
  final Icon icon;
  final String title;
  final Color color;
  final Color colorLight;
  final Function() onTap;

  const ClickableCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.color,
    required this.colorLight,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ClickableCard> createState() => _ClickableCardState();
}

class _ClickableCardState extends State<ClickableCard> {
  Color borderColor = Colors.grey;

  void changeBorderColor() {
    setState(() {
      borderColor = Colors.red;
    });
    widget.onTap();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        borderColor = Colors.grey;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: SizedBox(
        width: 140,
        height: 140,
        child: GestureDetector(
          onTap: () {
            changeBorderColor();
          },
          child: Card(
            color: widget.colorLight,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: borderColor,
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.icon,
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
