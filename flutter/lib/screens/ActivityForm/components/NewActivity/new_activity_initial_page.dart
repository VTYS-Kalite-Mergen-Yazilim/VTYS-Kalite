import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtys_kalite/componenets/custom_text_box.dart';
import 'package:vtys_kalite/utilities/constans.dart';

import '../../new_activity_page.dart';
import 'new_activity_next_button.dart';

class NewActivityInitialPage extends StatefulWidget {
  const NewActivityInitialPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PageController controller;

  @override
  State<NewActivityInitialPage> createState() => _NewActivityInitialPageState();
}

class _NewActivityInitialPageState extends State<NewActivityInitialPage> {
  final newActivityKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 8,
          child: Form(
            key: newActivityKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildTextBox(
                      NewActivityPage.nameController, 'Name', 'Name'),
                  buildTextBox(
                      NewActivityPage.placeController, 'Place', 'Place'),
                  buildDatePicker(NewActivityPage.dateTimeController),
                  buildTextBox(NewActivityPage.organizatorController,
                      'Organizer', 'Organizer'),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              const Expanded(flex: 1, child: Text("")),
              const Expanded(flex: 1, child: Text("")),
              Expanded(
                flex: 1,
                child: NewActivityNextButton(controller: widget.controller),
              ),
            ],
          ),
        )
      ],
    );
  }

  CustomTextBox buildTextBox(
      TextEditingController controller, String title, String hint) {
    return CustomTextBox(
      controller: controller,
      title: title,
      hint: hint,
      validator: (val) {
        if (val!.isEmpty) {
          return "Cannot Be Blank";
        } else {
          return null;
        }
      },
    );
  }

  Column buildDatePicker(TextEditingController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Date", style: kLabelStyle),
        const SizedBox(height: 10),
        DateTimePicker(
          type: DateTimePickerType.dateTime,
          initialDate: NewActivityPage.date,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          decoration: InputDecoration(
            labelText: "Date - Time",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onChanged: (value) {
            if(value.isNotEmpty){
              setState(() {
                NewActivityPage.date = value as DateTime;
              });
            }
          },
        ),
      ],
    );
  }
}
