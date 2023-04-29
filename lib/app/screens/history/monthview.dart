// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:medibot/app/widgets/background_screen_decoration.dart';
// import 'package:medibot/app/widgets/box_field.dart';
// import 'package:table_calendar/table_calendar.dart';

// import '../../widgets/text_field.dart';

// class MonthView extends StatelessWidget {
//   MonthView({Key? key}) : super(key: key);
//   final CalendarController _controller = CalendarController();
//   @override
//   Widget build(BuildContext context) {
//     return ScreenDecoration(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CustomTextField(
//                   text: "History",
//                   fontFamily: 'Sansation',
//                   size: 23.sp,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.black,
//                 ),
//                 CustomTextField(
//                     color: Colors.black,
//                     size: 18.sp,
//                     fontWeight: FontWeight.w700,
//                     text: "Month View - March")
//               ]),
//           Container(
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TableCalendar(
//                     calendarController: _controller,
//                     initialCalendarFormat: CalendarFormat.month,
//                     headerVisible: false,
//                     calendarStyle: const CalendarStyle(
//                       todayColor: Colors.blue,
//                       selectedColor: Colors.green,
//                     ),
//                     startingDayOfWeek: StartingDayOfWeek.sunday,
//                     onDaySelected: (date, events, holidays) {
//                       print(date.toUtc());
//                     },
//                     builders: CalendarBuilders(
//                       dayBuilder: ((context, date, events) {
//                         return Container(
//                           margin: EdgeInsets.all(5.0),
//                           alignment: Alignment.bottomRight,
//                           decoration: BoxDecoration(
//                             color: Theme.of(context).colorScheme.primary,

//                             //borderRadius: BorderRadius.circular(8.r)
//                           ),
//                           child: Text(

//                             date.day.toString(),
//                             style: const TextStyle(
//                               color: Colors.black,
//                             ),
//                           ),
//                         );
//                       }),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           CustomBox(
//             boxHeight: 122.h, 
//             boxWidth: 320.w, 
//             body: Container(
//               margin: EdgeInsets.symmetric(vertical: 100.h, horizontal: 10.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
     
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
