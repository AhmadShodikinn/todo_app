import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../tasks/presentation/pages/task_list_page.dart';
import '../../tasks/presentation/bloc/task_bloc.dart';

// halaman paling awal aplikasi,
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;

    // ada dua tampilan, satu untuk tablet (landscape), satu untuk hp (portrait)
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: isTablet
            ? Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: -screenHeight * 0.2,
                          left: -screenWidth * 0.15,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/Decorative.png',
                              width: screenWidth * 0.45,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Plan your task easily',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'All your tasks in one app, easy to organize and access anytime.',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white.withAlpha(230),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider.value(
                                      value: context.read<TaskBloc>(),
                                      child: const TaskListPage(),
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 32,
                                ),
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Get Started',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Stack(
                children: [
                  Positioned(
                    top: -screenWidth * 0.1,
                    left: -screenWidth * 0.4,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/Decorative.png',
                        width: screenWidth * 1.1,
                        height: screenWidth * 1.1,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.1,
                        ),
                        child: const Text(
                          'Plan your task easily',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.12,
                        ),
                        child: const Text(
                          'All your tasks in one app, easy to organize and access anytime',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.06),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                value: context.read<TaskBloc>(),
                                child: const TaskListPage(),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: EdgeInsets.all(screenWidth * 0.06),
                          backgroundColor: Colors.black,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: screenWidth * 0.07,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.08),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
