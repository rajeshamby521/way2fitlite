import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:way2fitlife/common/general/circular_progress_indicator.dart';
import 'package:way2fitlife/common/general/field_and_label.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/di/dependency_injection.dart';
import 'package:way2fitlife/features/login/data/datamodel/login_model.dart';
import 'package:way2fitlife/features/register_page/presentation/widget/button_builder.dart';
import 'package:way2fitlife/features/update_user_data/presentation/bloc/update_user_bloc/bloc.dart';
import 'package:way2fitlife/features/update_user_data/presentation/bloc/update_user_bloc/update_user_bloc.dart';
import 'package:way2fitlife/features/update_user_data/presentation/bloc/update_user_bloc/update_user_event.dart';
import 'package:way2fitlife/features/update_user_data/presentation/widget/change_password.dart';
import 'package:way2fitlife/main.dart';
import 'package:way2fitlife/network/api_strings.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/icons.dart';
import 'package:way2fitlife/ui_helper/images.dart';
import 'package:way2fitlife/ui_helper/strings.dart';
import 'package:way2fitlife/utils/app_preference.dart';
import 'package:way2fitlife/utils/screen_utils.dart';

class UpdateUserData extends StatefulWidget {
  @override
  _UpdateUserDataState createState() => _UpdateUserDataState();
}

enum Gender { male, female }

class _UpdateUserDataState extends State<UpdateUserData> {
  DateTime selectedDate = DateTime.now();

  File image;
  ImagePicker picker = ImagePicker();
  Gender _gender;
  final bloc = getIt<UpdateUserBloc>();
  final usernameController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();

  final usernameFocus = FocusNode();
  final heightFocus = FocusNode();
  final weightFocus = FocusNode();
  final emailFocus = FocusNode();
  final mobileFocus = FocusNode();

  String unameMsg = '';
  String heightMsg = '';
  String weightMsg = '';
  String emailMsg = '';
  String mobileMsg = '';
  String activityMsg = '';
  String passwordMsg = '';

  String uname;
  String height;
  String weight;
  String email;
  String mobile;
  String password;
  String activity;
  String _value = 'Normal';
  bool _saving = false;
  int flag = 0;
  UserData Data;
  LogInModel updatemodel;

  @override
  void initState() {
    Data =
        UserData.fromJson(json.decode(AppPreference.prefs.getString(userData)));
    usernameController.text = Data.username;
    heightController.text = Data.height;
    weightController.text = Data.weight;
    emailController.text = Data.email;
    mobileController.text = Data.mobile;
    selectedDate = Data.birthdate;
    uname = Data.username;
    height = Data.height;
    weight = Data.weight;
    email = Data.email;
    mobile = Data.mobile;
    if (Data.activityType == "1")
      _value = activity = 'Normal';
    else if (Data.activityType == "2")
      _value = activity = 'Light';
    else if (Data.activityType == "3")
      _value = activity = 'Medium';
    else
      _value = activity = 'Active';
    if ((Data.gender.compareTo('Male')) == 0)
      _gender = Gender.male;
    else
      _gender = Gender.female;

    bloc.add(UpdateUserInitialEvent(
      uname: uname,
      height: height,
      weight: weight,
      email: email,
      mobile: mobile,
      activityBuilder: activity,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: labels(text: updateData),
          backgroundColor: headerColor,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: assetsImage(bg_login), fit: BoxFit.cover)),
              ),
              SingleChildScrollView(
                child: Stack(
                  children: [
                    //backgroung container
                    Wrap(runSpacing: 3.0, children: [
                      //form
                      Container(
                        child: BlocListener<UpdateUserBloc, UpdateUserState>(
                          cubit: bloc,
                          listener: (context, state) {
                            if (state is UpdateUserLodingBeginState)
                              _saving = true;
                            if (state is UpdateUserLodingEndState)
                              _saving = false;
                            if (state is UpdateUserIntialState) {
                              unameMsg = state.unameMsg;
                              heightMsg = state.heightMsg;
                              weightMsg = state.weightMsg;
                              emailMsg = state.emailMsg;
                              mobileMsg = state.mobileMsg;
                              activityMsg = state.activityMsg;
                              return Stack(
                                children: formBuild(state.status),
                              );
                            }
                            if (state is UpdateUserComplteState) {
                              updatemodel = state.model;
                              if (state.model.flag == 1) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MyApp()));
                                return null;
                              } else if (state.model.flag == 0) {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text(state.model.msg)));
                                return null;
                              }
                            } else
                              return Stack(
                                children: formBuild(false),
                              );
                          },
                          child: BlocBuilder<UpdateUserBloc, UpdateUserState>(
                            cubit: bloc,
                            builder: (context, state) {
                              if (state is UpdateUserIntialState) {
                                unameMsg = state.unameMsg;
                                heightMsg = state.heightMsg;
                                weightMsg = state.weightMsg;
                                emailMsg = state.emailMsg;
                                mobileMsg = state.mobileMsg;
                                activityMsg = state.activityMsg;
                                return Stack(
                                  children: formBuild(state.status),
                                );
                              } else
                                return Stack(
                                  children: formBuild(false),
                                );
                            },
                          ),
                        ),
                      ),

                      //Already Login
                    ]),

                    //Profile img
                    Center(
                      child: Container(
                        height: Scr.screenHeight * 0.2,
                        width: Scr.screenWidth * 0.3,
                        child: GestureDetector(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: Stack(
                            children: [
                              Center(
                                child: CircleAvatar(
                                  radius: 57,
                                  backgroundColor: headerColor,
                                  child: CircleAvatar(
                                    radius: 53,
                                    backgroundImage: image != null
                                        ? FileImage(image)
                                        : networkImage(Data.profileImage),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: headerColor,
                                    child: Icon(Icons.edit),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  List<Widget> formBuild(bool status) {
    var form = Wrap(
      children: [
        //form
        Container(
          margin: EdgeInsets.only(
            top: 50,
            left: 10,
            right: 10,
          ),
          padding:
              const EdgeInsets.only(left: 10, top: 100, right: 10, bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
          child: Wrap(
            runSpacing: 15.0,
            children: [
              FieldAndLabel(
                fieldType: FieldType.TextField,
                icon: Image.asset(
                  ic_person,
                  height: 28,
                  width: 28,
                ),
                enabled: true,
                hint: 'User name',
                controller: usernameController,
                inputType: TextInputType.text,
                validationMessage: unameMsg,
                inputAction: TextInputAction.next,
                focusNode: usernameFocus,
                nextFocusNode: heightFocus,
                onChanged: (val) {
                  uname = val;
                  activity = _value;
                  bloc.add(UpdateUserInitialEvent(
                    uname: uname,
                    height: height,
                    weight: weight,
                    email: email,
                    mobile: mobile,
                    activityBuilder: activity,
                  ));
                },
              ),
              //gender
              Container(
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    radioBuilder('Male', Gender.male),
                    radioBuilder('Female', Gender.female),
                  ],
                ),
              ),

              FieldAndLabel(
                fieldType: FieldType.TextField,
                icon: Image.asset(
                  ic_height,
                  height: 28,
                  width: 28,
                ),
                controller: heightController,
                inputType: TextInputType.number,
                hint: 'Height',
                inputAction: TextInputAction.next,
                enabled: true,
                onChanged: (val) {
                  height = val;
                  activity = _value;
                  bloc.add(UpdateUserInitialEvent(
                    uname: uname,
                    height: height,
                    weight: weight,
                    email: email,
                    mobile: mobile,
                    activityBuilder: activity,
                  ));
                },
                validationMessage: heightMsg,
                focusNode: heightFocus,
                nextFocusNode: weightFocus,
              ),
              FieldAndLabel(
                icon: Image.asset(
                  ic_weight,
                  height: 28,
                  width: 28,
                ),
                controller: weightController,
                inputType: TextInputType.number,
                hint: 'Weight',
                onChanged: (val) {
                  weight = val;
                  activity = _value;
                  bloc.add(UpdateUserInitialEvent(
                    uname: uname,
                    height: height,
                    weight: weight,
                    email: email,
                    mobile: mobile,
                    activityBuilder: activity,
                  ));
                },
                validationMessage: weightMsg,
                inputAction: TextInputAction.next,
                enabled: true,
                focusNode: weightFocus,
                nextFocusNode: emailFocus,
              ),

              //birthdate
              InkWell(
                onTap: () => _selectDate(context),
                child: FieldAndLabel(
                  intialValue:
                      DateFormat('dd-MM-yyyy').format(selectedDate.toLocal()),
                  icon: Image.asset(
                    ic_birthdate,
                    width: 28,
                    height: 28,
                  ),
                ),
              ),

              FieldAndLabel(
                icon: Image.asset(
                  ic_email,
                  width: 28,
                  height: 28,
                ),
                controller: emailController,
                inputType: TextInputType.emailAddress,
                hint: 'Email',
                onChanged: (val) {
                  email = val;
                  activity = _value;
                  bloc.add(UpdateUserInitialEvent(
                    uname: uname,
                    height: height,
                    weight: weight,
                    email: email,
                    mobile: mobile,
                    activityBuilder: activity,
                  ));
                },
                inputAction: TextInputAction.next,
                validationMessage: emailMsg,
                focusNode: emailFocus,
                nextFocusNode: mobileFocus,
                enabled: true,
              ),

              FieldAndLabel(
                icon: Image.asset(
                  ic_mobile,
                  width: 28,
                  height: 28,
                ),
                controller: mobileController,
                inputType: TextInputType.phone,
                hint: 'Mobile',
                inputAction: TextInputAction.next,
                validationMessage: mobileMsg,
                focusNode: mobileFocus,
                nextFocusNode: null,
                enabled: true,
                onChanged: (val) {
                  mobile = val;
                  activity = _value;
                  bloc.add(UpdateUserInitialEvent(
                    uname: uname,
                    height: height,
                    weight: weight,
                    email: email,
                    mobile: mobile,
                    activityBuilder: activity,
                  ));
                },
              ),

              activityBuilder(),
            ],
          ),
        ),
        //button
        Center(
          child: ButtonBuilder(
            name: 'Update',
            status: status,
            width: 300,
            onPress: status ? sendData : () {},
          ),
        ),
        Center(
          child: ButtonBuilder(
            name: 'Change Password',
            status: true,
            width: 300,
            onPress: () {
              var c = _showChangePassword(context);
            },
          ),
        ),
      ],
    );
    var l = new List<Widget>();
    l.add(form);
    if (_saving) {
      l.add(screenProgressIndicator);
    }
    return l;
  }

  Widget activityBuilder() {
    print("*-*-*- $activity");
    return DropdownButton(
      value: activity,
      isExpanded: true,
      items: [
        DropdownMenuItem(
            child: Text("Activity Level"), value: 'Activity Level'),
        DropdownMenuItem(child: Text("Normal"), value: 'Normal'),
        DropdownMenuItem(child: Text("Light"), value: 'Light'),
        DropdownMenuItem(child: Text("Medium"), value: 'Medium'),
        DropdownMenuItem(child: Text("Active"), value: 'Active')
      ],
      onChanged: (val) {
        activity = val;
        _value = val;
        bloc.add(UpdateUserInitialEvent(
          uname: uname,
          height: height,
          weight: weight,
          email: email,
          mobile: mobile,
          activityBuilder: activity,
        ));
      },
    );
  }

  /* Widget activityBuilder() {
    return FieldAndLabel<DropdownMenuItem<String>>(
      fieldType: FieldType.DropDownList,
      fieldValue: activity,
      enabled: true,
      validationMessage: activityMsg,
      listItems: [
        DropdownMenuItem(
            child: Text("Activity Level"), value: 'Activity Level'),
        DropdownMenuItem(child: Text("Normal"), value: 'Normal'),
        DropdownMenuItem(child: Text("Light"), value: 'Light'),
        DropdownMenuItem(child: Text("Medium"), value: 'Medium'),
        DropdownMenuItem(child: Text("Active"), value: 'Active')
      ],
      icon: Image.asset(
        ic_activity_level,
        height: 28,
        width: 28,
      ),
      onChanged: (val) {
        activity = val;
        _value = val;
        bloc.add(UpdateUserInitialEvent(
          uname: uname,
          height: height,
          weight: weight,
          email: email,
          mobile: mobile,
          activityBuilder: activity,
        ));
      },
    );
  }*/

  Widget radioBuilder(String label, Gender val) {
    return Container(
        height: 20,
        child: Row(
          children: [
            Transform.scale(
              scale: 1.0,
              child: Radio(
                activeColor: theme,
                value: val,
                groupValue: _gender,
                onChanged: (Gender value) {
                  setState(() {
                    _gender = value;
                  });
                },
              ),
            ),
            Text(
              label,
              style: TextStyle(fontSize: 15),
            )
          ],
        ));
  }

  Future<String> _selectDate(BuildContext context) async {
    // set = true;
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    return selectedDate.toString();
  }

  void sendData() {
    print(_value);
    bloc.add(UpdateUserDataEvent(
      uname: usernameController.text,
      gender: _gender.toString(),
      height: heightController.text,
      weight: weightController.text,
      birthdate: DateFormat('dd-MM-yyyy').format(selectedDate),
      email: emailController.text,
      mobile: mobileController.text,
      activityBuilder: _value,
      image: image,
      data: Data,
    ));
  }

  Future<File> _imgFromCamera() async {
    File _img;
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    setState(() {
      if (pickedFile != null)
        _img = File(pickedFile.path);
      else {}
    });
    return _img;
  }

  Future<File> _imgFromGallery() async {
    File _img;
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      if (pickedFile != null)
        _img = File(pickedFile.path);
      else {}
    });
    return _img;
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Photo Library'),
                    onTap: () async {
                      image = await _imgFromGallery();
                      Navigator.of(context).pop();
                    },
                  ),
                  new ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () async {
                      image = await _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future _showChangePassword(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              children: [
                Stack(
                  children: [
                    Expanded(
                      child: Center(
                          child: Text(
                        changePassword,
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
              ],
            ),
            shape: roundedRectangleBorder(radius: 15),
            content: ChangePassword(),
          );
        });
  }
}
