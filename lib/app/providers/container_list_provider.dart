
import 'package:demo_win_wms/app/data/entity/req/req_container_list.dart';
import 'package:demo_win_wms/app/data/entity/res/empty_res.dart';
import 'package:demo_win_wms/app/data/entity/res/res_container_link_location.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_container_list.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_container_list_filter.dart';
import 'package:demo_win_wms/app/providers/base_notifier.dart';
import 'package:demo_win_wms/app/repository/container_list_repository.dart';
import 'package:demo_win_wms/app/utils/api_response.dart';

class ContainerListProvider extends BaseNotifier {
  final ContainerListRepository repo;


  ApiResponse<ResGetContainerList>? _GetContainerList;

  List<ResGetContainerListData>? containerList;

  ApiResponse<ResGetContainerList>? get getContainerList =>
      _GetContainerList;

  ApiResponse<ResContainerLinkLocation>? _linkLocationList;

  ApiResponse<ResContainerLinkLocation>? get linkLocationList => _linkLocationList;

  ApiResponse<EmptyRes>? _deleteContainer;

  ApiResponse<EmptyRes>? get deleteContainer => _deleteContainer;


  ContainerListProvider({required this.repo}) {
    _GetContainerList = ApiResponse();
    _linkLocationList = ApiResponse();
    _deleteContainer = ApiResponse();

  }

  List<ResGetContainerListData>? filteredContainerListData;

  List<ResContainerLinkLocationData>? filteredLocationList;


  //
  searchFromfilteredContainerList({required String str}){

    filteredContainerListData =[];

    final searchString = str.toLowerCase();

    if(searchString.replaceAll(' ', '').isEmpty){
      filteredContainerListData = _GetContainerList?.data?.data;
      notifyListeners();
    }else{
      filteredContainerListData = _GetContainerList?.data?.data?.where((element) {
        final doesContains = (element.containerCode ?? '').toLowerCase().contains(searchString)
            || (element.receivingTypeTerm ?? '').toLowerCase().contains(searchString)
            || (element.containerName ?? '').toLowerCase().contains(searchString)
            || (element.warehouseName ?? 0).toString().toLowerCase().contains(searchString)
            || (element.etaDate ?? 0).toString().toLowerCase().contains(searchString)
            || (element.statusTerm ?? 0).toString().toLowerCase().contains(searchString)
            || (element.receivedDateStr ?? 0).toString().toLowerCase().contains(searchString)
            || (element.completedDateStr ?? 0).toString().toLowerCase().contains(searchString)
            || (element.containerPartCount ?? 0).toString().toLowerCase().contains(searchString);
        return doesContains;
      }).toList();
      notifyListeners();
    }

  }

  Future getContainerListData(
      {String? listStartAt,
        String? numOfResults,
        int? sortCol,
        Warehouselist? warehouse,
        DateTime? startDate,
        String? containerStatus,
        String? receivingType}) async {
    try {
      apiResIsLoading(_GetContainerList!);

      final res = await repo.getContainerList(
          req: ReqGetContainerList(
            start: listStartAt,
            length: numOfResults,
            warehouseId: warehouse?.value ?? '0',
            receivingtypeStr: receivingType ?? '',
              fromEtaDate: startDate,
            statusStr: containerStatus ?? '',
            sortcol: sortCol ?? 0
          ));
      if (res.success == true) {
        if (res.data != null) {
          containerList = [];
          containerList?.addAll(res.data!);
        }
        apiResIsSuccess<ResGetContainerList>(
            _GetContainerList!, res);
      } else {
        throw res.message ?? "Something Went Wrong";
      }
    } catch (e) {
      print(e);
      apiResIsFailed(_GetContainerList!, e);
      rethrow;
    }
  }

  Future getContainerLinkLocationList({required int id}) async {
    try {
      apiResIsLoading(_linkLocationList!);

      final res = await repo.getContainerLinkLocationList(id: id);

      if (res.success == true) {
        apiResIsSuccess<ResContainerLinkLocation>(_linkLocationList!, res);
      } else {
        throw res.message ?? "Something Went Wrong";
      }
    } catch (e) {
      apiResIsFailed(_linkLocationList!, e);
      rethrow;
    }
  }

  Future deleteEmptyContainer({int? containerId, String? updatelog }) async {
    try {
      apiResIsLoading(_deleteContainer!);

      final res = await repo.deleteContainer(containerID:  containerId ?? 0 , updateLog: updatelog ?? '');

      if (res.success == false) {
        apiResIsFailed(_deleteContainer!, res.message ?? '');
       }
        else {
        apiResIsSuccess<EmptyRes>(_deleteContainer!, res);
        getContainerListData();

      }
    } catch (e) {
      apiResIsFailed(_deleteContainer!, e );
      rethrow;
      }
  }

}