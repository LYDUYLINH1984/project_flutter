import 'package:flutter/material.dart';
import 'package:flutter_app_sale_25042023/common/app_constants.dart';
import 'package:flutter_app_sale_25042023/common/base/base_widget.dart';
import 'package:flutter_app_sale_25042023/data/api/api_request.dart';
import 'package:flutter_app_sale_25042023/data/repository/authentication_repository.dart';
import 'package:flutter_app_sale_25042023/utils/dimension_utils.dart';
import 'package:flutter_app_sale_25042023/utils/message_utils.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      providers: [],
      appBar: AppBar(
        title: const Text("Sign up"),
      ),
      child: SignUpContainer(),
    );
  }
}

class SignUpContainer extends StatefulWidget {
  const SignUpContainer({Key? key}) : super(key: key);

  @override
  State<SignUpContainer> createState() => _SignUpContainerState();
}

class _SignUpContainerState extends State<SignUpContainer> {

  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
            child: Container(
              constraints: const BoxConstraints.expand(),
              child: LayoutBuilder(builder: (context, constraint) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraint.maxHeight),
                    child: IntrinsicHeight(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                                flex: 2,
                                child:
                                Image.asset(AppConstants.IMAGE_BANNER_ASSETS)),
                            Expanded(
                              flex: 4,
                              child: Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: DimensionUtils
                                              .paddingHeightDivideNumber(context)),
                                      child: _buildEmailTextField(),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: DimensionUtils
                                              .paddingHeightDivideNumber(context)),
                                      child: _buildPasswordTextField(),
                                    ),
                                    _buildButtonSignIn(),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(child: _buildTextSignUp())
                          ],
                        )
                    ),
                  ),
                );
              }),
            )),
    );
  }

  Widget _buildTextSignUp() {
    return Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have an account!"),
            InkWell(
              onTap: () {},
              child: const Text("Sign Up",
                  style: TextStyle(
                      color: Colors.red, decoration: TextDecoration.underline)),
            )
          ],
        ));
  }

  Widget _buildEmailTextField() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          fillColor: Colors.black12,
          filled: true,
          hintText: "Email",
          labelStyle: const TextStyle(color: Colors.blue),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(width: 0, color: Colors.black12)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(width: 0, color: Colors.black12)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(width: 0, color: Colors.black12)),
          prefixIcon: const Icon(Icons.email, color: Colors.blue),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        maxLines: 1,
        obscureText: true,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          fillColor: Colors.black12,
          filled: true,
          hintText: "PassWord",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(width: 0, color: Colors.black12)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(width: 0, color: Colors.black12)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(width: 0, color: Colors.black12)),
          labelStyle: const TextStyle(color: Colors.blue),
          prefixIcon: const Icon(Icons.lock, color: Colors.blue),
        ),
      ),
    );
  }

  Widget _buildButtonSignIn() {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: ElevatedButtonTheme(
            data: ElevatedButtonThemeData(
                style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.blue[500];
                } else if (states.contains(MaterialState.disabled)) {
                  return Colors.grey;
                }
                return Colors.blueAccent;
              }),
              elevation: MaterialStateProperty.all(5),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 100)),
            )),
            child: ElevatedButton(
              onPressed: () {  },
              child: const Text("Login",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            )));
  }
}
