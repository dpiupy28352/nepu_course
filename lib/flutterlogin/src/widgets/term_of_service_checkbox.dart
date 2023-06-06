import 'package:flutter/material.dart';
import 'package:muse_nepu_course/flutterlogin/src/models/term_of_service.dart';

class TermCheckbox extends StatefulWidget {
  final TermOfService termOfService;
  final bool validation;

  const TermCheckbox({
    super.key,
    required this.termOfService,
    this.validation = true,
  });

  @override
  State<TermCheckbox> createState() => _TermCheckboxState();
}

class _TermCheckboxState extends State<TermCheckbox> {
  @override
  Widget build(BuildContext context) {
    return CheckboxFormField(
      onChanged: (value) => widget.termOfService.checked,
      initialValue: widget.termOfService.initialValue,
      title: widget.termOfService.linkUrl != null
          ? InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      widget.termOfService.text,
                      style: Theme.of(context).textTheme.bodyText2,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.open_in_new,
                      color: Theme.of(context).textTheme.bodyText2!.color,
                      size: Theme.of(context).textTheme.bodyText2!.fontSize,
                    ),
                  )
                ],
              ),
            )
          : Text(
              widget.termOfService.text,
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.left,
            ),
      validator: (bool? value) {
        if (widget.validation &&
            widget.termOfService.mandatory &&
            !widget.termOfService.checked) {
          return widget.termOfService.validationErrorMessage;
        }
        return null;
      },
    );
  }
}

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField({
    super.key,
    required Widget title,
    required FormFieldValidator<bool> super.validator,
    bool super.initialValue = false,
    required ValueChanged<bool?> onChanged,
  }) : super(
          builder: (FormFieldState<bool> state) {
            return CheckboxListTile(
              dense: true,
              title: title,
              value: state.value,
              onChanged: (value) {
                onChanged(value);
                state.didChange(value);
              },
              subtitle: state.hasError
                  ? Builder(
                      builder: (BuildContext context) => Text(
                        state.errorText!,
                        style: TextStyle(color: Theme.of(context).errorColor),
                      ),
                    )
                  : null,
              controlAffinity: ListTileControlAffinity.leading,
            );
          },
        );
}
