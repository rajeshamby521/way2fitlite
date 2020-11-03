import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:way2fitlife/common/general/buttons.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/di/dependency_injection.dart';
import 'package:way2fitlife/features/comment/presentation/bloc/add_comment/add_comment_bloc.dart';
import 'package:way2fitlife/features/comment/presentation/bloc/add_comment/add_commnet_event.dart';
import 'package:way2fitlife/features/comment/presentation/bloc/add_comment/add_commnet_state.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/strings.dart';

class CommentDialog extends StatefulWidget {
  @override
  _CommentDialogState createState() => _CommentDialogState();
}

class _CommentDialogState extends State<CommentDialog> {
  bool btnStatus = false;
  String comm_txt = '';
  String commMsg = '';
  Bloc bloc = getIt<AddCommentBloc>();

  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc.add(AddCommentBtnEvent(commnet: comm_txt));
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddCommentBloc, AddCommentState>(
      cubit: bloc,
      listener: (context, state) {
        if (state is AddCommnetErrorState) {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
        }
        if (state is AddCommentBtnState) {
          btnStatus = state.staus;
          commMsg = state.commnetMsg;
        } else if (state is AddCommentclickState) {
          if (state.model.flag == 1) {
            Navigator.of(context).pop();
            Fluttertoast.showToast(msg: state.model.msg);
          }
        } else {
          btnStatus = false;
        }
      },
      child: BlocBuilder(
        cubit: bloc,
        builder: (contetx, state) => addCommnet(),
      ),
    );
  }

  Widget addCommnet() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: labels(text: addCommentTxt, color: theme),
            ),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: icons(icon: Icons.close, color: theme),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            keyboardType: TextInputType.multiline,
            controller: commentController,
            onChanged: (val) {
              comm_txt = val;
              bloc.add(AddCommentBtnEvent(commnet: comm_txt));
            },
            decoration: InputDecoration(
              hintText: 'Comment',
              border: OutlineInputBorder(),
            ),
            minLines: 2,
            maxLines: 3,
          ),
        ),
        submitButton(
            text: add,
            textColor: white,
            disable: !btnStatus,
            onPressed: () {
              print(commentController.text);
              bloc.add(AddCommentClickEvent(commnet: commentController.text));
            }),
      ],
    );
  }
}
