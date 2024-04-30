import 'package:flutter/material.dart';
import 'package:levels_athletes_coaches/constants.dart';
import 'package:levels_athletes_coaches/widgets/custom_button.dart';

class BookingSuccess extends StatefulWidget {
  const BookingSuccess({super.key});

  @override
  State<BookingSuccess> createState() => _BookingSuccessState();
}

class _BookingSuccessState extends State<BookingSuccess> {
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
        backgroundColor: Colors.black.withOpacity(0.6),
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
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      const Icon(
                                        Icons.check_circle,
                                        size: 40,
                                        color: Colors.red,
                                      ),
                                      const Text(
                                        'SUCCESS!',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 32,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          text: const TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      'You successfully booked a training with Malik Scott on ',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              TextSpan(
                                                  text:
                                                      'June 1, 2023, 8:00AM - 9:00AM ',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(
                                                  text:
                                                      'at Brickhouse Boxing Club',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                              title: 'ADD TO CALENDER',
                              onTap: () {},
                              isTransparent: false,
                              textColor: Colors.white,
                              height: 45),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                              title: 'NAVIGATE TO GYM',
                              onTap: () {},
                              isTransparent: true,
                              textColor: Colors.white,
                              height: 45)
                        ],
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
