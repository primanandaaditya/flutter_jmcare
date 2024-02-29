
import 'package:flutter/material.dart';
class PaginationuserState{

  int halaman = 1;
  ScrollController? scrollController;
  double maxScroll=0;
  double currentScroll=0;
  PageStorageKey? pageStorageKey;
  TextEditingController? tecSearch;

  PaginationuserState(){
    halaman = 1;
    scrollController = ScrollController();
    pageStorageKey = const PageStorageKey(0);
    tecSearch = TextEditingController();
  }
}