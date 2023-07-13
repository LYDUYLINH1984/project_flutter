import 'package:flutter/material.dart';
import 'package:flutter_app_sale_25042023/common/base/base_widget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      providers: [],
      appBar: AppBar(
        title: Text("Sign up"),
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
    return const Placeholder();
  }
}


