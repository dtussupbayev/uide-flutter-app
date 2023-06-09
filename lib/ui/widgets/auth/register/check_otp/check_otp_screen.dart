import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:uide/ui/theme/project_colors.dart';
import 'package:uide/ui/widgets/auth/auth_data.dart';
import 'package:uide/ui/widgets/auth/register/check_otp/check_otp_model.dart';
import 'package:uide/utils/header_widget.dart';
import 'package:uide/utils/have_an_account_sign_in.dart';

import '../../../../../provider/project_provider.dart';
import '../../../../theme/project_styles.dart';

class CheckOtpScreen extends StatefulWidget {
  const CheckOtpScreen({super.key});

  @override
  State<CheckOtpScreen> createState() => _CheckOtpScreenState();
}

class _CheckOtpScreenState extends State<CheckOtpScreen> {
  @override
  Widget build(BuildContext context) {
    final model = ProjectNotifierProvider.watch<CheckOtpModel>(context);
    final arguments =
        ModalRoute.of(context)!.settings.arguments as UserAuthData;
    const pageColor = ProjectColors.kDarkerLightGreen;
    return Scaffold(
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
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(height: 30),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            child: Form(
                              key: model!.formKey,
                              child: Column(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        textAlign: TextAlign.center,
                                        'Введите код подтверждения, отправленный на',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Text(
                                        arguments.email!,
                                        style: const TextStyle(
                                          color: ProjectColors.kDarkGreen,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InputNumberOTPWidget(
                                        otpConroller: model.otpDigit1,
                                        digitPosition: 1,
                                      ),
                                      InputNumberOTPWidget(
                                        otpConroller: model.otpDigit2,
                                        digitPosition: 2,
                                      ),
                                      InputNumberOTPWidget(
                                        otpConroller: model.otpDigit3,
                                        digitPosition: 3,
                                      ),
                                      InputNumberOTPWidget(
                                        otpConroller: model.otpDigit4,
                                        digitPosition: 4,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: model.isLoading
                                          ? () {}
                                          : () {
                                              if (model.formKey.currentState!
                                                  .validate()) {
                                                var otpCode =
                                                    model.otpDigit1.text +
                                                        model.otpDigit2.text +
                                                        model.otpDigit3.text +
                                                        model.otpDigit4.text;
                                                model.validateOtp(arguments,
                                                    otpCode, context);

                                                // _validateOtp(
                                                //     emailOfUser, otpCode);
                                              }
                                            },
                                      style: kElevatedButtonPrimary,
                                      child: model.isLoading
                                          ? const Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: SizedBox(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  color:
                                                      ProjectColors.kLightGreen,
                                                  strokeWidth: 2,
                                                ),
                                              ),
                                            )
                                          : const Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: Text(
                                                'Проверить',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: ProjectColors
                                                      .kMediumGreen,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                  const HaveAnAccountSignInWidget(),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.4,
                          ),
                        ],
                      ),
                    ),
                  )
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
class InputNumberOTPWidget extends StatefulWidget {
  TextEditingController otpConroller;
  int digitPosition;
  InputNumberOTPWidget(
      {super.key, required this.otpConroller, required this.digitPosition});

  @override
  State<InputNumberOTPWidget> createState() => _InputNumberOTPWidgetState();
}

class _InputNumberOTPWidgetState extends State<InputNumberOTPWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      width: 64,
      child: TextFormField(
        cursorColor: ProjectColors.kDarkerLightGreen,
        controller: widget.otpConroller,
        decoration: InputDecoration(
          counter: const Offstage(),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(width: 2, color: ProjectColors.kBlack12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              width: 2,
              color: ProjectColors.kMediumGreen,
            ),
          ),
          hintText: '*',
          hintStyle: TextStyle(color: Colors.grey.shade500),
        ),
        onChanged: (value) {
          if (value.length == 1 && widget.digitPosition != 4) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty && widget.digitPosition != 1) {
            FocusScope.of(context).previousFocus();
          }
        },
        style: const TextStyle(
          color: ProjectColors.kBlack26,
          fontSize: 22,
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }
}
