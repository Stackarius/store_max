import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_max/my_widget/s_button.dart';
import 'package:store_max/navigation/main_navigation.dart';

import '../contants/colors.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.secondary, AppColors.primary],
          ),
          image: DecorationImage(
            image: AssetImage('assets/images/image_2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, AppColors.primary],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "THE FUTURE\nOF CLOTHING",
                    style: GoogleFonts.inter(
                      fontSize: 45,
                      fontWeight: FontWeight.w900,
                      color: AppColors.secondary,
                      decoration: TextDecoration.none,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 20),
                  // Auth Buttons
                  Row(
                    children: [
                      SButton(text: "Sign up"),
                      SizedBox(width: 20),
                      SButton(text: "Log in", color: AppColors.secondary),
                    ],
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap:
                        () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainNavigation(),
                          ),
                        ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      width: size.width / 1.3,
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        spacing: 10,
                        children: [
                          Text(
                            "Ptoceed to store",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          SizedBox(width: 20),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Icon(Icons.arrow_forward),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
