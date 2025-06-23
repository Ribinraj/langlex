import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/core/responsive_utils.dart';
import 'package:langlex/presentation/blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:langlex/presentation/widgets/custom_squre_elevatedbutton.dart';

class ConnectivityAwareWidget extends StatefulWidget {
  final Widget child;

  const ConnectivityAwareWidget({super.key, required this.child});

  @override
  // ignore: library_private_types_in_public_api
  _ConnectivityAwareWidgetState createState() =>
      _ConnectivityAwareWidgetState();
}

class _ConnectivityAwareWidgetState extends State<ConnectivityAwareWidget> {
  Key _contentKey = UniqueKey();

  void _reloadContent() {
    setState(() {
      _contentKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConnectivityBloc, ConnectivityState>(
      listener: (context, state) {
        if (state is ConnectivityRestored) {
          _reloadContent();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Connection restored: ${_getConnectionTypes(state.results)}')),
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            KeyedSubtree(
              key: _contentKey,
              child: widget.child,
            ),
            if (state is ConnectivityFailure) const NoNetworkOverlay(),
          ],
        );
      },
    );
  }

  String _getConnectionTypes(List<ConnectivityResult> results) {
    return results
        .map((result) => result.toString().split('.').last)
        .join(', ');
  }
}

class NoNetworkOverlay extends StatelessWidget {
  const NoNetworkOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 150),
          child: Column(
            children: [
              Container(
                height: ResponsiveUtils.hp(25),
                width: ResponsiveUtils.wp(65),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/13766137_5356680.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // SizedBox(
              //   height: 150,
              //   child: Lottie.asset(
              //     'assets/images/Animation - 1728979722770.json',
              //   ),
              // ),
              ResponsiveSizedBox.height30,
              TextStyles.headline(text: 'Ooops!', color: Appcolors.kredcolor),
              ResponsiveSizedBox.height20,
              TextStyles.body(
                text: 'No internet connection found \ncheck your connection',
              ),
              SizedBox(
                height: ResponsiveUtils.hp(7),
              ),
              CustomSqureElevatedButton(
                onPressed: () {},
                buttonText: 'Retry',
                backgroundcolor: Appcolors.kprimarycolor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
