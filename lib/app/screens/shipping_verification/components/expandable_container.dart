import 'package:flutter/material.dart';

class ExpandableCardContainer extends StatefulWidget {
  final bool isExpanded;
  final Widget collapsedChild;
  final Widget expandedChild;

  const ExpandableCardContainer(
      {Key? key, required this.isExpanded, required this.collapsedChild, required this.expandedChild})
      : super(key: key);

  @override
  _ExpandableCardContainerState createState() =>
      _ExpandableCardContainerState();
}

class _ExpandableCardContainerState extends State<ExpandableCardContainer> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
      child: widget.isExpanded ? widget.expandedChild : widget.collapsedChild,
    );
  }
}

// class ShowExpansion extends StatelessWidget {
//
//   const ShowExpansion({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return  Column(
//       children: [
//         ExpandableCardContainer(
//           collapsedChild: Container(child: Text("bruhhh")),
//           expandedChild: Container(child: Text("Bruuuhhhhh"),height: 200, width: 400,),
//           isExpanded: isExpanded,
//         ),
//       ],
//     );
//   }
// }

