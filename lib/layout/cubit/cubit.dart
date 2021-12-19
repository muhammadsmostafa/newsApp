import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/business_screen.dart';
import 'package:news_app/modules/science_screen.dart';
import 'package:news_app/modules/sports_screen.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';


class NewsCubit extends Cubit<NewsState>
{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);


  int currentIndex =0;

  List<BottomNavigationBarItem> bottomItems=[
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
  ];

  void changeBottomNavBar(int index)
  {
    if(index==1){
      getSports();
    }
    if(index==2){
      getScience();
    }
    currentIndex=index;
    emit(NewsBottomNavState());
  }

  List<Widget> screens=[
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];

  List <dynamic> business =[];
  int selectedItem = 0;
  bool isDesktop = false;

  void setDesktop(bool value)
  {
    isDesktop=value;
    emit(NewsInitialState());
  }

  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country' : 'eg',
          'category' : 'business',
          'apiKey' : 'e81dd9364f7046a8895a7ecb2280094c',
        }
    ).then((value)
    {
      business =value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  void selectedBusinessItem(index)
  {
    selectedItem=index;
    emit(NewsInitialState());
  }

  List <dynamic> sports =[];
  void getSports()
  {
    emit(NewsGetSportsLoadingState());
    if(sports.isEmpty)
      {
        DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'country' : 'eg',
              'category' : 'sports',
              'apiKey' : 'e81dd9364f7046a8895a7ecb2280094c',
            }
        ).then((value)
        {
          sports =value.data['articles'];
          emit(NewsGetSportsSuccessState());
        }).catchError((error){
          emit(NewsGetSportsErrorState(error.toString()));
        });
      }
    else
      {
        emit(NewsGetSportsSuccessState());
      }
  }

  List <dynamic> science =[];

  void getScience()
  {
    if(science.isEmpty)
      {
        emit(NewsGetScienceLoadingState());
        DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'country' : 'eg',
              'category' : 'science',
              'apiKey' : 'e81dd9364f7046a8895a7ecb2280094c',
            }
        ).then((value)
        {
          science =value.data['articles'];
          emit(NewsGetScienceSuccessState());
        }).catchError((error){
          emit(NewsGetScienceErrorState(error.toString()));
        });
      }
    else
      {
        emit(NewsGetScienceSuccessState());
      }
  }

  List<dynamic> search =[];

  void getSearch(String value)
  {
    DioHelper.getData(
        url: 'v2/everything',
        query:
        {
          'q' : value,
          'apiKey' : 'e81dd9364f7046a8895a7ecb2280094c',
        }
    ).then((value)
    {
      search= value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}

