import 'package:ecomerse/page/auth/loginPage.dart';
import 'package:ecomerse/widget/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _pageController = PageController();
  final List<Map<String, String>> welcomeData = [
    {
      "image": "image/welcome1.png",
      "title": "Welcome to E-Commerce",
      "description": "Find everything you need in one place.",
    },
    {
      "image": "image/welcome2.png",
      "title": "Great Deals",
      "description": "Discover amazing discounts and offers.",
    },
    {
      "image": "image/welcome3.png",
      "title": "Fast Shipping",
      "description": "Get your orders delivered quickly.",
    },
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            currentPage = page;
          });
        },
        itemCount: welcomeData.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 160.0, right: 16, left: 16, bottom: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(welcomeData[index]['image']!),
                SizedBox(height: 20),
                Text(
                  welcomeData[index]['title']!,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  welcomeData[index]['description']!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Spacer(),
                CustomButton(text: "Next", onPressed: (){},),
                TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                            (route) => false
                    );
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}