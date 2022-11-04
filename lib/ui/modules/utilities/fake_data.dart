import 'package:todoapp/state/models/category_model.dart';
import 'package:todoapp/state/models/task_model.dart';
import 'package:flutter/material.dart';

class FakeData {
  static final List<CategoryModel> categorise = [
    CategoryModel(
      id: '1',
      name: 'Danh mục 1',
      code: '123',
      color: Colors.deepOrange.value.toString(),
      description: 'Mô tả danh mục 1',
      imageUrl: icons[0]['path'],
      createdAt: DateTime.now().toString(),
    ),
    CategoryModel(
      id: '2',
      name: 'Danh mục 2',
      code: '124',
      color: Colors.green.value.toString(),
      description: 'Mô tả danh mục 2',
      imageUrl: icons[1]['path'],
      createdAt: DateTime.now().toString(),
    ),
    CategoryModel(
      id: '3',
      name: 'Danh mục 3',
      code: '125',
      color: Colors.yellow.value.toString(),
      description: 'Mô tả danh mục 3',
      imageUrl: icons[2]['path'],
      createdAt: DateTime.now().toString(),
    ),
  ];
  static final List<TaskModel> tasks = [
    TaskModel(
      id: '1',
      categoryId: '1',
      name: 'Công việc 1',
      star: 1,
      color: Colors.deepOrange.value.toString(),
      description: 'Mô tả công việc 1',
      imageUrl: icons[0]['path'],
      workingTime: '1800',
      createdAt: DateTime.now().toString(),
      isCompleted: true,
    ),
    TaskModel(
      id: '2',
      categoryId: '2',
      name: 'Công việc 2',
      star: 2,
      color: Colors.purple.value.toString(),
      description: 'Mô tả công việc 2',
      imageUrl: icons[4]['path'],
      workingTime: '3800',
      createdAt: DateTime.now().toString(),
      isCompleted: true,
    ),
    TaskModel(
      id: '3',
      categoryId: '2',
      name: 'Công việc 3',
      star: 2,
      color: Colors.blue.value.toString(),
      description: 'Mô tả công việc 3',
      imageUrl: icons[9]['path'],
      workingTime: '120',
      createdAt: DateTime.now().toString(),
      isCompleted: false,
    ),
  ];

  static final List<Map<String, dynamic>> tips = [
    {
      'id': 1,
      'name':
          'Dành thời gian tìm hiểu nhiều hơn về promodoro để cải thiện hiệu quả làm việc'
    },
    {
      'id': 2,
      'name': 'Không nên ngồi quá 45 phút, bạn cần thư giãn giữa giờ',
    },
    {
      'id': 3,
      'name': 'Tập trung cao độ giúp cải thiện hiệu quả làm việc',
    },
    {
      'id': 4,
      'name':
          'Các thể loại nhạc nên nghe: Nhạc sóng não Alpha, Baroque, Instrumental (Nhạc hòa tấu)',
    },
    {
      'id': 5,
      'name':
          'Luyện tập, rèn luyện cơ thể khỏe mạnh, đạt trạng thái tốt nhất khi học tập và làm việc',
    },
    {
      'id': 6,
      'name': 'Tạo một môi trường học tập trong lành',
    },
    {
      'id': 7,
      'name': 'Ưu tiên và tập trung vào những nhiệm vụ quan trọng trước',
    },
    {
      'id': 8,
      'name': 'Đặt mục tiêu phấn đấu cụ thể, rõ ràng',
    },
    {
      'id': 9,
      'name': 'Quản lý và tận dụng thời gian hợp lý',
    },
    {
      'id': 10,
      'name': 'Có phương pháp tổng hợp thông tin tiếp thu được',
    },
    {
      'id': 11,
      'name': 'Phân chia thời gian học hợp lý',
    },
    {
      'id': 12,
      'name': 'Ứng dụng kiến thức để thực hành',
    },
    {
      'id': 13,
      'name': 'Làm việc nhóm, luôn đặt câu hỏi và phản biện',
    },
    {
      'id': 14,
      'name': 'Có chiến lược học tập rõ ràng',
    },
    {
      'id': 15,
      'name': 'Đánh giá và ghi nhận kết quả đạt được',
    },
  ];

  static List<Map<String, dynamic>> icons = [
    {'name': 'always_on_top.png', 'path': 'assets/icons/always_on_top.png'},
    {'name': 'artist.png', 'path': 'assets/icons/artist.png'},
    {'name': 'backpack.png', 'path': 'assets/icons/backpack.png'},
    {'name': 'bed.png', 'path': 'assets/icons/bed.png'},
    {'name': 'cuisines.png', 'path': 'assets/icons/cuisines.png'},
    {'name': 'dresser.png', 'path': 'assets/icons/dresser.png'},
    {'name': 'drying_machine.png', 'path': 'assets/icons/drying_machine.png'},
    {'name': 'garbage_can.png', 'path': 'assets/icons/garbage_can.png'},
    {'name': 'gear.png', 'path': 'assets/icons/gear.png'},
    {'name': 'heart.png', 'path': 'assets/icons/heart.png'},
    {'name': 'lawn_mower.png', 'path': 'assets/icons/lawn_mower.png'},
    {'name': 'music_ringtones.png', 'path': 'assets/icons/music_ringtones.png'},
    {'name': 'photographer.png', 'path': 'assets/icons/photographer.png'},
    {'name': 'rice_cooker.png', 'path': 'assets/icons/rice_cooker.png'},
    {
      'name': 'service_electricity.png',
      'path': 'assets/icons/service_electricity.png'
    },
    {
      'name': 'service_waste_disposal.png',
      'path': 'assets/icons/service_waste_disposal.png'
    },
    {'name': 'shopping_cart.png', 'path': 'assets/icons/shopping_cart.png'},
    {'name': 'shower.png', 'path': 'assets/icons/shower.png'},
    {'name': 'study.png', 'path': 'assets/icons/study.png'},
    {'name': 'tea.png', 'path': 'assets/icons/tea.png'},
    {'name': 'theme.png', 'path': 'assets/icons/theme.png'},
  ];

  static List<Map<String, dynamic>> coverImages = [
    {"name": "cover_image_2.png", "path": "assets/images/cover_image_2.png"},
    {"name": "cover_image_3.png", "path": "assets/images/cover_image_3.png"},
    {"name": "cover_image_4.png", "path": "assets/images/cover_image_4.png"},
  ];
  //
}
