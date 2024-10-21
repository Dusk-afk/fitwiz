import 'package:fitwiz/features/custom_scaffold/data/models/custom_app_bar_params.dart';
import 'package:fitwiz/features/custom_scaffold/presentation/widgets/custom_scaffold.dart';
import 'package:fitwiz/features/event/presentation/blocs/events_bloc/events_bloc.dart';
import 'package:fitwiz/features/event/presentation/widgets/events_horiz_list.dart';
import 'package:fitwiz/features/event/presentation/widgets/my_events_horiz_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarParams: const CustomAppBarParams(
        title: 'Home',
      ),
      child: CustomScrollView(
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              context.read<EventsBloc>().add(FetchEvents());
            },
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                24.verticalSpacingRadius,
                const MyEventsHorizList(),
                16.verticalSpacingRadius,
                const EventsHorizList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
