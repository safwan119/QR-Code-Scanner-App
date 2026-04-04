import '../../view/views.dart';

class TextFormFieldReusableWidget extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final FocusNode? focusNode;
  final void Function(String?)? onFieldSubmitted;

  const TextFormFieldReusableWidget({
    super.key,
    this.focusNode,
    this.onChanged,
    this.validator,
    this.onFieldSubmitted,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      focusNode: focusNode,
      onChanged: onChanged,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}