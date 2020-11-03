import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:way2fitlife/common/general/buttons.dart';
import 'package:way2fitlife/common/general/field_and_label.dart';
import 'package:way2fitlife/features/forum/presentation/bloc/bloc.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/strings.dart';

class AddForum extends StatefulWidget {
  Bloc bloc;

  AddForum({this.bloc});

  @override
  _AddForumState createState() => _AddForumState();
}

class _AddForumState extends State<AddForum> {
  bool btnStatus = false;
  String topicMsg = '';
  String titleMsg = '';
  String descMsg = '';

  TextEditingController topicController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  FocusNode topicNode = FocusNode();
  FocusNode titleNode = FocusNode();
  FocusNode descNode = FocusNode();

  String topic = '';
  String title = '';
  String desc = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    topicController.dispose();
    titleController.dispose();
    descController.dispose();
    topicNode.dispose();
    titleNode.dispose();
    descNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        //height: Scr.screenHeight * 0.5,
        //width: Scr.screenWidth * 0.9,
        child: BlocListener<ForumBloc, ForumState>(
          cubit: widget.bloc,
          listener: (context, state) {
            if (state is ForumErrorState) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text(state.msg)));
            }
            if (state is AddForumBtnState) {
              btnStatus = state.status;
              topicMsg = state.topicMsg;
              titleMsg = state.titleMsg;
            } else if (state is AddForumState) {
              if (state.model.flag == 1) {
                Fluttertoast.showToast(msg: state.model.msg);
                Navigator.of(context).pop();
              } else {
                Fluttertoast.showToast(msg: state.model.msg);
              }
            } else
              btnStatus = false;
          },
          child: BlocBuilder(
            cubit: widget.bloc,
            builder: (context, state) => addForum(),
          ),
        ),
      ),
    );
  }

  Widget addForum() {
    return Wrap(
      runSpacing: 10.0,
      children: [
        Stack(
          children: [
            Expanded(
              child: Center(
                  child: Text(
                addForumTxt,
                style: TextStyle(color: theme, fontSize: 15),
              )),
            ),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.close,
                  color: theme,
                  size: 15,
                ),
              ),
            ),
          ],
        ),
        FieldAndLabel(
          hint: "Add Topic",
          enabled: true,
          controller: topicController,
          focusNode: topicNode,
          nextFocusNode: titleNode,
          inputAction: TextInputAction.next,
          validationMessage: topicMsg,
          onChanged: (val) {
            topic = val;
            widget.bloc.add(AddForumBtnEvent(topic: topic, title: title));
          },
        ),
        FieldAndLabel(
          hint: "Add Title",
          enabled: true,
          controller: titleController,
          focusNode: titleNode,
          nextFocusNode: descNode,
          inputAction: TextInputAction.next,
          validationMessage: titleMsg,
          onChanged: (val) {
            title = val;
            widget.bloc.add(AddForumBtnEvent(topic: topic, title: title));
          },
        ),
        TextFormField(
          keyboardType: TextInputType.multiline,
          controller: descController,
          decoration: InputDecoration(
            hintText: 'Description',
            border: OutlineInputBorder(),
          ),
          minLines: 2,
          //Normal textInputField will be displayed
          maxLines: 3, // when user presses enter it will adapt to it
        ),
        Center(
          child: submitButton(
              text: add,
              textColor: white,
              disable: !btnStatus,
              onPressed: () {
                widget.bloc.add(AddForumEvent(
                  forum_title: titleController.text,
                  forum_topic: topicController.text,
                  description: descController.text,
                ));
              }),
        ),
      ],
    );
  }
}
