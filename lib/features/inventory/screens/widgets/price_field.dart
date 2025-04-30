import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PriceFormField extends StatefulWidget {
  const PriceFormField({
    super.key,
    required this.controller,
    required this.label,
    this.isRequired = true,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 34,
      horizontal: 10,
    ),
    this.onFieldSubmitted,
    this.isHidden = false, // ✅ New parameter
  });

  final TextEditingController controller;
  final String label;
  final bool isRequired;
  final EdgeInsetsGeometry contentPadding;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final bool isHidden;

  @override
  State<PriceFormField> createState() => _PriceFormFieldState();
}

class _PriceFormFieldState extends State<PriceFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isHidden;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        focusNode: widget.focusNode,
        controller: widget.controller,
        onFieldSubmitted: widget.onFieldSubmitted,
        obscureText: widget.isHidden ? _obscureText : false,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryFixed,
            ),
        decoration: InputDecoration(
          contentPadding: widget.contentPadding,
          labelText: widget.label,
          labelStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: widget.isHidden
              ? IconButton(
                  icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,20}')),
        ],
        validator: (value) {
          if (!widget.isRequired && (value == null || value.isEmpty)) {
            return null;
          }
          if (value == null || value.isEmpty) {
            return 'Please enter ${widget.label}'.toLowerCase();
          }
          if (double.tryParse(value) == null) {
            return 'Please enter a valid number';
          }
          return null;
        },
      ),
    );
  }
}
