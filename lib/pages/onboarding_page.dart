import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
          image: const DecorationImage(
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
                  // HEADLINE
                  Text(
                        "THE FUTURE\nOF CLOTHING",
                        style: GoogleFonts.inter(
                          fontSize: 45,
                          fontWeight: FontWeight.w900,
                          color: AppColors.secondary,
                          decoration: TextDecoration.none,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 600.ms)
                      .slideY(begin: 0.8, end: 0, curve: Curves.easeOutCubic),

                  const SizedBox(height: 20),

                  // AUTH BUTTONS
                  Row(
                        children: [
                          SButton(text: "Sign up"),
                          const SizedBox(width: 20),
                          SButton(text: "Log in", color: AppColors.secondary),
                        ],
                      )
                      .animate()
                      .fadeIn(duration: 700.ms, delay: 300.ms)
                      .slideY(begin: 0.5, end: 0, curve: Curves.easeOutCubic),

                  const SizedBox(height: 50),

                  // PROCEED BUTTON
                  GestureDetector(
                        onTap:
                            () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainNavigation(),
                              ),
                            ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
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
                                "Proceed to store",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              const SizedBox(width: 20),
                              const Padding(
                                padding: EdgeInsets.only(right: 20.0),
                                child: Icon(Icons.arrow_forward),
                              ),
                            ],
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 800.ms, delay: 600.ms)
                      .slideY(begin: 0.5, end: 0, curve: Curves.easeOutCubic)
                      .scale(
                        begin: const Offset(0.95, 0.95),
                        end: const Offset(1, 1),
                      )
                      .then(delay: 500.ms)
                      .scale(
                        duration: 700.ms,
                        begin: const Offset(1, 1),
                        end: const Offset(1.05, 1.05),
                        curve: Curves.easeInOut,
                      )
                      .scale(
                        duration: 700.ms,
                        begin: const Offset(1.05, 1.05),
                        end: const Offset(1, 1),
                        curve: Curves.easeInOut,
                      ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
