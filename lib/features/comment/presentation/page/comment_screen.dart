import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way2fitlife/common/general/circular_progress_indicator.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/di/dependency_injection.dart';
import 'package:way2fitlife/features/comment/data/datamodel/forum_details_data_model.dart';
import 'package:way2fitlife/features/comment/presentation/bloc/comment_bloc/comment_bloc.dart';
import 'package:way2fitlife/features/comment/presentation/bloc/comment_bloc/comment_event.dart';
import 'package:way2fitlife/features/comment/presentation/bloc/comment_bloc/comment_state.dart';
import 'package:way2fitlife/features/comment/presentation/widget/comment_dialog.dart';
import 'package:way2fitlife/features/comment/presentation/widget/comment_header.dart';
import 'package:way2fitlife/features/comment/presentation/widget/listitem.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/images.dart';
import 'package:way2fitlife/ui_helper/strings.dart';
import 'package:way2fitlife/utils/screen_utils.dart';

import '../../../../main.dart';

class CommentScreen extends StatefulWidget {
  String forum_id;

  CommentScreen({this.forum_id});

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  Bloc bloc = getIt<CommentBloc>();
  String topic = '';
  String title = '';
  String desc = '';
  String date = '';
  bool isLoading = true;
  List<ForumComment> commentList;

  @override
  void initState() {
    super.initState();
    bloc.add(ForumDetailEvent(forum_id: widget.forum_id));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: bloc,
      listener: (context, state) {
        if (state is CommentErrorState) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.msg),
          ));
        }
        if (state is CommentLoadingBeginState) isLoading = true;
        if (state is CommentLoadingEndState) isLoading = false;
        if (state is ForumDetaislState) {
          isLoading = false;
          topic = state.model.data.forumTopic;
          title = state.model.data.forumTitle;
          desc = state.model.data.description ?? " ";
          date = state.model.data.date;
          commentList = state.model.data.forumComments;
        } else {}
      },
      child: BlocBuilder(
        cubit: bloc,
        builder: (context, state) {
          return Scaffold(
      /*      persistentFooterButtons: [
              if (isBannerReady)
                Container(
                  height: 30,
                  color: transparent,
                ),
            ],*/
            appBar: AppBar(
              title: Text(Forum),
              backgroundColor: headerColor,
            ),
            floatingActionButton: Padding(
              padding: EdgeInsets.only(bottom: isBannerReady ? 60.0: 0.0),
              child: extendedFloatingButton(
                context: context,
                bloc: bloc,
                icon: Icons.add,
                label: add,
                backgroundColor: headerColor,
                iconLabelColor: white,
                dialogContent: CommentDialog(
                  bloc: bloc,
                  forum_id: widget.forum_id,
                ),
              ),
            ),
            body: SafeArea(
              child: Container(
                height: Scr.screenHeight,
                width: Scr.screenWidth,
                decoration: boxDecoration(
                  color: black,
                  image: bg_home_screen2,
                  colorFilter: ColorFilter.mode(
                      black.withOpacity(0.8), BlendMode.dstATop),
                ),
                child: isLoading
                    ? screenProgressIndicator
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          verticalSpace(10),
                          Container(
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            child: CommentHeader(
                              topic: topic,
                              title: title,
                              desc: desc,
                              date: date,
                            ),
                          ),
                          commentList == null
                              ? Container()
                              : Expanded(
                                  child:
                                      /*sLoading
                                      ? circularProgressIndicator
                                      : */
                                      _createListView()),
                          if (isBannerReady)
                            Container(
                              height: 54,
                              color: transparent,
                            ),

                        ],
                      ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _createListView() {
    return Container(
      // height: Scr.screenHeight * 0.7,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return ListItem(
            title: commentList[index].username,
            profileImg: commentList[index].profileImage,
            commentText: commentList[index].commentText,
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: commentList.length,
      ),
    );
  }
}
