import 'package:flutter/material.dart';
import 'package:vtys_kalite/componenets/custom_text.dart';
import 'package:vtys_kalite/main.dart';
import 'package:vtys_kalite/models/activity.dart';
import 'package:vtys_kalite/screens/ActivityForm/activity_evaluation_page.dart';
import 'package:vtys_kalite/utilities/controllers.dart';
import 'package:vtys_kalite/utilities/style.dart';

class ActivityCard extends StatefulWidget {
  final Activity activity;
  var activityEvaluationId = -1;

  ActivityCard({
    Key? key,
    required this.activity,
  }) : super(key: key);

  checkAnswer() async {
    activityEvaluationId = await activityEvaluationController
        .fetchActivityEvaluation(activity.id, user.id);
  }

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  @override
  void initState() {
    widget.checkAnswer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {    
    return InkWell(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 5,
                  width: 300,
                  decoration: BoxDecoration(
                    color: widget.activityEvaluationId != -1
                        ? Colors.greenAccent
                        : Colors.redAccent,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Expanded(flex: 1, child: Text("")),
                      const Icon(
                        Icons.calendar_today_outlined,
                        size: 12,
                      ),
                      CustomText(
                        text: "  " + widget.activity.datetime,
                        size: 12,
                      ),
                    ],
                  ),
                ),
                const Expanded(flex: 1, child: Text("")),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: CustomText(
                    text: widget.activity.name,
                    size: 24,
                    weight: FontWeight.w400,
                  ),
                ),
                const Expanded(flex: 1, child: Text("")),
                CustomText(
                  text: widget.activity.organizator,
                ),
                const Expanded(flex: 1, child: Text("")),
              ],
            ),
            Positioned(
              right: 5,
              bottom: 5,
              height: 24,
              width: 24,
              child: InkWell(
                child: const Center(
                  child: Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                    size: 22,
                  ),
                ),
                onTap: () {
                  setState(() {
                    activityController.deleteActivity(
                        widget.activity.name, widget.activity.organizator);
                  });
                },
              ),
            ),
          ],
        ),
      ),
      onTap: widget.activityEvaluationId == -1
          ? () async {
              await showDialog(
                context: context,
                builder: (context) => Dialog(
                  backgroundColor: lightColor,
                  child: ActivityEvaluationPage(
                    activity: widget.activity,
                    onSave: widget.checkAnswer(),
                  ),
                ),
              );
            }
          : null,
    );
  }
}
