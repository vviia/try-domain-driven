import 'package:trying_to_not_crying/app/core/domain/failures/failure.dart';
import 'package:trying_to_not_crying/app/features/auth/application/register/register_view_contract.dart';
import 'package:trying_to_not_crying/app/features/auth/domain/failures/failures.dart';
import 'package:trying_to_not_crying/app/features/auth/domain/value_objects/user_email.dart';
import 'package:trying_to_not_crying/app/features/auth/domain/value_objects/user_full_name.dart';
import 'package:trying_to_not_crying/app/features/auth/domain/value_objects/user_password.dart';
import 'package:trying_to_not_crying/app/core/application/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:get/get.dart';

import '../application/register/register_controller.dart';

class RegisterView extends GetView<RegisterController>
    implements RegisterViewContract {
  @override
  StatelessElement createElement() {
    controller.view = this;
    return super.createElement();
  }

  final form = GlobalKey<FormState>();

  RegisterView({Key? key}) : super(key: key);

/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('LoginView'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
              key: form,
              child: Column(children: [
                ElevatedButton(
                    onPressed: controller.onTapRegisterButton,
                    child: const Text('Register'))
              ])),
        ));
  }
*/
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  x() async {
/*
    final dioResult = await Get.find<ConfiguredDio>().dio.post('/register-user',
        data:FormData.fromMap(
          {"fullName": 'name', "email": 'email', "password": 'password'}
        ));
*/
  }

  Widget _submitButton() {
    x();

    return InkWell(
      onTap: () => controller.onTapRegisterButton(),
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Text(
          'Register Now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.LOGIN);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Regi',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xffe46b10)),
          children: [
            TextSpan(
              text: 'ster',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: ' now',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(hintText: 'Full Name'),
          validator: (_) =>
              UserFullName(_!).value.fold((l) => 'Invalid Name', (r) => null),
          onChanged: (_) => controller.onChangeNameTextField(UserFullName(_)),
        ),
        SizedBox(height: 10),
        TextFormField(
          decoration: InputDecoration(hintText: 'Email'),
          validator: (_) => UserEmail(_!)
              .value
              .fold((l) => 'Invalid email address', (r) => null),
          onChanged: (_) => controller.onChangeEmailTextField(UserEmail(_)),
        ),
        SizedBox(height: 10),
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(hintText: 'Password'),
          validator: (_) => UserPassword(_!)
              .value
              .fold((l) => 'Invalid password', (r) => null),
          onChanged: (_) =>
              controller.onChangePasswordTextField(UserPassword(_)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
/*
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
*/
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: form,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),
                      _title(),
                      SizedBox(
                        height: 50,
                      ),
                      _emailPasswordWidget(),
                      SizedBox(
                        height: 20,
                      ),
                      _submitButton(),
                      SizedBox(height: height * .14),
                      _loginAccountLabel(),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }

  @override
  onFailed(Failure failure) {
    if (failure is EmailAlreadyExistsFailure) {
      Get.snackbar('Error', 'Email already exists');
    }
    if (failure is ServerFailure) {
      Get.snackbar('Error', 'Server error');
    }
    if (failure is UnExpectedFailure) {
      Get.snackbar('Error', 'Unexpected error');
    }
  }

  @override
  onSuccess() {
    Get.back();
  }

  @override
  bool validateForm() {
    return form.currentState!.validate();
  }
}