// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtys_kalite/componenets/custom_button.dart';
import 'package:vtys_kalite/componenets/custom_text.dart';
import 'package:vtys_kalite/controller/Frontend%20Controller/user_helper_controller.dart';
import 'package:vtys_kalite/helpers/responsiveness.dart';
import 'package:vtys_kalite/models/user.dart';
import 'package:vtys_kalite/routing/routes.dart';
import 'package:vtys_kalite/screens/AddNewEmployee/add_new_employee_helpers.dart';
import 'package:vtys_kalite/screens/AddNewEmployee/tab_diger_bilgiler.dart';
import 'package:vtys_kalite/screens/AddNewEmployee/tab_genel.dart';
import 'package:vtys_kalite/screens/AddNewEmployee/tab_kariyer.dart';
import 'package:vtys_kalite/screens/AddNewEmployee/tab_kariyer_small.dart';
import 'package:vtys_kalite/screens/AddNewEmployee/tab_kisisel_bilgiler.dart';
import 'package:vtys_kalite/screens/AddNewEmployee/tab_kisisel_bilgiler_small.dart';
import 'package:vtys_kalite/utilities/style.dart';

class AddNewEmployee extends StatelessWidget {
  var isSaved = false.obs;
  User? user;
  late UserHelperController userHelper;

  AddNewEmployee({
    Key? key,
    this.user,
  }) : super(key: key) {
    if (user != null) {
      userHelper = UserHelperController(user!.id);
      showInformationWhenOnClick(userHelper);
    } else {
      userHelper = UserHelperController(-1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          backgroundColor: activeColor,
          foregroundColor: Colors.white,
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: const CustomText(text: "Personel"),
          leading: IconButton(
            icon: const Icon(Icons.keyboard_arrow_left),
            onPressed: () => Get.offAllNamed(rootRoute),
          ),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(child: CustomText(text: 'Genel', color: lightColor)),
              Tab(child: CustomText(text: 'Kariyer', color: lightColor)),
              Tab(
                  child:
                      CustomText(text: 'Kişisel Bilgiler', color: lightColor)),
              Tab(child: CustomText(text: 'Diğer Bilgiler', color: lightColor)),
              Tab(child: CustomText(text: 'İzin', color: lightColor)),
              Tab(child: CustomText(text: 'Ödemeler', color: lightColor)),
              Tab(child: CustomText(text: 'Mesai', color: lightColor)),
              Tab(child: CustomText(text: 'Bodro', color: lightColor)),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: "Diğer", color: lightColor),
                    const Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TabBarView(
                children: [
                  TabGenel(
                    user: user,
                    userHelper: userHelper,
                  ),
                  ResponsiveWidget(
                    largeScreen: TabKariyer(
                      userHelper: userHelper,
                    ),
                    smallScreen: TabKariyerSmall(),
                  ),
                  ResponsiveWidget(
                    largeScreen: TabPersonalInformation(
                      userHelper: userHelper,
                    ),
                    smallScreen: TabPersonalInformationSmall(),
                  ),
                  TabAnotherInformation(
                    user: user,
                    userHelper: userHelper,
                  ),
                  const Center(child: CustomText(text: "4")),
                  const Center(child: CustomText(text: "5")),
                  const Center(child: CustomText(text: "6")),
                  const Center(child: CustomText(text: "7")),
                  const Center(child: CustomText(text: "8")),
                ],
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              height: 50,
              child: Container(
                color: lightColor,
                child: Row(
                  children: [
                    Visibility(
                      visible: ResponsiveWidget.isSmallScreen(context)
                          ? false
                          : true,
                      child: const Expanded(
                        flex: 3,
                        child: Text(""),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => Visibility(
                          visible: isSaved.value,
                          child: Row(
                            children: const [
                              Icon(Icons.done),
                              Text(' Kaydedildi!'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        title: 'Kaydet',
                        pressAction: () {
                          isSaved.value = true;
                          return userHelper.userDetailSave(context, user);
                        },
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        title: 'İptal',
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        pressAction: () => Get.offAllNamed(rootRoute),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
