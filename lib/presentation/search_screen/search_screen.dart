import 'package:flutter/material.dart';
import '../../core/app_export.dart';

/// Search/Find Opponents Screen
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tìm Đối Thủ',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 64,
              color: Color(0xFF8A8B8F),
            ),
            SizedBox(height: 16),
            Text(
              'Tìm Đối Thủ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Tìm kiếm và kết nối với đối thủ phù hợp',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF8A8B8F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
