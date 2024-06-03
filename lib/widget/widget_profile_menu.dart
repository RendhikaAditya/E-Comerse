import 'package:flutter/material.dart';

class WidgetProfileMenu extends StatelessWidget {
  final String title;
  final Function navigatorPush;
  final IconData icon;

  const WidgetProfileMenu({
    required this.title,
    required this.navigatorPush,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigatorPush();
      },
      child: Container(
        padding: EdgeInsets.only(top: 12.0, left: 16, right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black,
              size: 20,// Sesuaikan warna icon dengan kebutuhan
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Icon(Icons.keyboard_arrow_right_rounded), // Icon panah ke kanan
          ],
        ),
      ),
    );
  }
}
