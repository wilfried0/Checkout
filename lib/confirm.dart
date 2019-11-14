import 'package:checkout/colors.dart';
import 'package:checkout/paiement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Confirm extends StatefulWidget {
  Confirm(this._opera);
  final String _opera;
  @override
  _ConfirmState createState() => _ConfirmState(this._opera);
}

class _ConfirmState extends State<Confirm> {
  _ConfirmState(this._opera);
  final String _opera;
  var _formKey = GlobalKey<FormState>();
  bool isLoding = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String getOpera(String op){
    if(op == "m"){
      return "images/mtn.png";
    }else if(op == "o"){
      return "images/orange.jpg";
    }else if(op == "y"){
      return "images/yoomee.png";
    }else if(op == "e"){
      return "images/eneo.jpg";
    }else if(op == "w"){
      return "images/water.jpg";
    }else if(op == "c"){
      return "images/canal.png";
    }else if(op == "t"){
      return "images/tv.png";
    }else if(op == "p"){
      return "images/pharmacie.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Card(
                elevation: 1,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(getOpera(_opera)),
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50, bottom: 20),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              flex: 4,
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.description, color: couleur_libelle_champ),
                                  Text("Sélection", style: TextStyle(
                                      color: couleur_libelle_champ
                                  ),)
                                ],
                              )
                          ),
                          Expanded(
                              flex: 4,
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.beenhere, color: orange_F,),
                                  Text("Confirmation", style: TextStyle(
                                      color: orange_F
                                  ),)
                                ],
                              )
                          ),
                          Expanded(
                              flex: 4,
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.credit_card, color: couleur_libelle_champ,),
                                  Text("Paiement", style: TextStyle(
                                      color: couleur_libelle_champ
                                  ),)
                                ],
                              )
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 120,
                child: Card(
                  elevation: 1,
                  child:_opera=="o"||_opera=="m"? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text("Achat de crédit téléphonique.", style: TextStyle(
                          color: couleur_libelle_champ
                        ),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text("Numéro bénéficiaire: 237693685095", style: TextStyle(
                            color: couleur_libelle_champ
                        ),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text("Montant: 5.000,0 XAF", style: TextStyle(
                            color: couleur_libelle_champ
                        ),),
                      ),
                    ],
                  ):Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text("Paiement facture N°: 1234567", style: TextStyle(
                            color: couleur_libelle_champ
                        ),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text("Montant: 5.000,0 XAF", style: TextStyle(
                            color: couleur_libelle_champ
                        ),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Paiement(_opera)));
                },
                child: new Container(
                  height: hauteur_champ,
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: new BoxDecoration(
                    color: Colors.green,
                    border: new Border.all(
                      color: Colors.transparent,
                      width: 0.0,
                    ),
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  child: new Center(child: isLoding==false?new Text('Confirmer', style: new TextStyle(fontSize: taille_text_bouton+3, color: couleur_text_bouton),):
                  CupertinoActivityIndicator(),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
