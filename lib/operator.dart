import 'dart:async';

import 'package:checkout/colors.dart';
import 'package:checkout/confirm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Operator extends StatefulWidget {
  Operator(this._opera);
  final String _opera;
  @override
  _OperatorState createState() => _OperatorState(this._opera);
}

class _OperatorState extends State<Operator> {
  _OperatorState(this._opera);
  final String _opera;
  var _formKey = GlobalKey<FormState>();
  var _formKey2 = GlobalKey<FormState>();
  bool isLoding = false;
  var _categorie = ['FactA', 'FactB', 'FactC', 'FactD'];
  String _current;
  int _ischeck = 0;

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
                                  Icon(Icons.description, color: orange_F,),
                                  Text("Sélection", style: TextStyle(
                                    color: orange_F
                                  ),)
                                ],
                              )
                          ),
                          Expanded(
                              flex: 4,
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.beenhere, color: couleur_libelle_champ,),
                                  Text("Confirmation", style: TextStyle(
                                      color: couleur_libelle_champ
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
      _opera =="m"|| _opera == "o" || _opera == "y" || _opera == "t" || _opera == "c" || _opera == "p"? Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        color: Colors.transparent,
                        border: Border.all(
                            color: couleur_bordure,
                            width: bordure
                        ),
                      ),
                      height: hauteur_champ,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text("+237",style: TextStyle(
                                  fontSize: taille_libelle_champ,
                                  color: couleur_libelle_champ,
                                ),),
                              )
                          ),
                          new Expanded(
                            flex:10,
                            child: new TextFormField(
                              keyboardType: TextInputType.phone,
                              style: TextStyle(
                                fontSize: taille_libelle_champ,
                                color: couleur_libelle_champ,
                              ),
                              validator: (String value){
                                if(value.isEmpty){
                                  return 'Champ téléphone vide !';
                                }else{
                                  return null;
                                }
                              },
                              decoration: InputDecoration.collapsed(
                                hintText: 'Numéro à recharger',
                                hintStyle: TextStyle(
                                  fontSize: taille_libelle_champ,
                                  color: couleur_libelle_champ,
                                ),
                                //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.only(
                          bottomRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                        ),
                        color: Colors.transparent,
                        border: Border.all(
                            color: couleur_bordure,
                            width: bordure
                        ),
                      ),
                      height: hauteur_champ,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: new TextFormField(
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                              fontSize: taille_libelle_champ,
                              color: couleur_libelle_champ,
                            ),
                            validator: (String value){
                              if(value.isEmpty){
                                return 'Champ montant vide !';
                              }else{
                                return null;
                              }
                            },
                            decoration: InputDecoration.collapsed(
                              hintText: 'Montant de la recharge',
                              hintStyle: TextStyle(
                                fontSize: taille_libelle_champ,
                                color: couleur_libelle_champ,
                              ),
                              //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ):Container(),

            _opera =="e" || _opera == "w"?Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 30),
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formKey2,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 8,
                            child: Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Container(
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.only(
                                    bottomRight: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                    topLeft: Radius.circular(10.0),
                                  ),
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: couleur_bordure,
                                      width: bordure
                                  ),
                                ),
                                height: hauteur_champ,
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: new TextFormField(
                                      keyboardType: TextInputType.text,
                                      style: TextStyle(
                                        fontSize: taille_libelle_champ,
                                        color: couleur_libelle_champ,
                                      ),
                                      validator: (String value){
                                        if(value.isEmpty){
                                          return 'Numéro du compteur vide !';
                                        }else{
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration.collapsed(
                                        hintText: 'Numéro du compteur',
                                        hintStyle: TextStyle(
                                          fontSize: taille_libelle_champ,
                                          color: couleur_libelle_champ,
                                        ),
                                        //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if(_formKey2.currentState.validate()){
                                      _ischeck = 1;
                                      Future.delayed(const Duration(seconds: 5), () {
                                        setState(() {
                                          _ischeck = 2;
                                        });
                                      });
                                    }
                                  });
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
                                  child: new Center(child:getCheck()),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                            color: Colors.transparent,
                            border: Border.all(
                                color: couleur_bordure,
                                width: bordure
                            ),
                          ),
                          height: hauteur_champ,
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                icon: Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: new Icon(Icons.arrow_drop_down_circle,
                                    color: Colors.green,),
                                ),
                                isDense: true,
                                elevation: 1,
                                isExpanded: true,
                                onChanged: (String selected){
                                  setState(() {
                                    _current = selected;
                                  });
                                },
                                value: _current,
                                hint: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text('Choisissez une facture',
                                    style: TextStyle(
                                      color: couleur_libelle_champ,
                                      fontSize:taille_libelle_champ,
                                    ),),
                                ),
                                items: _categorie.map((String name){
                                  return DropdownMenuItem<String>(
                                    value: name,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Text(name,
                                        style: TextStyle(
                                            color: couleur_fond_bouton,
                                            fontSize:taille_libelle_champ,
                                            fontWeight: FontWeight.bold
                                        ),),
                                    ),
                                  );
                                }).toList(),
                              )
                          ),
                        ),

                        Container(
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.only(
                              bottomRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                            ),
                            color: Colors.transparent,
                            border: Border.all(
                                color: couleur_bordure,
                                width: bordure
                            ),
                          ),
                          height: hauteur_champ,
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: new TextFormField(
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                  fontSize: taille_libelle_champ,
                                  color: couleur_libelle_champ,
                                ),
                                validator: (String value){
                                  if(value.isEmpty){
                                    return 'Champ montant vide !';
                                  }else{
                                    return null;
                                  }
                                },
                                decoration: InputDecoration.collapsed(
                                  hintText: 'Montant de la recharge',
                                  hintStyle: TextStyle(
                                    fontSize: taille_libelle_champ,
                                    color: couleur_libelle_champ,
                                  ),
                                  //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ):Container(),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Confirm(_opera)));
                    if(_formKey.currentState.validate()){

                    }
                  });
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
                  child: new Center(child: isLoding==false?new Text('Poursuivre l\'opération', style: new TextStyle(fontSize: taille_text_bouton, color: couleur_text_bouton),):
                  CupertinoActivityIndicator(),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget getCheck(){
      switch(_ischeck){
        case 0: return new Text('Vérifier', style: new TextStyle(fontSize: taille_text_bouton, color: couleur_text_bouton),);
        case 1: return new CupertinoActivityIndicator();
        case 2: return new Icon(Icons.check, color: Colors.white,);
      }
  }
}
