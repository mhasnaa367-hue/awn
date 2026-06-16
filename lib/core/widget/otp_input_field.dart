import 'package:awn/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';

class OtpInputField extends StatefulWidget {
  final Function(String) onCompleted;
  const OtpInputField({super.key, required this.onCompleted});

  @override
  State<OtpInputField> createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {
  final List<TextEditingController> _controllers =
  List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (i) => _buildBox(i)),
    );
  }

  Widget _buildBox(int i) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListenableBuilder(
        listenable: _focusNodes[i],
        builder: (_, __) {
          final focused = _focusNodes[i].hasFocus;
          return Container(
            width: 56, height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),

              border: focused
                  ? Border.all(
                color: ColorsManager.green,
                width: 1.5,
              )
                  : Border.all(
                color: ColorsManager.exlightgray,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              style: TextStyle(
                color: ColorsManager.green,
                fontSize: 20,
                fontWeight: FontWeight.w300
              ),
              controller: _controllers[i],
              focusNode: _focusNodes[i],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              decoration: const InputDecoration(
                counterText: '', border: InputBorder.none,
              ),
              onChanged: (val) {
                if (val.isNotEmpty && i < 3) {
                  _focusNodes[i + 1].requestFocus();
                } else if (val.isNotEmpty) {
                  widget.onCompleted(
                    _controllers.map((c) => c.text).join(),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}