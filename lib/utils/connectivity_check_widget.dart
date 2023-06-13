import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uide/ui/provider/connectivity_provider.dart';
import 'package:uide/ui/provider/project_provider.dart';
import 'package:uide/utils/connection_none_screen.dart';
import 'package:uide/utils/waiting_screen.dart';

class ConnectivityCheckWidget extends StatefulWidget {
  final Widget? connectedWidget;
  final ProjectNotifierProvider? projectNotifierProvider;

  const ConnectivityCheckWidget({
    Key? key,
    this.connectedWidget,
    this.projectNotifierProvider,
  }) : super(key: key);

  @override
  State<ConnectivityCheckWidget> createState() =>
      ConnectivityCheckWidgetState();
}

class ConnectivityCheckWidgetState extends State<ConnectivityCheckWidget> {
  bool retrying = false;
  late Future<ConnectivityResult> connectivityFuture;

  @override
  void initState() {
    super.initState();
    connectivityFuture = Future.value(ConnectivityResult.none);
    retrieveConnectivity();
  }

  Future<void> retrieveConnectivity() async {
    final connectivityProvider =
        Provider.of<ConnectivityProvider>(context, listen: false);
    connectivityFuture = connectivityProvider.fetchConnectivityResult();
  }

  Future<void> retryConnectivity() async {
    if (mounted) {
      setState(() {
        retrying = true;
      });
    }
    final connectivityProvider =
        Provider.of<ConnectivityProvider>(context, listen: false);
    connectivityFuture = connectivityProvider.fetchConnectivityResult();
    setState(() {
      retrying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ConnectivityResult>(
      future: connectivityFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ConnectionWaitingScreen();
        } else if (snapshot.hasData) {
          final connectivityResult = snapshot.data!;
          if (connectivityResult == ConnectivityResult.none) {
            return ConnectionNoneScreen(onRetry: retryConnectivity);
          }
          return widget.projectNotifierProvider ??
              widget.connectedWidget ??
              const SizedBox();
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
