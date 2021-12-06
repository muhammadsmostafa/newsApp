import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit,NewsState>(
      listener: (context,state){},
      builder: (context,state){
        var list = NewsCubit.get(context).business;
        return ScreenTypeLayout(
            mobile: Builder(
              builder: (context) {
                NewsCubit.get(context).setDesktop(false);
                return articleBuilder(list,context);
              }
            ),
            desktop: Builder(
              builder: (context) {
                NewsCubit.get(context).setDesktop(true);
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    Expanded(
                      child: Container(
                          child: articleBuilder(list,context)
                      ),
                    ),
                    if(list.isNotEmpty)
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            '${list[NewsCubit.get(context).selectedItem]['description']}',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      )
                    )
                  ],
                );
              }
            ),
          breakpoints: const ScreenBreakpoints(
            desktop: 600,
            tablet: 600,
            watch: 100,
          ),
        );
      },
    );
  }
}
