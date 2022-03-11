// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtys_kalite/componenets/custom_alert_dialog.dart';
import 'package:vtys_kalite/componenets/custom_button.dart';
import 'package:vtys_kalite/componenets/custom_datetimepicker.dart';
import 'package:vtys_kalite/componenets/custom_text.dart';
import 'package:vtys_kalite/componenets/custom_text_box.dart';
import 'package:vtys_kalite/helpers/helpers.dart';
import 'package:vtys_kalite/models/settings/branch.dart';
import 'package:vtys_kalite/utilities/controllers.dart';
import 'package:vtys_kalite/utilities/style.dart';

class AddNewBranch extends StatefulWidget {
  AddNewBranch({
    Key? key,
  }) : super(key: key);

  final TextEditingController controllerBranchName = TextEditingController();
  final TextEditingController controllerBranchUpper = TextEditingController();
  final TextEditingController controllerRules = TextEditingController();

  @override
  State<AddNewBranch> createState() => _AddNewBranchState();
}

class _AddNewBranchState extends State<AddNewBranch> {
  final _newBranchKey = GlobalKey<FormState>();
  DateTime holidayCalanders = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      title: Row(
        children: const [
          Icon(
            Icons.add,
            color: Colors.black,
            size: 24,
          ),
          SizedBox(width: 20),
          CustomText(text: "Yeni Birim Ekle"),
        ],
      ),
      content: Builder(builder: (context) {
        var width = MediaQuery.of(context).size.width;
        return SizedBox(
          width: width / 1.4,
          child: SingleChildScrollView(
            child: Form(
              key: _newBranchKey,
              child: Column(
                children: [
                  const Divider(
                    height: 8,
                    thickness: 3,
                  ),
                  CustomTextBox(
                    borderless: true,
                    label: "Birim Adı",
                    controller: widget.controllerBranchName,
                    validator: validator(),
                  ),
                  CustomTextBox(
                    borderless: true,
                    label: "Bağlı Olduğu Üst Birim (Opsiyonel)",
                    controller: widget.controllerBranchUpper,
                    validator: validator(),
                  ),
                  CustomTextBox(
                    maxLines: 6,
                    borderless: true,
                    label: "Kurallar",
                    controller: widget.controllerRules,
                    validator: validator(),
                  ),
                  const SizedBox(height: 10),
                  CustomDateTimePicker(
                    suffixWidget: const Icon(Icons.calendar_today_outlined),
                    labelText: "Tatil Takvimleri - Başlangıç",
                    borderless: true,
                    onChanged: (val) {
                      if (val != null) {
                        print("Holiday Calanders picker : " + val);
                      }
                      try {
                        holidayCalanders = dateTimeFormat.parse(val!);
                      } catch (e) {
                        print(e.toString());
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                      width: double.infinity,
                      title: "Ekle",
                      pressAction: () async {
                        if (_newBranchKey.currentState!.validate()) {
                          showDialogWaitingMessage(context);
                          for (Branch branch in branchController.branchList) {
                            if (branch.branchName ==
                                widget.controllerBranchName.text) {
                              showDialog(
                                context: context,
                                builder: (_) => CustomAlertDialog(
                                  titleWidget:
                                      widget.controllerBranchName.text != ""
                                          ? CustomText(
                                              textAlign: TextAlign.center,
                                              text: widget.controllerBranchName
                                                      .text +
                                                  " için şube adı zaten kayıtlı.",
                                              weight: FontWeight.bold,
                                            )
                                          : const CustomText(
                                              text: "Bilgiler boş bırakılamaz.",
                                            ),
                                  bodyWidget: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        const CustomText(
                                          text:
                                              " Şube adını tekrar kontrol ediniz. Sistemde zaten kayıtlıdır.",
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        CustomButton(
                                          title: "Tekrar Dene",
                                          pressAction: () {
                                            Get.back();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  bodyWidgetWidth:
                                      MediaQuery.of(context).size.width / 3,
                                ),
                              );
                              return;
                            }
                          }
                          await branchController.addNewBranch(
                            Branch(
                              id: 0,
                              companyId: optionalCompanyController.companyId.value,
                              branchName: widget.controllerBranchName.text,
                              branchUpper: widget.controllerBranchUpper.text,
                              rules: widget.controllerRules.text,
                              vacationDates: holidayCalanders.toString(),
                            ),
                          );
                          Navigator.pop(context);
                          Get.snackbar(
                            "Birim Ekleme Ekranı",
                            "Birim Kaydedildi",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: successfulColor,
                            padding: EdgeInsets.only(left: width / 2 - 100),
                          );
                        }
                      }),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  validator() {
    return (val) {
      if (val!.isEmpty) {
        return "Cannot Be Blank";
      } else {
        return null;
      }
    };
  }
}
