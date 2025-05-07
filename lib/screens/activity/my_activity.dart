import 'package:flutter/material.dart';

class MyActivityPage extends StatelessWidget {
  final List<CategoryData> categories = [
    CategoryData("Clothing", 187, Colors.orange),
    CategoryData("Shoes", 450, Color(0xFF004CFF)),
    CategoryData("Bags", 312, Colors.green),
    CategoryData("Lingerie", 210, Colors.purple),
  ];

  MyActivityPage({super.key});

  double getTotalSpent() {
    return categories.fold(0.0, (sum, item) => sum + item.amount);
  }

  @override
  Widget build(BuildContext context) {
    final double totalSpent = getTotalSpent();
    final String monthName = "May"; // Название месяца, например, Май

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/flash_sale_2.png'),
              radius: 20,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Activity',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: const [
          Icon(Icons.menu, color: Color(0xFF004CFF)),
          SizedBox(width: 10),
          Icon(Icons.discount_outlined, color: Color(0xFF004CFF)),
          SizedBox(width: 10),
          Icon(Icons.settings, color: Color(0xFF004CFF)),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Название месяца
            Text(
              monthName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF004CFF),
              ),
            ),

            const SizedBox(height: 16),

            // Диаграмма с стрелочками и месяцем
            Row(
              children: [
                // Стрелка слева
                IconButton(
                  icon: const Icon(Icons.arrow_left, color: Color(0xFF004CFF)),
                  onPressed: () {
                    // Логика для перехода к предыдущему месяцу
                  },
                  iconSize: 40, // Увеличен размер стрелки
                ),

                // Диаграмма
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: 250,
                      height: 250,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Нижний белый круг с тенью
                          Container(
                            width: 230,
                            height: 230,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 6),
                              ],
                            ),
                          ),

                          // Разноцветный квадрат
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                            ),
                            child: CustomPaint(
                              painter: SquarePainter(categories),
                            ),
                          ),

                          // Внешний белый круг
                          Container(
                            width: 180,
                            height: 180,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),

                          // Внутренний белый круг с тенью и текстом
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 4),
                              ],
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Total",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    totalSpent.toStringAsFixed(0),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Стрелка справа
                IconButton(
                  icon: const Icon(Icons.arrow_right, color: Color(0xFF004CFF)),
                  onPressed: () {
                    // Логика для перехода к следующему месяцу
                  },
                  iconSize: 40, // Увеличен размер стрелки
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Капсулы как кнопки с цветом и белым текстом
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: categories.map((category) {
                return ElevatedButton(
                  onPressed: () {
                    // Действие при нажатии на кнопку
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: category.color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 23,
                      vertical: 11,
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: Size(
                      0,
                      0,
                    ), // уменьшает вертикальное растяжение
                  ),
                  child: Text(
                    "${category.name} \$${category.amount.toStringAsFixed(0)}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // Три кружка с цифрами
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildCircleStat("6", "Ordered"),
                buildCircleStat("7", "Received"),
                buildCircleStat("12", "To Receive"),
              ],
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/orderHistory');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF004CFF),
                padding: const EdgeInsets.symmetric(
                  horizontal: 120,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Order History',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCircleStat(String number, String label) {
    return Column(
      children: [
        // Внешний белый круг
        Container(
          width: 70,
          height: 70,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Center(
            // Внутренний синий круг
            child: Container(
              width: 45,
              height: 45,
              decoration: const BoxDecoration(
                color: Color(0xFF004CFF),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  number,
                  style: const TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 17,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class CategoryData {
  final String name;
  final double amount;
  final Color color;

  CategoryData(this.name, this.amount, this.color);
}

class SquarePainter extends CustomPainter {
  final List<CategoryData> categories;

  SquarePainter(this.categories);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final total = categories.fold(0.0, (sum, item) => sum + item.amount);

    double startX = 0.0;
    double startY = 0.0;
    double width = size.width / 2;
    double height = size.height / 2;

    for (var i = 0; i < categories.length; i++) {
      final category = categories[i];
      paint.color = category.color;

      // Рисуем прямоугольники, которые составляют разноцветный квадрат
      canvas.drawRect(Rect.fromLTWH(startX, startY, width, height), paint);

      // Сдвигаем на следующую часть
      startX += width;

      if (startX >= size.width) {
        startX = 0;
        startY += height;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
