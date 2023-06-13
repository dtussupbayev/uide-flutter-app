import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uide/ui/navigation/main_navigation.dart';
import 'package:uide/ui/provider/project_provider.dart';
import 'package:uide/ui/theme/project_colors.dart';
import 'package:uide/ui/theme/project_styles.dart';
import 'package:uide/ui/widgets/auth/auth_data.dart';
import 'package:uide/ui/widgets/auth/register/create_password/create_password_model.dart';
import 'package:uide/utils/header_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as UserAuthData;
    final model = ProjectNotifierProvider.watch<CreatePasswordModel>(context);

    const pageColor = ProjectColors.kDarkerLightGreen;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
                  HeaderWidget(
                    height: screenHeight * 0.23,
                  ),
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
                                  textInputAction: TextInputAction.next,
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
                                      if (kDebugMode) {
                                        print(model?.passwordController.text);
                                      }
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
