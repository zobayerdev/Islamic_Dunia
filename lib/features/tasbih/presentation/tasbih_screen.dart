import 'package:flutter/material.dart';

class ButtonAnimationPage extends StatefulWidget {
  @override
  _ButtonAnimationPageState createState() => _ButtonAnimationPageState();
}

class _ButtonAnimationPageState extends State<ButtonAnimationPage>
    with TickerProviderStateMixin {
  // Animation Controller for scaling
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 100), // Duration of the scale animation
      vsync: this,
    );

    // Scale animation ranging from 1.0 to 1.1 for slight growth on tap
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTap() {
    // Start animation when the button is tapped
    _animationController
        .forward()
        .then((value) => _animationController.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Button Tapping Animation'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _onTap, // Trigger the tap animation
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value, // Apply scaling animation
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Tap Me'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    textStyle: TextStyle(fontSize: 20),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
