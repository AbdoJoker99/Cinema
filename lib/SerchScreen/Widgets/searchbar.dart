import 'package:cinema/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Searchbar extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearchChanged;

  Searchbar({required this.searchController, required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.titleMedium,
      controller: searchController,
      onChanged: (value) {
        onSearchChanged(value);
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: Colors.white),
        hintText: 'Search For Movie',
        hintStyle: TextStyle(color: AppColors.whiteColorText),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.whiteColorText),
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
          borderRadius: BorderRadius.circular(40.0),
        ),
        filled: true,
        fillColor: Colors.black,
        contentPadding:
            EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 20.0.w),
      ),
    );
  }
}
