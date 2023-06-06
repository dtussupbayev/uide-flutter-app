import 'package:flutter/material.dart';
import 'package:uide/navigation/main_navigation.dart';
import 'package:uide/provider/provider.dart';
import 'package:uide/ui/widgets/auth/auth_data.dart';
import 'package:uide/ui/widgets/auth/register/create_password/create_password_model.dart';
import 'package:uide/utils/header_widget.dart';

import '../../../../theme/project_styles.dart';
import '../../../../theme/project_colors.dart';

class CreatePasswordScreenWidget extends StatefulWidget {
  const CreatePasswordScreenWidget({super.key});

  @override
  State<CreatePasswordScreenWidget> createState() =>
      _CreatePasswordScreenWidgetState();
}

class _CreatePasswordScreenWidgetState
    extends State<CreatePasswordScreenWidget> {
  bool _showPassword = false;
  final _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final bool _isLoading = false;

  // Future<void> register(email) async {
  //     final headers = {'Content-Type': 'application/json'};
  //     final url =
  //         Uri.parse(ApiEndPoints.baseurl + ApiEndPoints.authEndPoints.signUp);
  //     final Map body = {
  //       'email': email,
  //       'password': _passwordController.text,
  //     };

  //     setState(() {
  //       _isLoading = true;
  //     });

  //     http.Response response =
  //         await http.post(url, body: jsonEncode(body), headers: headers);

  //     setState(() {
  //       _isLoading = false;
  //     });

  //     if (response.statusCode == 200) {
  //     } else {
  //       // registration failed, show error message
  //     }
  //   }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as UserAuthData;
    final model = NotifierProvider.watch<CreatePasswordModel>(context);

    const pageColor = ProjectColors.kDarkerLightGreen;

    return Scaffold(
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
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(32),
                        topLeft: Radius.circular(32),
                      ),
                      color: ProjectColors.kWhite,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(height: 10),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                Text(
                                  'Создайте свой пароль',
                                  style: TextStyle(
                                    color: ProjectColors.kDarkGreen
                                        .withOpacity(0.6),
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                TextFormField(
                                  controller: model?.passwordController,
                                  obscureText: !_showPassword,
                                  decoration: InputDecoration(
                                    hintText: 'Пароль',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _showPassword
                                            ? Icons.visibility_rounded
                                            : Icons.visibility_off_outlined,
                                        color: const Color.fromRGBO(
                                            200, 200, 200, 1),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _showPassword = !_showPassword;
                                        });
                                      },
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
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: _confirmPasswordController,
                                  obscureText: !_showPassword,
                                  decoration: InputDecoration(
                                    hintText: 'Подтверждение пароля',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _showPassword
                                            ? Icons.visibility_rounded
                                            : Icons.visibility_off_outlined,
                                        color: const Color.fromRGBO(
                                            200, 200, 200, 1),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _showPassword = !_showPassword;
                                        });
                                      },
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Пожалуйста, подтвердите свой пароль';
                                    } else if (value !=
                                        model?.passwordController.text) {
                                      print(model?.passwordController.text);
                                      return 'Пароли не совпадают';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 30),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: _isLoading
                                        ? null
                                        : () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              model?.register(
                                                  context, arguments);
                                            }
                                          },
                                    style: kElevatedButtonPrimary,
                                    child: _isLoading
                                        ? const Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                color:
                                                    ProjectColors.kPrimaryColor,
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          )
                                        : const Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Text(
                                              'Создать аккаунт',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: ProjectColors
                                                      .kMediumGreen,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'У вас уже есть аккаунт?',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Navigator.pop(context);
                                        Navigator.pushNamed(
                                          context,
                                          MainNavigationRouteNames.authScreen,
                                        );
                                      },
                                      child: const Text(
                                        'Войти',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              ProjectColors.kDarkerMediumGreen,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                          ),
                        ],
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
