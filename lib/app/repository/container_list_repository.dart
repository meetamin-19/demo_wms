import 'package:demo_win_wms/app/data/datasource/container_list_data.dart';
import 'package:demo_win_wms/app/data/entity/req/req_container_list.dart';
import 'package:demo_win_wms/app/data/entity/res/empty_res.dart';
import 'package:demo_win_wms/app/data/entity/res/res_container_link_location.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_container_list.dart';

class ContainerListRepository {

  final ContainerListData dataSource;

  ContainerListRepository({required this.dataSource});

  Future<ResGetContainerList> getContainerList(
      {required ReqGetContainerList req}) async {
    return await dataSource.getContainerList(req: req);
  }

  Future<ResContainerLinkLocation> getContainerLinkLocationList(
      {required int id}) async {
    return await dataSource.getContainerLinkLocationList(id: id);
  }

  Future<EmptyRes> deleteContainer({required int containerID, required String updateLog}) async {
    return dataSource.deleteContainer(containerID : containerID, updateLog: updateLog);
  }




}