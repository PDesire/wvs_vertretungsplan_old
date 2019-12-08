import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:wvs_plan/backend/model/DSBNextModel/DSBNextModel.dart';
import 'package:wvs_plan/backend/model/DSBNextModel/Result.dart';
import 'package:wvs_plan/backend/model/global/InformationCell.dart';
import 'package:wvs_plan/backend/service/DSB/DSBService.dart';

class NextPage extends StatefulWidget {
  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: DsbService.getNext(),
          builder: (BuildContext context, AsyncSnapshot<DsbNextModel> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Center(
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: CircularProgressIndicator(),
                  ),
                );
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Container();
                } else {
                  if (snapshot.data == null) {
                    return Container();
                  }
                  if (snapshot.data.result.length == 0) {
                    return Container();
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.result.length,
                    itemBuilder: (context, index) {
                      return createDateCard(snapshot.data.result[index]);
                    },
                  );
                }
            }
            return Container();
          }
      ),
    );
  }

  Container createDateCard(Result result) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ExpandablePanel(
            tapHeaderToExpand: true,
            hasIcon: true,
            header: Container(
              padding: EdgeInsets.fromLTRB(13, 10, 13, 10),
              child: Text(
                result.data.first.date,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40
                ),
              ),
            ),
            expanded: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: result.data.length,
              itemBuilder: (context, index) {
                return createCard(result.data[index]);
              },
            ),
          ),
        ),
      ),
    );
  }

  Container createCard(InformationCell cell) {
    if (cell.lessonBefore == "") {
      return Container();
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.10,
      padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0)
        ),
        color: chooseColorCard(cell.cancelled == true ? "Entfall" : cell.type),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Fach: " + cell.lessonBefore,
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(cell.schoolClassBefore),
                  Text(cell.cancelled == true ? "Entfall" : cell.type)
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(cell.representative),
                  Text(cell.roomAfter == "---" ? cell.roomBefore : cell.roomAfter)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Color chooseColorCard(String type) {
    switch(type) {
      case "Statt-Vertretung":
        return Colors.teal;
      case "Verlegung":
        return Colors.orange[800];
      case "Entfall":
        return Colors.red[800];
      case "Freisetzung":
        return Colors.blue[800];
      case "Betreuung":
        return Colors.purple[800];
      case "Vertretung":
        return Colors.green[800];
      default:
        return Theme.of(context).cardColor;
    }
  }
}
