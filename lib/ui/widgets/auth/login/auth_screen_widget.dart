import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:uide/navigation/main_navigation.dart';
import 'package:uide/provider/provider.dart';
import 'package:uide/ui/theme/project_colors.dart';

import '../../../theme/project_styles.dart';
import '../../../../utils/header_widget.dart';
import 'auth_model.dart';

class AuthScreenWidget extends StatefulWidget {
  const AuthScreenWidget({super.key});

  @override
  State<AuthScreenWidget> createState() => _AuthScreenWidgetState();
}

class _AuthScreenWidgetState extends State<AuthScreenWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<AuthModel>(context);
    const pageColor = ProjectColors.kLightGreen;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: pageColor,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  const HeaderWidget(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.77,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(32),
                          topLeft: Radius.circular(32),
                        ),
                        color: ProjectColors.kWhite,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Form(
                          autovalidateMode: AutovalidateMode.disabled,
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 40),
                              TextFormField(
                                controller: model?.emailController,
                                decoration: InputDecoration(
                                  hintText: 'Почта',
                                  filled: true,
                                  fillColor: ProjectColors.kWhite,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                validator: (value) => EmailValidator.validate(
                                        value!)
                                    ? null
                                    : 'Введите действительный адрес электронной почты',
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: model?.passwordController,
                                obscureText: !model!.showPassword,
                                decoration: InputDecoration(
                                  hintText: 'Пароль',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      model.showPassword
                                          ? Icons.visibility_rounded
                                          : Icons.visibility_off_outlined,
                                      color: const Color.fromRGBO(
                                          200, 200, 200, 1),
                                    ),
                                    onPressed: () => model.setShowPassword(
                                      !model.showPassword,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Пароль не может быть пустым';
                                  } else if (value.length < 4) {
                                    return 'Пароль должен состоять не менее чем из 4 символов';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 30),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Забыли пароль?',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: ProjectColors.kGrey,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              _AuthButtonWidget(formKey: _formKey),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'У вас нет аккаунта?',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: ProjectColors.kGrey,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        MainNavigationRouteNames
                                            .createAccountScreen,
                                      );
                                    },
                                    child: const Text(
                                      'Зарегистрироваться',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: ProjectColors.kDarkerLightGreen,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _AuthButtonWidget extends StatefulWidget {
  GlobalKey<FormState> formKey;

  _AuthButtonWidget({required this.formKey});

  @override
  State<_AuthButtonWidget> createState() => _AuthButtonWidgetState();
}

class _AuthButtonWidgetState extends State<_AuthButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<AuthModel>(context);
    onPressed() {
      print('pressed');
      if (widget.formKey.currentState!.validate()) {
        print('au');
        model?.auth(context);
      }
    }

    const child = Text(
      'Войти',
      style: TextStyle(
        fontSize: 18,
        color: ProjectColors.kDarkerLightGreen,
        fontWeight: FontWeight.normal,
      ),
    );

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: kElevatedButtonPrimary,
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: child,
        ),
      ),
    );
  }
}
