import 'package:flutter/material.dart';
import 'package:levels_athletes_coaches/Screens/confirm_payment_screen.dart';
import 'package:levels_athletes_coaches/widgets/custom_button.dart';

import '../constants.dart';

class BookATime extends StatefulWidget {
  const BookATime({super.key});

  @override
  State<BookATime> createState() => _BookATimeState();
}

class _BookATimeState extends State<BookATime> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 90,
                  width: 90,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        width: MediaQuery.of(context).size.width * 1,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'BOOK A TIME',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const Text(
                                  'June 1, 2023',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                const Text(
                                  'Available Time',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: CustomButton(
                                      title: '8:00AM - 9:00AM',
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ConfirmPayment()));
                                      },
                                      isTransparent: false,
                                      textColor: Colors.white,
                                      height: 45),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: CustomButton(
                                      title: '10:00AM - 11:00AM',
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ConfirmPayment()));
                                      },
                                      isTransparent: true,
                                      textColor: Colors.white,
                                      height: 45),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: CustomButton(
                                      title: '11:00AM - 12:00AM',
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ConfirmPayment()));
                                      },
                                      isTransparent: true,
                                      textColor: Colors.white,
                                      height: 45),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: CustomButton(
                                      title: '12:00PM - 1:00PM',
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ConfirmPayment()));
                                      },
                                      isTransparent: true,
                                      textColor: Colors.white,
                                      height: 45),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: CustomButton(
                                      title: '1:00PM - 2:00PM',
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ConfirmPayment()));
                                      },
                                      isTransparent: true,
                                      textColor: Colors.white,
                                      height: 45),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: CustomButton(
                                      title: '3:00PM - 4:00PM',
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ConfirmPayment()));
                                      },
                                      isTransparent: true,
                                      textColor: Colors.white,
                                      height: 45),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
