// import '../../../state/models/task_model.dart';
// import '../../../state/models/category_model.dart';

class FakeData {
  static final List<Map<String, dynamic>> categories = [
    {
      "id": 1,
      "title": "Study",
      "color": "4294940672",
      "code": "001",
      "description": "Hoc an hoc noi hoc goi hoc mo"
    },
    {
      "id": 2,
      "title": "Eat",
      "code": "002",
      "color": "4278238420",
      "description": "An va ngu la dieu khong the thieu"
    },
    {
      "id": 3,
      "title": "Relax",
      "code": "003",
      "color": "4283215696",
      "description": "Thu gian hop ly giup tang cuong suc khoe"
    }
  ];

  static final List<Map<String, dynamic>> tips = [
    {'id': 1, 'name': 'Học không khó, chỉ khó ở bản thân mình'},
    {
      'id': 2,
      'name':
          'Học không khó, chỉ khó ở bản thân mình. Học không khó, chỉ khó ở bản thân mình.',
    },
    {
      'id': 3,
      'name':
          'Học không khó, chỉ khó ở bản thân mình. Học không khó, chỉ khó ở bản thân mình. Học không khó, chỉ khó ở bản thân mình',
    },
  ];

  static final List<Map<String, dynamic>> tasks = [
    {
      'id': 1,
      'categoryId': 1,
      'name': 'Học Lập Trình Flutter',
      "star": 3,
      "color": "4294940672",
      "description":
          "Flutter là một framework tuyệt vời để phát triển ứng dụng đa nền tảng",
      "imageUrl":
          "https://i.pinimg.com/564x/9d/84/09/9d8409f31712045b9741288acef0059e.jpg",
    },
    {
      'id': 2,
      'categoryId': 1,
      'name': 'Học NestJs',
      "star": 2,
      "color": "4294940503",
      "description": "NestJs là một framework tuyệt vời để phát triển server",
      "imageUrl":
          "https://i.pinimg.com/564x/c0/e3/9d/c0e39dd52919d4cac185f7c84a53fb17.jpg",
    },
    {
      'id': 2,
      'categoryId': 1,
      'name': 'Học PostgreSQL',
      "star": 1,
      "color": "4283215696",
      "description": "PostgreSQL là hệ quản trị cơ sở dữ liệu mã nguồn mở",
      "imageUrl":
          "https://i.pinimg.com/564x/76/00/82/760082bc1a8d81ac06e14dbd8aad6ede.jpg",
    },
  ];

  //
}
