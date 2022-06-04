//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(home: HomePage());
//   }
// }
//
// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     print('=> WoPage');
//     return BlocProvider<WoBloc>(
//       create: (context) => injector<WoBloc>()..add(const WoFetchListEvent()),
//       child: blocBuilder(context),
//     );
//   }
//
//   Widget blocBuilder(BuildContext context) {
//     return BlocBuilder<WoBloc, WoState>(
//       builder: (context, state) {
//         if (state is WoLoading) {
//           return const WoBody(isBusy: true);
//         }
//
//         if (state is WoLoaded) {
//           return WoBody(
//             woList: state.woList,
//           );
//         }
//
//         if (state is WoError) {
//           return ErrorPage(
//             messageError: state.errorMessage,
//             backPage: AppRoutes.workOrdersPage,
//           );
//         }
//
//         return const SizedBox();
//       },
//     );
//   }
//
// }
//
