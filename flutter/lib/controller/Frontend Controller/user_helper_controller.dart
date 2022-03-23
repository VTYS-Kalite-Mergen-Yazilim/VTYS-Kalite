// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:vtys_kalite/enums/bank_account_type.dart';
import 'package:vtys_kalite/enums/bank_names.dart';
import 'package:vtys_kalite/enums/blood_type.dart';
import 'package:vtys_kalite/enums/contract_type.dart';
import 'package:vtys_kalite/enums/disabled_degree.dart';
import 'package:vtys_kalite/enums/educational_status.dart';
import 'package:vtys_kalite/enums/employment_type.dart';
import 'package:vtys_kalite/enums/gender.dart';
import 'package:vtys_kalite/enums/highest_education_level_completed.dart';
import 'package:vtys_kalite/enums/marial_status.dart';
import 'package:vtys_kalite/enums/military_status.dart';
import 'package:vtys_kalite/enums/payment_scheme.dart';
import 'package:vtys_kalite/enums/salary_type.dart';
import 'package:vtys_kalite/models/User%20Detail/user_career.dart';
import 'package:vtys_kalite/models/User%20Detail/user_detail.dart';
import 'package:vtys_kalite/models/User%20Detail/user_payment.dart';
import 'package:vtys_kalite/models/user.dart';
import 'package:vtys_kalite/utilities/controllers.dart';

class UserHelperController {
  int userId;
  UserDetail? userDetail;
  UserDetailCareer? userDetailCareer;
  UserDetailPayment? userDetailPayment;

  Future<void> init() async {
    print("UserHelperController init : $userId");
    if (userId != -1) {
      userDetail = await userDetailController.fetchUserDetailByUserId(userId);
    } /* else { */
    userDetail ??= UserDetail(
      userId: userId,
      tcno: (int.tryParse(userDetailController.userDetailList.isNotEmpty
                  ? userDetailController.userDetailList.last.tcno
                  : "0") ??
              0 + 1)
          .toString(),
    );

    userDetailCareer = UserDetailCareer(userDetailId: userDetail!.id);
    userDetailPayment = UserDetailPayment(
      userDetailId: userDetail!.id,
      paymentScheme: PaymentSchemeEnum.values.first,
      salaryType: SalaryTypeEnum.values.first,
    );
    /* } */
  }

  UserHelperController(this.userId);

  UserDetail getUserDetail() {
    return UserDetail(
      userId: userId,
      numberofkids:
          int.parse(tabKisiselBilgilerController.controllerNumberOfKids.text),
      tcno: tabKisiselBilgilerController.controllerTcNo.text,
      workPhone: tabGenelController.controllerWorkPhone.text,
      lastCompletedEducationStatus: tabKisiselBilgilerController
          .controllerLastCompletedEducationStatus.text,
      dateofbirth: userDetail!.dateofbirth,
      startDateWork: userDetail!.startDateWork,
      contractEndDate: userDetail!.contractEndDate,
      quitWorkDate: userDetail!.contractEndDate,
      workEmail: tabGenelController.controllerEPostaWork.value.text,
      address: tabDigerBilgilerController.controllerAdress.text,
      addressCountry: tabDigerBilgilerController.controllerCountry.text,
      addressDistrict: tabDigerBilgilerController.controllerDistrict.text,
      addressCity: tabDigerBilgilerController.controllerCity.text,
      addressZipCode: tabDigerBilgilerController.controllerZipCode.text,
      homePhone: tabDigerBilgilerController.controllerHomePhone.text,
      bankAccountNumber:
          tabDigerBilgilerController.controllerAccountNumber.text,
      iban: tabDigerBilgilerController.controllerIBAN.text,
      emergencyContactPerson: "",
      relationshipEmergencyContact: "",
      emergencyContactCellPhone: "",
      reasonTypeForQuit: "",
      quitExplanation: "",
      nationality: tabKisiselBilgilerController.controllerNationality.text,
      gender: GenderEnum.values.elementAt(userDetail!.gender.index),
      bloodType: BloodTypeEnum.values.elementAt(userDetail!.bloodType.index),
      bankNames: BankNamesEnum.values.elementAt(userDetail!.bankNames.index),
      contractType:
          ContractTypeEnum.values.elementAt(userDetail!.contractType.index),
      maritalStatus:
          MaritalStatusEnum.values.elementAt(userDetail!.maritalStatus.index),
      disabledDegree:
          DisabledDegreeEnum.values.elementAt(userDetail!.disabledDegree.index),
      militaryStatus:
          MilitaryStatusEnum.values.elementAt(userDetail!.employmentType.index),
      employmentType:
          EmploymentTypeEnum.values.elementAt(userDetail!.employmentType.index),
      bankAccountType: BankAccountTypeEnum.values
          .elementAt(userDetail!.bankAccountType.index),
      educationalStatus: EducationalStatusEnum.values
          .elementAt(userDetail!.educationalStatus.index),
      highestEducationLevelCompleted: HighestEducationLevelCompletedEnum.values
          .elementAt(userDetail!.highestEducationLevelCompleted.index),
    );
  }

  userDetailSave(BuildContext context, User? user) async {
    try {
      if (userId == -1) {
        await userController.addNewUser(
          newUser: User(
            name: tabGenelController.controllerName.text +
                (tabGenelController.controllerSurname.text == ""
                    ? (" " + tabGenelController.controllerSurname.text)
                    : ""),
            email: tabGenelController.controllerEPostaPersonal.text,
            password: "qwe123",
            title: "management",
            cellphone: tabGenelController.controllerTelephonePersonal.text,
          ),
          tcNo: tabKisiselBilgilerController.controllerTcNo.text,
          userDetail: getUserDetail(),
        );
        /* userId = await userController.fetchUserByEmailAndPassword(
            tabGenelController.controllerEPostaPersonal.text, "qwe123"); */
      } else {
        userController.updateUser(
          id: user!.id,
          user: User(
            name: tabGenelController.controllerName.text +
                (tabGenelController.controllerSurname.text == ""
                    ? (" " + tabGenelController.controllerSurname.text)
                    : ""),
            email: tabGenelController.controllerEPostaPersonal.text,
            password: user.password,
            title: user.title,
            cellphone: tabGenelController.controllerTelephonePersonal.text,
          ),
          userDetail: getUserDetail(),
        );
        /* userId = user.id; */
      }

      userDetail = await userDetailController.fetchUserDetailByUserId(userId);
      print(userDetail == null ? "UserDetail not found" : "UserDetail : found");

      UserDetailCareer? userDetailCareer = await userDetailCareerController
          .fetchUserDetailCareerById(userDetail?.id);

      print("User Helper User UserDetailCareer " +
          (userDetailCareer == null
              ? "not found"
              : "found ID: ${userDetailCareer.id}"));

      int? responseUserDetailCareer;
      if ((userDetailCareer == null)) {
        responseUserDetailCareer =
            await userDetailCareerController.addNewUserDetailCareer(
          userDetail!.id,
          UserDetailCareer(
            userDetailId: userDetail!.id,
            managerName: tabKariyerController.positionYoneticisi.text,
            managerTcno: "12345678910", //TODO
            unitCompany: optionalCompanyController.companyName.value,
            unitBranch: optionalCompanyController.branchName.value,
            unitDepartment: optionalCompanyController.departmanName.value,
            unitTitle: optionalCompanyController.titleName.value,
          ),
        );
      } else {
        responseUserDetailCareer = await userDetailCareerController
            .updateUserDetailCareer(userDetail!.id, userDetailCareer);
      }

      /*int? responseUserDetailPayment =

          ///TODO: update kaldı
          await userDetailPaymentController.addNewUserDetailPayment(
        userDetail!.id,
        UserDetailPayment(
          userDetailId: userDetail!.id,
          tcno: tabKisiselBilgilerController.controllerTcNo.text,
          salary: tabKariyerController.controllerSalary.text,
          currency: "TL", //TODO
          salaryType: SalaryTypeEnum.values
              .elementAt(userDetailPayment!.salaryType.index),
          paymentScheme: PaymentSchemeEnum.values
              .elementAt(userDetailPayment!.paymentScheme.index),
          commuteSupportFee: "617", //TODO
          foodSupportFee: "6299", //TODO
        ),
      );

      showDialogResponseCheck(
        responseUserDetail!,
        responseUserDetailCareer!,
        responseUserDetailPayment!,
        context,
      ); */

    } catch (e) {
      print(e.toString());
    }
  }

  zeroToAllController() {
    tabGenelController.controllerName.text = "";
    tabGenelController.controllerSurname.text = "";
    tabGenelController.controllerEPostaWork.text = "";
    tabGenelController.controllerEPostaPersonal.text = "";
    tabGenelController.controllerWorkPhone.text = "";
    tabGenelController.controllerTelephonePersonal.text = "";
    tabGenelController.controllerAccessType.text = "";
    tabGenelController.controllerContractEndDate.text = "";
    userDetail!.contractType = ContractTypeEnum.none;
    userDetail!.employmentType = EmploymentTypeEnum.none;
    userDetail!.startDateWork = dateTimeFormat.format(DateTime.now());
    userDetail!.contractEndDate = dateTimeFormat.format(DateTime.now());

    tabDigerBilgilerController.controllerAdress.text = "";
    tabDigerBilgilerController.controllerHomePhone.text = "";
    tabDigerBilgilerController.controllerCountry.text = "";
    tabDigerBilgilerController.controllerCity.text = "";
    tabDigerBilgilerController.controllerZipCode.text = "";
    tabDigerBilgilerController.controllerDistrict.text = "";
    tabDigerBilgilerController.controllerAccountNumber.text = "";
    tabDigerBilgilerController.controllerIBAN.text = "";
    userDetail!.bankNames = BankNamesEnum.none;
    userDetail!.bankAccountType = BankAccountTypeEnum.none;

    userDetailCareer!.unitCompany = "";
    userDetailCareer!.unitBranch = "";
    userDetailCareer!.unitDepartment = "";
    userDetailCareer!.unitTitle = "";
    tabKariyerController.positionUnvan.text = "";
    tabKariyerController.positionYoneticisi.text = "";
    tabKariyerController.controllerSalary.text = "";
    tabKariyerController.controllerUnit.text = "";
    tabKariyerController.controllerPaymentScreenInSalary.text = "";

    userDetail!.dateofbirth = dateTimeFormat.format(DateTime.now());
    tabKisiselBilgilerController.controllerTcNo.text = "";
    tabKisiselBilgilerController.controllerNationality.text = "";
    tabKisiselBilgilerController.controllerNumberOfKids.text = "";
    tabKisiselBilgilerController.controllerLastCompletedEducationStatus.text =
        "";
    userDetail!.nationality = "";
    userDetail!.maritalStatus = MaritalStatusEnum.none;
    userDetail!.gender = GenderEnum.none;
    userDetail!.disabledDegree = DisabledDegreeEnum.none;
    userDetail!.bloodType = BloodTypeEnum.none;
    userDetail!.educationalStatus = EducationalStatusEnum.none;
    userDetail!.highestEducationLevelCompleted =
        HighestEducationLevelCompletedEnum.none;
    userDetail!.militaryStatus = MilitaryStatusEnum.none;
  }
}
