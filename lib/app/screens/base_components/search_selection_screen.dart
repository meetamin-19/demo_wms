import 'package:flutter/material.dart';

class SearchSelectionScreen extends StatefulWidget {
  SearchSelectionScreen({Key? key,required this.searchList, required this.selectedObject}) : super(key: key);

  final List<SearchModel> searchList;

  final Function(SearchModel)? selectedObject;

  @override
  _SearchSelectionScreenState createState() => _SearchSelectionScreenState();
}

class _SearchSelectionScreenState extends State<SearchSelectionScreen> {

  List<SearchModel> searchList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      searchList = widget.searchList;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(44)
          ),
          child: TextField(
            onChanged: (text){
              if(text.isEmpty){
                setState(() {
                  searchList = widget.searchList;
                });
                return;
              }else{
                setState(() {
                  searchList = widget.searchList.where((element) => (element.title ?? '').toLowerCase().contains(text.toLowerCase())).toList();
                });
              }
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search'
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: searchList.length,
        itemBuilder: (context, index) {

          return ListTile(
            title: Text('${searchList[index].title}',style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600
            ),),
            onTap: (){
              Navigator.of(context).pop();
              if (widget.selectedObject != null){
                widget.selectedObject!(searchList[index]);
              }
            },
          );

        },),
    );
  }
}

class SearchModel{
  int? id;
  String? title;

  SearchModel({this.id,this.title});

}

void callSearchList({required BuildContext context, required List<SearchModel> searchList, required Function(SearchModel)? selectedObject}){

  final searchScreen = SearchSelectionScreen(searchList: searchList, selectedObject: selectedObject);

  Navigator.of(context).push(MaterialPageRoute(builder: (context) => searchScreen,fullscreenDialog: true));

}