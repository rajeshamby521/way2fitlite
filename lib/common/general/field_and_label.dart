import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/text_style.dart';
import 'package:flutter/material.dart';

class FieldAndLabel extends StatefulWidget {
  final Color labelTextColor;
  final TextStyle labelTextStyle;
  final Color labelBackgroundColor;
  final String labelValue;
  final Widget icon;
  final Widget rightIcon;
  bool isPassword;
  final bool autoFocus;
  final bool enabled;
  final String hint;
  final FocusNode focusNode;
  final Function onSubmitted;
  final Function onEditingComplete;
  final Function onTap;
  final Function onChanged;
  final TextInputType inputType;
  final String validationMessage;
  final TextEditingController controller;

  FieldAndLabel({
    this.labelBackgroundColor,
    this.labelTextColor,
    this.labelTextStyle,
    this.labelValue,
    this.onTap,
    this.icon,
    this.onChanged,
    this.autoFocus = false,
    this.enabled = false,
    this.focusNode,
    this.inputType,
    this.isPassword = false,
    this.onEditingComplete,
    this.onSubmitted,
    this.hint,
    this.rightIcon,
    this.validationMessage,
    this.controller,
  });

  @override
  _FieldAndLabelState createState() => _FieldAndLabelState();
}

class _FieldAndLabelState extends State<FieldAndLabel> {
  var currentFieldValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildLabel(context),
        buildTextField(context),
        buildValidationMessage(context),
      ],
    );
  }

  Widget buildLabel(BuildContext context) {
    if (widget.labelValue != null && widget.labelValue.isNotEmpty) {
      return Row(children: <Widget>[
        Text(
          widget.labelValue,
          style: this.widget.labelTextStyle ??
              defaultLabelStyle(widget.labelTextColor, widget.labelBackgroundColor),
          textAlign: TextAlign.start,
        ),
      ]);
    } else {
      return Container();
    }
  }

  Widget buildTextField(BuildContext context) {
    return Container(
      height: 50,
      child: TextField(
        keyboardType: widget.inputType,
        obscureText: widget.isPassword ? visible : widget.isPassword,
        style: TextStyle(color: theme),
        focusNode: widget.focusNode,
        autofocus: widget.autoFocus,
        enabled: widget.enabled ?? true,
        controller: widget.controller,
        onChanged: widget.onChanged,
        onSubmitted: (val) {
          FocusScope.of(context).requestFocus(new FocusNode());
          // onSubmitted(val);
        },
        maxLines: 1,
        decoration: InputDecoration(
          prefixIcon: widget.icon,
          suffixIcon: passVisibilityIcon(),
          counterText: "",
          hintText: widget.hint,
          filled: true,
          border: OutlineInputBorder(),
          fillColor: Colors.white,
        ),
      ),
    );
  }

  bool visible = true;

  Widget passVisibilityIcon() {
    return widget.isPassword
        ? IconButton(
            icon: Icon(
              visible ? Icons.visibility : Icons.visibility_off,
              color: theme,
            ),
            onPressed: () {
              setState(() {
                visible = !visible;
              });
            })
        : widget.rightIcon;
  }

  Widget buildValidationMessage(BuildContext context) {
    return buildValidationErrorMessage(context, validationMessage: widget.validationMessage);
  }

  bool isBlank(String value) {
    return value == null || value == '';
  }

  Widget buildValidationErrorMessage(BuildContext context, {String validationMessage}) {
    if (!isBlank(validationMessage))
      return Row(
        children: [
          Text(
            validationMessage,
            style: TextStyle(
                fontSize: 13, color: widget.validationMessage == "Valid" ? Colors.green : red),
          ),
        ],
      );
    else {
      return Container();
    }
  }
}
