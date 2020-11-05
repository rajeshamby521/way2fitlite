import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/text_style.dart';

enum FieldType {
  TextField,
  DropDownList,
}

class FieldAndLabel<ListItemType> extends StatefulWidget {
  final Color labelTextColor;
  final FieldType fieldType;
  final TextStyle labelTextStyle;
  final Color labelBackgroundColor;
  final String labelValue;
  final String intialValue;
  final Widget icon;
  final Widget rightIcon;
  final TextInputAction inputAction;
  final dynamic fieldValue;
  final List<ListItemType> listItems;
  bool isPassword;
  final bool autoFocus;
  final bool enabled;
  final String hint;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final Function onSubmitted;
  final Function onEditingComplete;
  final Function onTap;
  final Function onChanged;
  final TextInputType inputType;
  final String validationMessage;
  final TextEditingController controller;
  final bool update;
  final bool isMultiline;

  FieldAndLabel({
    this.labelBackgroundColor,
    this.labelTextColor,
    this.labelTextStyle,
    this.inputAction,
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
    this.intialValue = ' ',
    this.nextFocusNode,
    this.update = false,
    this.fieldValue,
    this.listItems,
    this.fieldType = FieldType.TextField,
    this.isMultiline = false,
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
        SizedBox(
          height: 10,
        ),
        widget.fieldType == FieldType.DropDownList
            ? buildList(context)
            : buildTextField(context),
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
              defaultLabelStyle(
                  widget.labelTextColor, widget.labelBackgroundColor),
          textAlign: TextAlign.start,
        ),
      ]);
    } else {
      return Container();
    }
  }

  Widget buildList(context) {
    return Container(
        height: 45,
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: buildDropDownList(context),
        ));
  }

  Widget buildTextField(BuildContext context) {
    return Container(
      height: 50,
      child: TextFormField(
        keyboardType: widget.inputType,
        obscureText: widget.isPassword ? visible : widget.isPassword,
        style: TextStyle(color: theme),
        focusNode: widget.focusNode,
        autofocus: widget.autoFocus,
        enabled: widget.enabled ?? true,
        controller: widget.controller,
        textCapitalization: TextCapitalization.sentences,
        onChanged: widget.onChanged,
        textInputAction: widget.inputAction,
        onFieldSubmitted: (val) {
          _focusShift(context, widget.focusNode, widget.nextFocusNode);
          // onSubmitted(val);
        },
        maxLines: widget.isMultiline ? 3 : 1,
        decoration: InputDecoration(
          prefixIcon: widget.icon,
          suffixIcon: passVisibilityIcon(),
          counterText: "",
          hintText: widget.enabled == false ? widget.intialValue : widget.hint,
          hintStyle:
              widget.enabled == false ? TextStyle(color: Colors.black) : null,
          filled: true,
          border: OutlineInputBorder(),
          disabledBorder: OutlineInputBorder(),
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
    return buildValidationErrorMessage(context,
        validationMessage: widget.validationMessage);
  }

  bool isBlank(String value) {
    return value == null || value == '';
  }

  _focusShift(context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    if (nextFocus != null)
      FocusScope.of(context).requestFocus(nextFocus);
    else
      SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  onChangedInternal(value) async {
    currentFieldValue = value;
    if (widget.onChanged != null) {
      widget.onChanged(value);
    }
  }

  Widget buildDropDownList(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(height: 36),
      height: 36.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          (widget.icon == null)
              ? Container()
              : Row(
                  children: <Widget>[
                    SizedBox(height: 24, width: 24, child: widget.icon),
                    Padding(
                      padding: EdgeInsets.only(left: 6),
                    ),
                  ],
                ),
          Expanded(
            child: IgnorePointer(
              ignoring: !(widget?.enabled ?? true),
              child: DropdownButton(
                underline: Container(),
                isExpanded: true,
                value: currentFieldValue ?? widget.fieldValue,
                items: widget.listItems ?? [],
                onChanged: onChangedInternal,
                iconSize: 12.0,
                disabledHint: Text(
                  widget.validationMessage ?? '',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildValidationErrorMessage(BuildContext context,
      {String validationMessage}) {
    if (!isBlank(validationMessage))
      return Row(
        children: [
          Text(
            validationMessage,
            style: TextStyle(
                fontSize: 13,
                color:
                    widget.validationMessage == "Valid" ? Colors.green : red),
          ),
        ],
      );
    else {
      return Container();
    }
  }
}
