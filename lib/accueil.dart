import 'package:carousel_slider/carousel_slider.dart';
import 'package:checkout/colors.dart';
import 'package:checkout/operator.dart';
import 'package:checkout/recu.dart';
import 'package:checkout/validation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {

  int indik = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: (){
              setState(() {
                //Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Pays()));
              });
            },
            child: Icon(Icons.format_list_bulleted,size: 40,)),
        iconTheme: new IconThemeData(color: couleur_titre),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          decoration: BoxDecoration(
            color: couleur_champ,
            borderRadius: BorderRadius.circular(10)
          ),
          width: MediaQuery.of(context).size.width-40,
          height: hauteur_champ,
          child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Center(
              child: TextFormField(
                keyboardType: TextInputType.text,
                style: TextStyle(
                  fontSize: taille_libelle_etape,
                  color: couleur_libelle_champ,
                ),
                validator: (String value){
                  if(value.isEmpty){
                    return null;
                  }else{
                    return null;
                  }
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Recherher dans la Marketplace',
                  hintStyle: TextStyle(
                    fontSize: taille_libelle_etape-2,
                    color: couleur_libelle_champ,
                  ),
                  //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(//ici on return une column avec un text et une row
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: ListView(
          children: <Widget>[
            Text("Communication", style: TextStyle(
                fontSize: taille_libelle_etape,
                fontWeight: FontWeight.bold
            ),),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Operator("m")));
                    },
                    child: Card(
                      elevation: 0.8,
                     child: Padding(
                       padding: EdgeInsets.all(10),
                       child: Container(
                         height: 50,
                         decoration: BoxDecoration(
                             image: DecorationImage(
                                 image: AssetImage("images/mtn.png"),
                             )
                         ),
                       ),
                     ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Operator("o")));
                    },
                    child: Card(
                      elevation: 0.8,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/orange.jpg"),
                                  fit: BoxFit.contain
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Operator("y")));
                    },
                    child: Card(
                      elevation: 0.8,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/yoomee.png"),
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),

            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text("Energie & Eau", style: TextStyle(
                  fontSize: taille_libelle_etape,
                  fontWeight: FontWeight.bold
              ),),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Operator("e")));
                    },
                    child: Card(
                      elevation: 0.8,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("images/eneo.jpg"),
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Operator("w")));
                    },
                    child: Card(
                      elevation: 0.8,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/water.jpg"),
                                  fit: BoxFit.contain
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Card(
                elevation: 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: CarouselSlider(
                    enlargeCenterPage: true,
                    autoPlay: true,
                    viewportFraction: 1.0,
                    autoPlayAnimationDuration: Duration(milliseconds: 1),
                    enableInfiniteScroll: true,
                    onPageChanged: (value){
                      setState(() {

                      });
                    },
                    height: 300.0,
                    items: [1,2,3].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return getMoyen2(i, context, indik);
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text("Cable & TV", style: TextStyle(
                  fontSize: taille_libelle_etape,
                  fontWeight: FontWeight.bold
              ),),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Operator("t")));
                    },
                    child: Card(
                      elevation: 0.8,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("images/tv.png"),
                                fit: BoxFit.cover
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Operator("c")));
                    },
                    child: Card(
                      elevation: 0.8,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/canal.png"),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text("Pharmacies", style: TextStyle(
                  fontSize: taille_libelle_etape,
                  fontWeight: FontWeight.bold
              ),),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Operator("p")));
              },
              child: Card(
                elevation: 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/pharmacie.png"),
                        )
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:BottomNavigationBar(
        elevation: 0.8,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            title: Text('Mes Reçus'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in),
            title: Text('Validation'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: orange_F,
        unselectedItemColor: orange_F,
        onTap: _onItemTapped,
      ),
    );
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _selectedIndex==1?Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Validation())):Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Recu()));
  }
}
