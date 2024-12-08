import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Favorite Items',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: Icon(
                      Icons.favorite,
                      size: 40,
                      color: Colors.pink,
                    ),
                    title: Text('Favorite Item ${index + 1}',
                        style: TextStyle(fontSize: 18)),
                    subtitle: Text(
                        'This is a placeholder description for item ${index + 1}.'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Можно добавить логику для перехода к деталям
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
