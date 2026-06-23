import 'package:awn/core/resources/colors_manager.dart';
import 'package:awn/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpInputField extends StatefulWidget {
  final Function(String) onCompleted;
  final ValueChanged<String>? onChanged;
  final int length;
  const OtpInputField({
    super.key,
    required this.onCompleted,
    this.onChanged,
    this.length = 4,
  });

  @override
  State<OtpInputField> createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _notify() {
    final value = _controllers.map((c) => c.text).join();
    widget.onChanged?.call(value);
    if (value.length == widget.length) {
      widget.onCompleted(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (i) => Flexible(child: _buildBox(i))),
    );
  }

  Widget _buildBox(int i) {
    final colorScheme = Theme.of(context).colorScheme;
    // Boxes shrink a little when there are more of them (6 digits) so the
    // row always fits, even on narrow phones.
    final box = context.r(widget.length > 4 ? 46 : 56).clamp(40.0, 64.0);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.r(6)),
      child: ListenableBuilder(
        listenable: _focusNodes[i],
        builder: (_, __) {
          final focused = _focusNodes[i].hasFocus;
          return Container(
            width: box,
            height: box,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(box * 0.32),
              border: focused
                  ? Border.all(color: ColorsManager.green, width: 1.5)
                  : Border.all(
                      color: colorScheme.outline.withOpacity(0.3),
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
                fontSize: context.sp(20),
                fontWeight: FontWeight.w300,
              ),
              controller: _controllers[i],
              focusNode: _focusNodes[i],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 1,
              decoration: const InputDecoration(
                counterText: '',
                border: InputBorder.none,
              ),
              onChanged: (val) {
                if (val.isNotEmpty && i < widget.length - 1) {
                  _focusNodes[i + 1].requestFocus();
                } else if (val.isEmpty && i > 0) {
                  _focusNodes[i - 1].requestFocus();
                }
                _notify();
              },
            ),
          );
        },
      ),
    );
  }
}
