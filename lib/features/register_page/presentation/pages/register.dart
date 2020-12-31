import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:way2fitlife/common/general/alert_dialog.dart';
import 'package:way2fitlife/common/general/circular_progress_indicator.dart';
import 'package:way2fitlife/common/general/field_and_label.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/di/dependency_injection.dart';
import 'package:way2fitlife/features/register_page/presentation/bloc/register_bloc.dart';
import 'package:way2fitlife/features/register_page/presentation/bloc/register_event.dart';
import 'package:way2fitlife/features/register_page/presentation/bloc/register_state.dart';
import 'package:way2fitlife/features/register_page/presentation/widget/button_builder.dart';
import 'package:way2fitlife/main.dart';
import 'package:way2fitlife/network/internet_connectivity.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/icons.dart';
import 'package:way2fitlife/ui_helper/images.dart';
import 'package:way2fitlife/ui_helper/strings.dart';
import 'package:way2fitlife/utils/screen_utils.dart';

RegisterInitState initSta = RegisterInitState(status: false);

class Register extends StatefulWidget {
  /* final Bloc bloc;

  Register({this.bloc});*/

  @override
  _RegisterState createState() => _RegisterState();
}

enum Gender { male, female }

class _RegisterState extends State<Register> {
  DateTime selectedDate = DateTime.now();
  String _value = '';
  File image;
  ImagePicker picker = ImagePicker();
  Gender _gender = Gender.male;
  final bloc = getIt<RegisterBloc>();
  final usernameController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final passController = TextEditingController();
  final cPassController = TextEditingController();
  final usernameFocus = FocusNode();
  final heightFocus = FocusNode();
  final weightFocus = FocusNode();
  final emailFocus = FocusNode();
  final mobileFocus = FocusNode();
  final passFocus = FocusNode();
  final cpassFocus = FocusNode();
  String unameMsg = '';
  String heightMsg = '';
  String weightMsg = '';
  String emailMsg = '';
  String mobileMsg = '';
  String passwordMsg = '';
  String cpasswordMsg = '';
  String activityMsg = '';
  String uname = '';
  String height = '';
  String weight = '';
  String email = '';
  String mobile = '';
  String password = '';
  String cpassword = '';
  String activity;
  bool _saving = false;
  int flag = 0;

  @override
  void initState() {
    super.initState();
    activity = '';
    bloc.add(RegisterInitEvent(
        uname: usernameController.text,
        gender: _gender.toString(),
        height: heightController.text,
        weight: weightController.text,
        birthdate: selectedDate.toString(),
        email: emailController.text,
        mobile: mobileController.text,
        activityBuilder: activity,
        pass: passController.text,
        cpass: cPassController.text));
  }

  @override
  void dispose() {
    usernameController.dispose();
    heightController.dispose();
    weightController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passController.dispose();
    cPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: labels(text: "Register"),
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
                        child: BlocListener<RegisterBloc, RegisterState>(
                          cubit: bloc,
                          listener: (context, state) {
                            if (state is RegisterLodingBeginState)
                              _saving = true;
                            if (state is RegisterLodingEndState)
                              _saving = false;
                            if (state is RegisterInitState) {
                              unameMsg = state.unameMsg;
                              heightMsg = state.heightMsg;
                              weightMsg = state.weightMsg;
                              emailMsg = state.emailMsg;
                              mobileMsg = state.mobileMsg;
                              passwordMsg = state.passwordMsg;
                              cpasswordMsg = state.cpasswordMsg;
                              activityMsg = state.activityMsg;
                              return Stack(
                                children: formBuild(state.status),
                              );
                            } else if (state is RegisterSendDataState) {
                              flag = state.model.flag;
                              if (flag == 1) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => MyApp(),
                                  ),
                                );
                                return null;
                              } else {
                                return Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text(state.model.msg)));
                              }
                            } else {
                              return Stack(
                                children: formBuild(initSta.status),
                              );
                            }
                          },
                          child: BlocBuilder<RegisterBloc, RegisterState>(
                            cubit: bloc,
                            builder: (context, state) {
                              if (state is RegisterInitState) {
                                unameMsg = state.unameMsg;
                                heightMsg = state.heightMsg;
                                weightMsg = state.weightMsg;
                                emailMsg = state.emailMsg;
                                mobileMsg = state.mobileMsg;
                                passwordMsg = state.passwordMsg;
                                cpasswordMsg = state.cpasswordMsg;
                                activityMsg = state.activityMsg;
                                return Stack(
                                  children: formBuild(state.status),
                                );
                              } else {
                                return Stack(
                                  children: formBuild(initSta.status),
                                );
                              }
                            },
                          ),
                        ),
                      ),

                      //Already Login
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Already have an account? ',
                              style: TextStyle(fontSize: 16),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                                        : assetsImage(user_placeholder),
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
                  bloc.add(RegisterInitEvent(
                      uname: uname,
                      height: height,
                      weight: weight,
                      email: email,
                      mobile: mobile,
                      pass: password,
                      cpass: cpassword,
                      activityBuilder: activity));
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
                  bloc.add(RegisterInitEvent(
                      uname: uname,
                      height: height,
                      weight: weight,
                      email: email,
                      mobile: mobile,
                      pass: password,
                      cpass: cpassword,
                      activityBuilder: activity));
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
                  bloc.add(RegisterInitEvent(
                      uname: uname,
                      height: height,
                      weight: weight,
                      email: email,
                      mobile: mobile,
                      pass: password,
                      cpass: cpassword,
                      activityBuilder: activity));
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
                  bloc.add(RegisterInitEvent(
                      uname: uname,
                      height: height,
                      weight: weight,
                      email: email,
                      mobile: mobile,
                      pass: password,
                      cpass: cpassword,
                      activityBuilder: activity));
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
                nextFocusNode: passFocus,
                enabled: true,
                onChanged: (val) {
                  mobile = val;
                  activity = _value;
                  bloc.add(RegisterInitEvent(
                      uname: uname,
                      height: height,
                      weight: weight,
                      email: email,
                      mobile: mobile,
                      pass: password,
                      cpass: cpassword,
                      activityBuilder: activity));
                },
              ),

              activityBuilder(),

              FieldAndLabel(
                intialValue: _value,
                icon: Image.asset(
                  ic_password,
                  height: 28,
                  width: 28,
                ),
                controller: passController,
                inputType: TextInputType.visiblePassword,
                inputAction: TextInputAction.next,
                focusNode: passFocus,
                nextFocusNode: cpassFocus,
                hint: 'Password',
                validationMessage: passwordMsg,
                enabled: true,
                onChanged: (val) {
                  password = val;
                  activity = _value;
                  bloc.add(RegisterInitEvent(
                      uname: uname,
                      height: height,
                      weight: weight,
                      email: email,
                      mobile: mobile,
                      pass: password,
                      cpass: cpassword,
                      activityBuilder: activity));
                },
                isPassword: true,
              ),
              FieldAndLabel(
                icon: Image.asset(
                  ic_password,
                  height: 28,
                  width: 28,
                ),
                controller: cPassController,
                inputType: TextInputType.visiblePassword,
                inputAction: TextInputAction.done,
                validationMessage: cpasswordMsg,
                hint: 'Confirm password',
                focusNode: cpassFocus,
                nextFocusNode: null,
                enabled: true,
                onChanged: (val) {
                  cpassword = val;
                  activity = _value;
                  print(_value);
                  bloc.add(RegisterInitEvent(
                      uname: uname,
                      height: height,
                      weight: weight,
                      email: email,
                      mobile: mobile,
                      pass: password,
                      cpass: cpassword,
                      activityBuilder: activity));
                },
                isPassword: true,
              ),
            ],
          ),
        ),
        //button
        Center(
          child: ButtonBuilder(
            name: 'Register',
            status: image == null ? false : status,
            width: 300,
            onPress: image == null
                ? () {}
                : status
                    ? sendData
                    : () {},
          ),
        ),
        verticalSpace(100),
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
    return FieldAndLabel<DropdownMenuItem<String>>(
      fieldType: FieldType.DropDownList,
      intialValue: _value,
      enabled: true,
      validationMessage: activityMsg,
      listItems: [
        DropdownMenuItem(
          child: Text("Activity Level"),
          value: 'Activity Level',
        ),
        DropdownMenuItem(
          child: Text("Normal"),
          value: 'Normal',
        ),
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
        bloc.add(RegisterInitEvent(
            uname: uname,
            height: height,
            weight: weight,
            email: email,
            mobile: mobile,
            pass: password,
            cpass: cpassword,
            activityBuilder: activity));
      },
    );
  }

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
    (MyConnectivity.internetStatus == internet_connected)
        ? bloc.add(RegisterSendDataEvent(
            uname: usernameController.text,
            gender: _gender.toString(),
            height: heightController.text,
            weight: weightController.text,
            birthdate: DateFormat('dd-MM-yyyy').format(selectedDate),
            email: emailController.text,
            mobile: mobileController.text,
            activityBuilder: _value,
            pass: passController.text,
            cpass: cPassController.text,
            image: image))
        : internetAlertDialog(context);
    ;
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
                  ),
                  Container(
                    height: 60,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
