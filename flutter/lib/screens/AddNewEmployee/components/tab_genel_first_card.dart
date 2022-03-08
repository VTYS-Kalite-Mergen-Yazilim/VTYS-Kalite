import 'package:flutter/material.dart';
import 'package:vtys_kalite/componenets/custom_text.dart';
import 'package:vtys_kalite/enums/departments_enum.dart';
import 'package:vtys_kalite/models/user.dart';
import 'package:vtys_kalite/screens/AddNewEmployee/components/tab_genel_first_card_image.dart';
import 'package:vtys_kalite/utilities/controllers.dart';

class TabGenelFirstCard extends StatelessWidget {
  final User user;

  const TabGenelFirstCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FirstCardImage(user: user),
          firstCardProfileAbout(),
        ],
      ),
    );
  }

  Widget firstCardProfileAbout() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(text: "İşe Başlama Tarih"),
                CustomText(
                    text: dateFormat.format(tabGenelController.dateOfStart)),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(text: "Şirket"),
                CustomText(
                    text: companyController
                        .companyList[tabKariyerController.positionSirketIndex]
                        .companyName),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(text: "Şube"),
                CustomText(
                    text: branchController
                        .branchList[tabKariyerController.positionSubeIndex]
                        .branchName),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(text: "Departman"),
                CustomText(text: user.title.getName),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(text: "E-posta (iş)"),
                CustomText(text: tabGenelController.controllerEPostaWork.text),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(text: "İş Telefonu"),
                CustomText(text: tabGenelController.controllerWorkPhone.text),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
