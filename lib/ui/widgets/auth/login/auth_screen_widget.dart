import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uide/ui/navigation/main_navigation.dart';
import 'package:uide/ui/provider/project_provider.dart';
import 'package:uide/ui/resources/resources.dart';
import 'package:uide/ui/theme/project_colors.dart';
import 'package:uide/ui/theme/project_styles.dart';
import 'package:uide/utils/header_widget.dart';

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
    final model = ProjectNotifierProvider.watch<AuthModel>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (kIsWeb || Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
      return _DesktopLayout(
        model: model,
        formKey: _formKey,
        screenHeight: screenHeight,
        screenWidth: screenWidth,
      );
    }
    return _MobileLayout(
      model: model,
      formKey: _formKey,
      screenHeight: screenHeight,
      screenWidth: screenWidth,
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout({
    required GlobalKey<FormState> formKey,
    required this.model,
    required this.screenHeight,
    required this.screenWidth,
  }) : _formKey = formKey;

  final double screenHeight;
  final double screenWidth;
  final GlobalKey<FormState> _formKey;
  final AuthModel? model;

  @override
  Widget build(BuildContext context) {
    const pageColor = ProjectColors.kLightGreen;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: pageColor,
              ),
              child: Column(
                children: [
                  HeaderWidget(
                    height: screenHeight * 0.23,
                  ),
                  Expanded(
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
                                textInputAction: TextInputAction.next,
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
                                      model!.showPassword
                                          ? Icons.visibility_rounded
                                          : Icons.visibility_off_outlined,
                                      color: const Color.fromRGBO(
                                          200, 200, 200, 1),
                                    ),
                                    onPressed: () => model!.setShowPassword(
                                      !model!.showPassword,
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

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({
    required GlobalKey<FormState> formKey,
    required this.model,
    required this.screenHeight,
    required this.screenWidth,
  }) : _formKey = formKey;

  final double screenHeight;
  final double screenWidth;
  final GlobalKey<FormState> _formKey;
  final AuthModel? model;

  @override
  Widget build(BuildContext context) {
    const pageColor = ProjectColors.kLightGreen;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Container(
            height: screenHeight,
            width: screenWidth,
            decoration: const BoxDecoration(
              color: pageColor,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(32.0),
                    child: Container(
                      width: screenWidth * 0.4,
                      height: screenWidth * 0.4,
                      margin: const EdgeInsets.only(bottom: 10.0, right: 10.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(32),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400.withOpacity(0.5),
                              blurRadius: 10.0,
                              spreadRadius: 0.0,
                              offset: const Offset(3.0, 3.0),
                            ),
                          ],
                          color: ProjectColors.kWhite,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Center(
                            child: Form(
                              autovalidateMode: AutovalidateMode.disabled,
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 100),
                                  Image.asset(
                                    Images.appleAppIcon,
                                    width: 100,
                                    height: 100,
                                  ),
                                  const SizedBox(height: 50),
                                  TextFormField(
                                    textInputAction: TextInputAction.next,
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
                                    validator: (value) => EmailValidator
                                            .validate(value!)
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
                                          model!.showPassword
                                              ? Icons.visibility_rounded
                                              : Icons.visibility_off_outlined,
                                          color: const Color.fromRGBO(
                                              200, 200, 200, 1),
                                        ),
                                        onPressed: () => model!.setShowPassword(
                                          !model!.showPassword,
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
                                            color:
                                                ProjectColors.kDarkerLightGreen,
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

class _AuthButtonWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const _AuthButtonWidget({required this.formKey});

  @override
  State<_AuthButtonWidget> createState() => _AuthButtonWidgetState();
}

class _AuthButtonWidgetState extends State<_AuthButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final model = ProjectNotifierProvider.watch<AuthModel>(context);
    onPressed() {
      if (kDebugMode) {
        print('pressed');
      }
      if (widget.formKey.currentState!.validate()) {
        if (kDebugMode) {
          print('au');
        }
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
