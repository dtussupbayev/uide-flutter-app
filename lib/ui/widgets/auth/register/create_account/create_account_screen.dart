import 'package:flutter/material.dart';

import 'package:email_validator/email_validator.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:uide/provider/provider.dart';
import 'package:uide/ui/theme/project_colors.dart';
import 'package:uide/ui/widgets/auth/register/create_account/create_account_model.dart';
import 'package:uide/utils/have_an_account_sign_in.dart';

import '../../../../theme/project_styles.dart';

import '../../../../../utils/header_widget.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<CreateAccountModel>(context);
    const pageColor = ProjectColors.kLightGreen;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: ColoredBox(
            color: pageColor,
            child: IntrinsicHeight(
              child: Column(
                children: [
                  const HeaderWidget(),
                  DecoratedBox(
                    decoration: const BoxDecoration(
                        color: ProjectColors.kWhite,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32.0),
                            topRight: Radius.circular(32.0))),
                    child: Form(
                      autovalidateMode: AutovalidateMode.disabled,
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormField(
                                controller: model!.emailController,
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
                                    : 'Введите действительный адрес электронной почты'),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 32.0),
                            child: IntlPhoneField(
                              controller: model.phoneController,
                              invalidNumberMessage:
                                  'Неверный номер мобильного телефона',
                              pickerDialogStyle: kCountryPickerDialogStyle,
                              showDropdownIcon: false,
                              decoration: const InputDecoration(
                                  hintText: 'Номер телефона',
                                  border: InputBorder.none,
                                  floatingLabelStyle: TextStyle(
                                      color: ProjectColors.kMediumGreen)),
                              initialCountryCode: 'KZ',
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormField(
                              controller: model.usernameController,
                              decoration: InputDecoration(
                                hintText: 'Имя пользователя',
                                filled: true,
                                fillColor: ProjectColors.kWhite,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Имя пользователя не может быть пустым';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: DropdownButtonFormField<String>(
                              style:
                                  const TextStyle(color: ProjectColors.kBlack),
                              decoration: kDefaultInputDecoration.copyWith(
                                hintStyle: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.15,
                                ),
                                hintText: 'Пол',
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 'MALE',
                                  child: Text('Мужской'),
                                ),
                                DropdownMenuItem(
                                  value: 'FEMALE',
                                  child: Text('Женский'),
                                ),
                              ],
                              onChanged: (value) {
                                model.selectedSex = value!;
                              },
                            ),
                          ),
                          const RegisterBenefitsWidget(),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    model.sendOtp(context);
                                  }
                                },
                                style: kElevatedButtonPrimary,
                                child: model.isLoading
                                    ? const Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: ProjectColors.kLightGreen,
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      )
                                    : const Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Text(
                                          'Далее',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: ProjectColors.kMediumGreen,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          const HaveAnAccountSignInWidget(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.20,
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

class RegisterBenefitsWidget extends StatelessWidget {
  const RegisterBenefitsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.grey[200],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Присоединяйтесь к Uide, идеальному приложению для поиска соседей и домов для совместного проживания.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
