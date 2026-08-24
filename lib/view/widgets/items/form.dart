import 'package:flutter/material.dart';

class AnimatedCommentField extends StatefulWidget {
  final TextEditingController controller;

  const AnimatedCommentField({super.key, required this.controller});

  @override
  AnimatedCommentFieldState createState() => AnimatedCommentFieldState();
}

class AnimatedCommentFieldState extends State<AnimatedCommentField>
    with SingleTickerProviderStateMixin {
  late FocusNode _focusNode;
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() => _hasFocus = _focusNode.hasFocus);
    });

    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _shakeAnimation = Tween<double>(begin: 0, end: 10)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_shakeController);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  void triggerShake() {
    _shakeController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
              _shakeAnimation.value * (_shakeController.isCompleted ? 0 : 1),
              0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              boxShadow: _hasFocus
                  ? [
                      BoxShadow(
                          color: const Color(0xffa43068).withValues(alpha: 0.3),
                          blurRadius: 12,
                          spreadRadius: 2)
                    ]
                  : [],
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextFormField(
              controller: widget.controller,
              focusNode: _focusNode,
              maxLines: 4,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
              ),
              cursorColor: const Color(0xffa43068),
              decoration: InputDecoration(
                hintText: 'What did you like or dislike?',
                hintStyle: TextStyle(
                  color: _hasFocus ? Colors.pink[300] : Colors.grey[600],
                  fontSize: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: Color(0xffa43068), width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: const Color(0xffa43068).withValues(alpha: 0.7),
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xffa43068),
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: Colors.grey[50],
                contentPadding: const EdgeInsets.all(16),
              ),
              onChanged: (text) {},
            ),
          ),
        );
      },
    );
  }
}
