import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way2fitlife/common/general/appbar_widget.dart';
import 'package:way2fitlife/common/general/circular_progress_indicator.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/di/dependency_injection.dart';
import 'package:way2fitlife/features/forum/data/datamodel/add_forum_data_model.dart';
import 'package:way2fitlife/features/forum/data/datamodel/forum_data_model.dart';
import 'package:way2fitlife/features/forum/presentation/bloc/bloc.dart';
import 'package:way2fitlife/features/forum/presentation/bloc/forum_bloc.dart';
import 'package:way2fitlife/features/forum/presentation/widget/add_forum.dart';
import 'package:way2fitlife/features/forum/presentation/widget/listItem.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/images.dart';
import 'package:way2fitlife/ui_helper/strings.dart';

class ForumScreen extends StatefulWidget {
  Bloc bloc;

  ForumScreen({this.bloc});

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  final bloc = getIt<ForumBloc>();
  ForumDataModel list = ForumDataModel();
  AddForumDataModel model;
  bool isLoading = true;
  bool isPageLoading = false;
  int offSet = 0;
  List<Datum> forumList = List<Datum>();

  @override
  void initState() {
    super.initState();
    bloc.add(ForumFetchEvent(offset: offSet));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: bloc,
      listener: (context, state) {
        if (state is ForumErrorState) {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
        }
        if (state is ForumFecthDataState || state is ForumNextPageDataState) {
          list = state.model;
          forumList.addAll(state.model.data);
        }
        if (state is LoadingBeginHomeState) isLoading = true;
        if (state is LoadingEndHomeState) isLoading = false;
        if (state is LoadingBeginNextPageState) isPageLoading = true;
        if (state is LoadingEndNextPageState) isPageLoading = false;
        if (state is AddForumState) {
          model = state.model;
          String topic = model.data.forumTopic;
          String title = model.data.forumTitle;
          String id = model.data.forumId;
          String desc = model.data.description;
          forumList.insert(
              0,
              Datum(
                forumTopic: topic,
                forumId: id,
                forumTitle: title,
              ));
        }
      },
      child: BlocBuilder(
        cubit: bloc,
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: appbar(bloc: widget.bloc, context: context, title: Forum),
            floatingActionButton: extendedFloatingButton(
              context: context,
              bloc: bloc,
              icon: Icons.add,
              label: add,
              backgroundColor: headerColor,
              iconLabelColor: white,
              dialogContent: AddForum(bloc: bloc),
            ),
            body: SafeArea(
              child: Container(
                decoration: boxDecoration(
                  image: bg_home_screen,
                  colorFilter: ColorFilter.mode(
                      black.withOpacity(0.8), BlendMode.dstATop),
                ),
                child:
                    isLoading ? circularProgressIndicator : _createListView(),
              ),
            ),
            bottomSheet: isPageLoading
                ? Container(height: 40, child: circularProgressIndicator)
                : null,
          );
        },
      ),
    );
  }

  Widget _createListView() {
    ScrollController _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        offSet = list.nextOffset;
        if (offSet != -1) {
          bloc.add(ForumNextPageEvent(offset: offSet));
        }
      }
    });

    return ListView.builder(
      controller: _scrollController,
      itemCount: forumList.length,
      itemBuilder: (BuildContext context, int index) {
        return listItem(
          id: forumList[index].forumId,
          title: forumList[index].forumTopic,
          subtitle: forumList[index].forumTitle,
        );
      },
    );
  }
}
