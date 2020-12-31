import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:way2fitlife/common/general/buttons.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/di/dependency_injection.dart';
import 'package:way2fitlife/features/advertiesment/presentation/page/ad_manager.dart';
import 'package:way2fitlife/features/comment/presentation/bloc/add_comment/add_comment_bloc.dart';
import 'package:way2fitlife/features/comment/presentation/bloc/add_comment/add_commnet_event.dart';
import 'package:way2fitlife/features/comment/presentation/bloc/add_comment/add_commnet_state.dart';
import 'package:way2fitlife/features/comment/presentation/bloc/comment_bloc/comment_event.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/strings.dart';

class CommentDialog extends StatefulWidget {
  Bloc bloc;
  String forum_id;

  CommentDialog({this.bloc, this.forum_id});

  @override
  _CommentDialogState createState() => _CommentDialogState();
}

class _CommentDialogState extends State<CommentDialog> {
  bool btnStatus = false;
  String comm_txt = '';
  String commMsg = '';
  Bloc bloc = getIt<AddCommentBloc>();

  TextEditingController commentController = TextEditingController();
  final _controller = NativeAdmobController();
  bool adLoaded = true;

  @override
  void initState() {
    super.initState();
    _controller.stateChanged.listen((event) {
      /*   if(event == AdLoadState.loading){
        adLoaded = false;
      }else*/ if(event == AdLoadState.loadCompleted){
        adLoaded = true;
        setState(() {

        });
      }else if(event == AdLoadState.loadError){
        adLoaded = false;
        setState(() {

        });
      }
    });
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
            widget.bloc.add(ForumDetailEvent(forum_id: widget.forum_id));
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
    return SingleChildScrollView(
      child: Column(
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
          Container(
            height: adLoaded ? 350: 0,
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.only(bottom: 20.0),
            decoration: BoxDecoration(
              border: Border.all(color: adLoaded ?red :white, width: adLoaded ? 1: 0),
            ),
            child: NativeAdmob(
              adUnitID: AdManager.nativeAdUnitId,
              /*      error: FacebookNativeAd(
                placementId:
                    "IMG_16_9_APP_INSTALL#2312433698835503_2964952163583650",

                adType: NativeAdType.NATIVE_AD,
                width: double.infinity,
                backgroundColor: Colors.blue,
                titleColor: Colors.white,
                descriptionColor: Colors.white,
                buttonColor: Colors.deepPurple,
                buttonTitleColor: Colors.white,
                buttonBorderColor: Colors.white,
                keepAlive: true,
                //set true if you do not want adview to refresh on widget rebuild
                keepExpandedWhileLoading: false,
                // set false if you want to collapse the native ad view when the ad is loading
                expandAnimationDuraion: 300,
                listener: (result, value) {
                  print("facebooko native add $result-->$value");
                },
              ),*/
              controller: _controller,
              type: NativeAdmobType.full,
              options: NativeAdmobOptions(),
            ),
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
      ),
    );
  }
}
