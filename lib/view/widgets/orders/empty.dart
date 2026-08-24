import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:oro/core/constant/color.dart';

class Empty extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function()? onPressedRefresh;
  final Function()? onPressedOrder;
  const Empty(
      {super.key,
      required this.title,
      required this.subtitle,
      this.onPressedRefresh,
      this.onPressedOrder});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 150),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'lottie/empty.json', // Add this Lottie file
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 200,
                  fit: BoxFit.contain,
                  repeat: true,
                  animate: true,
                  frameRate: const FrameRate(60),
                ),
                const SizedBox(height: 24),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 700),
                  opacity: 1,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 900),
                  opacity: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                AnimatedScale(
                  duration: const Duration(milliseconds: 600),
                  scale: 1,
                  curve: Curves.fastOutSlowIn,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: onPressedRefresh,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          foregroundColor: Colors.grey[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          elevation: 0,
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.refresh, size: 20),
                            SizedBox(width: 8),
                            Text('Refresh'),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: onPressedOrder,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Appcolor.amaranthpink,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add, size: 20, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Place Order',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
