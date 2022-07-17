import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laithapp/core/service/support_services.dart';
import 'package:like_button/like_button.dart';

class DesignScreen extends StatelessWidget {
  const DesignScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        leading: Icon(Icons.design_services),
        title: Text('صمم'),
        backgroundColor: Colors.blue[300],
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'يمكنك طلب هدية من تصميمك عبر إرسال صورة إلينا عبر الوتساب بالضغط على الز في الاسفل ❤❤ ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                SupportServices().openwhatsapp();
              },
              child: Container(
                height: 50,
                width: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.indigo,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        FontAwesomeIcons.whatsapp,
                        color: Colors.white,
                        size: 28,
                      ),
                      Text(
                        'واتـسـاب',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      )
                    ],
                  ),
                ),
              ),
            ),
            LikeButton(
              size: 40,
              isLiked: false,
              likeBuilder: (isLiked) {
                return Icon(
                  Icons.favorite,
                  color: isLiked ? Colors.red : Colors.grey,
                  size: 25,
                );
              },
            )
          ],
        ),
      )),
    );
  }
}
