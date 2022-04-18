import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:demo_win_wms/app/utils/responsive.dart';

class DatePickView extends StatefulWidget {
   DatePickView(
      {Key? key,
      required this.title,
      required this.selectedDate,
      this.passedDate,
      this.minDate,
      this.maxDate,
      this.showBorder})
      : super(key: key);

  bool? showBorder = false;

  final String title;

  final Function(DateTime) selectedDate;

  final DateTime? passedDate;

  final DateTime? minDate;

  final DateTime? maxDate;

  @override
  _DatePickViewState createState() => _DatePickViewState();
}

class _DatePickViewState extends State<DatePickView> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        currentDate: widget.passedDate,
        context: context,
        initialDate: widget.passedDate ?? DateTime.now(),
        firstDate: widget.maxDate ?? DateTime(1900, 0),
        lastDate: widget.minDate ?? DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.selectedDate(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    final _size = MediaQuery.of(context).size;

    final width = isMobile ? _size.width / 2.8 : kFlexibleSize(190);

    return InkWell(
      onTap: () {
        _selectDate(context);
      },
      child: Container(
          width: width,
          //isMobile ? kFlexibleSize(120) : kFlexibleSize(288),
          height: 44,
          margin: EdgeInsets.only(
              right: kFlexibleSize(10), bottom: kFlexibleSize(10)),
          decoration: BoxDecoration(
              border: widget.showBorder == true
                  ? Border.all(color: Colors.black.withOpacity(0.1))
                  : Border.all(color: Colors.transparent),
              color: Colors.white,
              borderRadius: BorderRadius.circular(2)),
          padding: EdgeInsets.symmetric(
              vertical: kFlexibleSize(5), horizontal: kFlexibleSize(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                        child: kImgDateIcon,
                        height: kFlexibleSize(20),
                        width: kFlexibleSize(20)),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(widget.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: widget.passedDate == null
                                  ? Colors.black54
                                  : Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400)),
                    ),
                  ],
                ),
              ),
              // const Icon(
              //   Icons.arrow_drop_down,
              //   color: Colors.black,
              //   size: 30,
              // ),
            ],
          )),
    );
  }
}
