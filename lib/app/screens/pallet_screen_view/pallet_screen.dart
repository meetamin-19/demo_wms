import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo_win_wms/app/providers/pallet_provider.dart';
import 'package:demo_win_wms/app/screens/base_components/common_app_bar.dart';
import 'package:demo_win_wms/app/screens/base_components/common_theme_container.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:demo_win_wms/app/utils/enums.dart';
import 'package:demo_win_wms/app/views/loading_small.dart';
import 'package:demo_win_wms/app/views/no_data_found.dart';
import 'components/pallet_view_list.dart';

class PalletScreenView extends StatelessWidget {
  const PalletScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CommonAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: CommonThemeContainer(title: 'Pick Order',child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: kBorderColor)
                ),
                child: itemStock(context),
              ),
              SizedBox(height: 10),
              pallets(context),
              ],
          ),),
        ),
      ),
    );
  }

  Widget pallets(BuildContext context) {

    final provider = context.watch<PalletProviderImpl>();

    final isLoading = provider.palletsRes?.state == Status.LOADING;

    if (isLoading) {
      return LoadingSmall();
    }

    final hasError = provider.palletsRes?.state == Status.ERROR;

    if (hasError) {
      return NoDataFoundView(title: 'No Pallets Found',);
    }

    final data = provider.palletsRes?.data?.data?.pickOrderPalletList;

    if(data == null){
      return NoDataFoundView(title: 'No Pallets Found',);
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {

        final res = data[index];

        return PalletViewList(title: '${res.palletNo ?? ''}',pallets: res,);
      },
    );
  }

  Widget itemStock(BuildContext context) {

    final pallet = context.watch<PalletProviderImpl>();

    Widget TableHeader(String text) => Text(text,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),textAlign: TextAlign.center,);

    Widget TableRow(String text) => Text(text,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),textAlign: TextAlign.center);

    Widget table(){

      final isLoading = pallet.lineItemRes?.state == Status.LOADING;

      if (isLoading){
        return LoadingSmall();
      }

      final hasError = pallet.lineItemRes?.state == Status.ERROR;

      if (hasError){
        return NoDataFoundView(retryCall: (){
          context.read<PalletProviderImpl>().pickOrderViewLineItem();
        },);
      }

      final data = pallet.lineItemRes?.data?.data?.itemLocationList;

      if (data == null){
        return NoDataFoundView(retryCall: (){
          context.read<PalletProviderImpl>().pickOrderViewLineItem();
        },);
      }

      return Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: kBorderColor)
            ),
            child: Row(
              children: [
                Expanded(child: TableHeader('location')),
                Expanded(child: TableHeader('Warehouse'),flex: 2,),
                Expanded(child: TableHeader('Company'),flex: 3,),
                Expanded(child: TableHeader('Type')),
                Expanded(child: TableHeader('Month')),
                Expanded(child: TableHeader('Year')),
                Expanded(child: TableHeader('Available Qty')),
                Expanded(child: TableHeader('Picked')),
                Expanded(child: TableHeader('Balance')),
              ],
            ),
          ),
          SizedBox(height: 5),

          ListView.builder(
            itemCount: data.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {

              final res = data[index];

            return Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: kBorderColor)
              ),
              child: Row(
                children: [
                  Expanded(child: TableRow('${res.locationName ?? '-'}')),
                  Expanded(child: TableRow('${res.warehouseName ?? '-'}'),flex: 2,),
                  Expanded(child: TableRow('${res.companyName ?? '-'}'),flex: 3,),
                  Expanded(child: TableRow('${res.locationType ?? '-'}')),
                  Expanded(child: TableRow('${res.monthName ?? '-'}')),
                  Expanded(child: TableRow('${res.year ?? 0}')),
                  Expanded(child: TableRow('${res.availableQty ?? 0}')),
                  Expanded(child: TableRow('Picked')),
                  Expanded(child: TableRow('Balance')),
                ],
              ),
            );
          },),

        ],
      );
    }

    return Column(
              children: [
                Container(
                  width: double.infinity,
                  color: kBorderColor,
                  padding: EdgeInsets.all(10),
                  child: Text('Item Stock',style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),),
                ),
                SizedBox(height: 6),

                table(),

                SizedBox(height: 20),
              ],
            );
  }

}


