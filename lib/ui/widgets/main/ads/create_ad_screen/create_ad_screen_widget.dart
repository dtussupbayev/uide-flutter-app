// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uide/provider/provider.dart';
import 'package:uide/ui/theme/project_styles.dart';
import 'package:uide/ui/theme/project_colors.dart';
import 'package:uide/ui/widgets/main/ads/create_ad_screen/create_ad_screen_model.dart';

class CreateAdScreenWidget extends StatefulWidget {
  const CreateAdScreenWidget({super.key});

  @override
  State<CreateAdScreenWidget> createState() => _CreateAdScreenWidgetState();
}

class _CreateAdScreenWidgetState extends State<CreateAdScreenWidget> {
  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<CreateAdScreenModel>(context);
    String? selectedCiyValue;
    String? selectedHouseValue;

    return DecoratedBox(
      decoration: kMainBackgroundGradientDecoration,
      child: SafeArea(
        child: Scaffold(
          appBar: const DefaultAppBar(),
          backgroundColor: ProjectColors.kTransparent,
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              autovalidateMode: AutovalidateMode.disabled,
              key: model!.formKey,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Row(
                    children: [
                      ChooseTypeOfHouseWidget(
                          selectedHouseValue: selectedHouseValue,
                          model: model),
                      const SizedBox(width: 10),
                      ChooseCityWidget(
                          selectedCiyValue: selectedCiyValue, model: model),
                    ],
                  ),
                  const SizedBox(height: 25),
                  DefaultInputTextField(
                    controller: model.addressDescriptionController,
                    hintText: 'Улица и номер дома',
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: DefaultInputTextField(
                          controller: model.addressPostalCodeController,
                          hintText: 'Почтовый индекс',
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DefaultInputTextField(
                          controller: model.floorController,
                          hintText: 'Этаж',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  UploadImageWidget(
                    isUploading: model.isUploading,
                    createImageUrl: model.createImageUrl,
                  ),
                  const SizedBox(height: 25),
                  /* Room Count Buttons
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Количество комнат',
                        style: TextStyle(
                          color: ProjectColors.kDarkGrey.withOpacity(0.8),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Flexible(
                            flex: 5,
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                buildRoomButton(1),
                                buildRoomButton(2),
                                buildRoomButton(3),
                                buildRoomButton(4),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: SizedBox(
                                width: double.maxFinite,
                                height:
                                    MediaQuery.of(context).size.width * 0.12,
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedRoomIndex = 0;
                                      isCustomSelected = !isCustomSelected;
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: isCustomSelected
                                        ? ProjectColors.kDarkerLightGreen
                                        : ProjectColors.kDarkerDarkGreen,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        side: BorderSide(
                                          color: isCustomSelected
                                              ? ProjectColors
                                                  .kDarkerLightGreen
                                              : Colors.grey,
                                          width: 1,
                                        )),
                                  ),
                                  child: Text(
                                    'Другое',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: ProjectColors.kWhite
                                            .withOpacity(0.5)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 25), */
                  Row(
                    children: [
                      Expanded(
                        child: DefaultInputTextField(
                          controller: model.areaController,
                          hintText: 'Площадь (в кв. м)',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DefaultInputTextField(
                          controller: model.priceController,
                          hintText: 'Цена (в тг.)',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: DefaultNumberInputTextField(
                          controller: model.numberOfRoomsController,
                          hintText: 'Количество комнат',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DefaultNumberInputTextField(
                          controller: model.numberOfResidentsController,
                          hintText: 'Число жителей',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  DefaultInputTextField(
                    controller: model.descriptionController,
                    hintText: 'Описание',
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 10),
                  CreateAdButtonWidget(
                    formKey: model.formKey,
                    model: model,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRoomButton(int roomNumber) {
    final model = NotifierProvider.watch<CreateAdScreenModel>(context);
    var roomButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: model!.selectedRoomIndex == roomNumber
          ? ProjectColors.kDarkerLightGreen
          : ProjectColors.kDarkerDarkGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: model.selectedRoomIndex == roomNumber
              ? ProjectColors.kDarkerLightGreen
              : Colors.grey,
          width: 1,
        ),
      ),
    );

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.12,
      height: MediaQuery.of(context).size.width * 0.12,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            if (model.selectedRoomIndex == roomNumber) {
              model.selectedRoomIndex = 0;
              model.isCustomSelected = false;
            } else {
              model.selectedRoomIndex = roomNumber;
              model.isCustomSelected = false;
            }
          });
        },
        style: roomButtonStyle,
        child: Text(
          roomNumber.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ProjectColors.kWhite.withOpacity(0.5),
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class CreateAdButtonWidget extends StatelessWidget {
  const CreateAdButtonWidget({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.model,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final CreateAdScreenModel? model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFFCE2332),
          border: Border.all(color: ProjectColors.kBlack.withOpacity(0.05)),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: ProjectColors.kBlack.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            side: const BorderSide(
              width: 0,
              color: ProjectColors.kTransparent,
            ),
            foregroundColor: ProjectColors.kWhite,
            backgroundColor: ProjectColors.kTransparent,
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              model!.createAd(context);
            }
          },
          child: const Text('Создать объявление'),
        ),
      ),
    );
  }
}

class UploadImageWidget extends StatelessWidget {
  final VoidCallback createImageUrl;
  const UploadImageWidget({
    super.key,
    required bool isUploading,
    required this.createImageUrl,
  }) : _isUploading = isUploading;

  final bool _isUploading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: ProjectColors.kMediumGreen,
          border: Border.all(
            color: ProjectColors.kBlack.withOpacity(0.1),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: ProjectColors.kBlack.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            side: const BorderSide(
              width: 0,
              color: ProjectColors.kTransparent,
            ),
            foregroundColor: ProjectColors.kWhite,
            backgroundColor: ProjectColors.kTransparent,
          ),
          onPressed: createImageUrl,
          child: _isUploading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    color: ProjectColors.kWhite,
                  ),
                )
              : const Text(
                  'Загрузить фотографии',
                ),
        ),
      ),
    );
  }
}

class ChooseCityWidget extends StatelessWidget {
  const ChooseCityWidget({
    super.key,
    required this.selectedCiyValue,
    required this.model,
  });

  final String? selectedCiyValue;
  final CreateAdScreenModel? model;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DecoratedBox(
        decoration: kGradientBoxDecoration.copyWith(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: DropdownButtonFormField<String>(
          iconEnabledColor: ProjectColors.kWhite.withOpacity(0.3),
          dropdownColor: ProjectColors.kDarkerDarkGreen,
          style: const TextStyle(color: ProjectColors.kWhite),
          decoration: kDefaultInputDecoration.copyWith(
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: ProjectColors.kWhite.withOpacity(0.4),
              ),
              hintText: 'Город'),
          value: selectedCiyValue,
          items: const [
            DropdownMenuItem(
              value: 'Алматы',
              child: Text('Алматы'),
            ),
            DropdownMenuItem(
              value: 'Астана',
              child: Text('Астана'),
            ),
          ],
          onChanged: (value) {
            model?.addressCityIdController.text = value ?? '';
          },
        ),
      ),
    );
  }
}

class ChooseTypeOfHouseWidget extends StatelessWidget {
  const ChooseTypeOfHouseWidget({
    super.key,
    required this.selectedHouseValue,
    required this.model,
  });

  final String? selectedHouseValue;
  final CreateAdScreenModel? model;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DecoratedBox(
        decoration: kGradientBoxDecoration.copyWith(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: DropdownButtonFormField<String>(
          iconEnabledColor: ProjectColors.kWhite.withOpacity(0.3),
          dropdownColor: ProjectColors.kDarkerDarkGreen,
          style: const TextStyle(color: ProjectColors.kWhite),
          decoration: kDefaultInputDecoration.copyWith(
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: ProjectColors.kWhite.withOpacity(0.4),
            ),
            hintText: 'Тип дома',
          ),
          value: selectedHouseValue,
          items: const [
            DropdownMenuItem(
              value: 'APPARTMENT',
              child: Text('Частный дом'),
            ),
            DropdownMenuItem(
              value: 'HOUSE',
              child: Text('Квартира'),
            ),
          ],
          onChanged: (value) {
            model?.typeOfHouseController.text = value ?? '';
          },
        ),
      ),
    );
  }
}

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 120,
      centerTitle: true,
      elevation: 0,
      title: const Column(
        children: [
          Text(
            'Создать',
            style: TextStyle(
              letterSpacing: 1,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Обьявление',
            style: TextStyle(
              letterSpacing: 1,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      backgroundColor: ProjectColors.kTransparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}

// ignore: must_be_immutable
class DefaultInputTextField extends StatefulWidget {
  final String hintText;
  final TextInputType keyboardType;
  TextEditingController controller;

  DefaultInputTextField({
    required this.controller,
    required this.hintText,
    super.key,
    required this.keyboardType,
  });

  @override
  State<DefaultInputTextField> createState() => _DefaultInputTextFieldState();
}

class _DefaultInputTextFieldState extends State<DefaultInputTextField> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: kGradientBoxDecoration.copyWith(
        borderRadius: BorderRadius.circular(10),
      ),
      child: DecoratedBox(
        decoration: kInnerDecoration,
        child: TextFormField(
          keyboardType: widget.keyboardType,
          style: TextStyle(
            fontSize: 16,
            color: ProjectColors.kWhite.withOpacity(0.7),
          ),
          controller: widget.controller,
          decoration: kDefaultInputDecoration.copyWith(
            contentPadding: const EdgeInsets.only(left: 20),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: ProjectColors.kWhite.withOpacity(0.4),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class DefaultNumberInputTextField extends StatefulWidget {
  final String hintText;
  final TextInputType keyboardType;
  TextEditingController controller;

  DefaultNumberInputTextField({
    required this.controller,
    required this.hintText,
    super.key,
    required this.keyboardType,
  });

  @override
  State<DefaultNumberInputTextField> createState() =>
      _DefaultNumberInputTextFieldState();
}

class _DefaultNumberInputTextFieldState
    extends State<DefaultNumberInputTextField> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: kGradientBoxDecoration.copyWith(
        borderRadius: BorderRadius.circular(10),
      ),
      child: DecoratedBox(
        decoration: kInnerDecoration,
        child: TextFormField(
          keyboardType: widget.keyboardType,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: TextStyle(
            fontSize: 16,
            color: ProjectColors.kWhite.withOpacity(0.7),
          ),
          controller: widget.controller,
          decoration: kDefaultInputDecoration.copyWith(
            contentPadding: const EdgeInsets.only(left: 20),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: ProjectColors.kWhite.withOpacity(0.4),
            ),
          ),
        ),
      ),
    );
  }
}
