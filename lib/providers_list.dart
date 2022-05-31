import 'package:demo_win_wms/app/data/datasource/container_list_data.dart';
import 'package:demo_win_wms/app/providers/container_list_provider.dart';
import 'package:demo_win_wms/app/providers/service_provider.dart';
import 'package:demo_win_wms/app/data/datasource/auth_data.dart';
import 'package:demo_win_wms/app/data/datasource/pallet_data.dart';
import 'package:demo_win_wms/app/data/datasource/pick_order_data.dart';
import 'package:demo_win_wms/app/data/datasource/shipping_verification_data.dart';
import 'package:demo_win_wms/app/providers/pallet_provider.dart';
import 'package:demo_win_wms/app/providers/pick_order_provider.dart';
import 'package:demo_win_wms/app/providers/service_provider.dart';
import 'package:demo_win_wms/app/providers/shipping_verification_provider.dart';
import 'package:demo_win_wms/app/repository/auth_repository.dart';
import 'package:demo_win_wms/app/repository/container_list_repository.dart';
import 'package:demo_win_wms/app/repository/pallet_repository.dart';
import 'package:demo_win_wms/app/repository/pick_order_repository.dart';
import 'package:demo_win_wms/app/repository/shipping_verification_repository.dart';

import 'app/data/datasource/home_data.dart';
import 'app/data/datasource/service_data.dart';
import 'app/providers/auth_provider.dart';
import 'app/providers/home_provider.dart';
import 'app/repository/home_repo.dart';
import 'app/repository/service_repository.dart';

ServiceProviderImpl get serviceProvider =>
    ServiceProviderImpl(repo: ServiceRepository(dataSource: ServiceDataImpl()));

HomeProvider get homeProvider =>
    HomeProvider(repo: HomeRepository(dataSource: HomeDataImpl()),
        service: serviceProvider);

AuthProviderImpl get authProvider =>
    AuthProviderImpl(repo: AuthRepository(dataSource: AuthDataImpl()));

PickOrderProviderImpl get pickOrder =>
    PickOrderProviderImpl(
        repo: PickOrderRepository(dataSource: PickOrderDataImpl()));

PalletProviderImpl get palletProvider =>
    PalletProviderImpl(repo: PalletRepository(dataSource: PalletDataImpl()));

ShippingVerificationProvider get shippingverificationProvider =>
    ShippingVerificationProvider(repo: ShippingVerificationRepository(dataSource: ShippingVerificationDataImpl()));

ContainerListProvider get containerListProvider =>
    ContainerListProvider(repo: ContainerListRepository(dataSource: ContainerListDataImpl()));
