import 'dart:async';
import 'dart:convert';
import 'package:checkout/services.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:checkout/colors.dart';
import 'package:checkout/confirm.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Operator extends StatefulWidget {
  Operator(this._opera);
  final String _opera;
  @override
  _OperatorState createState() => _OperatorState(this._opera);
}

class GroupModel {
  String text;
  int index;
  GroupModel({this.text, this.index});
}

class _OperatorState extends State<Operator> {
  _OperatorState(this._opera);
  final String _opera;
  var _formKey = GlobalKey<FormState>();
  var _formKey2 = GlobalKey<FormState>();
  bool isLoding = false, coched=false;
  var _categorie = ['FactA', 'FactB', 'FactC', 'FactD'];
  var _abonn = ['Abonnement', 'Réabonnement', 'Autres'];
  var tlv = ["Numéro d'abonnement inexistant"];
  String _current, _url, _serviceNumber, currency, commission, nom, recepteur;
  int _ischeck = 0, _merchantId, index=-1;
  double montant=-1;
  List donnees;
  var data;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _userTextController = new TextEditingController();
  var _userTextController1 = new TextEditingController();
  var _userTextController2 = new TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.lire("merchandId");
    if(_opera == "e" || _opera == "w") {
      _userTextController.text = "Montant de la facture";
    }
  }

  @override
  void dispose(){
    super.dispose();
    _userTextController.dispose();
    _userTextController1.dispose();
    _userTextController2.dispose();
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(content: new Text(value,style:
        TextStyle(
            color: Colors.white,
            fontSize: taille_champ+3
        ),
          textAlign: TextAlign.center,),
          backgroundColor: couleur_fond_bouton,
          duration: Duration(seconds: 5),));
  }

  String getOpera(String op){
    if(op == "m"){
      return "images/mtn.png";
    }else if(op == "o"){
      return "images/orange.jpg";
    }else if(op == "y"){
      return "images/yoomee.png";
    }else if(op == "ca"){
      return "images/camtel.jpg";
    }else if(op == "ne"){
      return "images/nextell.jpg";
    }else if(op == "e"){
      return "images/eneo.jpg";
    }else if(op == "w"){
      return "images/water.jpg";
    }else if(op == "c"){
      _categorie = tlv;
      return "images/canal.png";
    }else if(op == "t"){
      _categorie = _abonn;
      return "images/tv.png";
    }else if(op == "p"){
      return "images/pharmacie.png";
    }
  }

  Future<String> getData(String my_url) async {
    var _header = {
      "accept": "application/json",
      "content-type" : "application/json",
    };
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      var response = await http.get(Uri.encodeFull(my_url), headers: _header,);
      print('statuscode ${response.statusCode}');
      print('url $my_url');
      if (response.statusCode == 200) {
        donnees = json.decode(utf8.decode(response.bodyBytes));
        data = json.decode(utf8.decode(response.bodyBytes));
        //print("donnes: ${data[0]['priceAmount']}");
        if(_opera == "e" || _opera == "w"){
          if(donnees.isEmpty){
            setState(() {
              _ischeck = 0;
            });
            showInSnackBar("Numéro de compteur inexistant!");
          }else {
            setState(() {
              _ischeck = 2;
              montant = data[0]['priceAmount'];
              currency = data[0]['currency'];
              commission = data[0]['spCommissionAmount'];
              _userTextController.text = '$montant $currency';
            });
            print("montant: $montant");
          }
        }else if(_opera == "c"){
          if(donnees.isEmpty){
            setState(() {
              _ischeck = 0;
            });
            showInSnackBar("Numéro de d'abonnement inexistant!");
          }else{
            tlv.clear();
            for(int i=0;i<donnees.length;i++){
              tlv.add(donnees[i]['description']);
            }
            setState(() {
              _ischeck = 2;
              _categorie = tlv;
            });
            print(_categorie.toList());
          }
        }else if(_opera == "t"){
          if(donnees.isEmpty){
            setState(() {
              _ischeck = 0;
            });
            showInSnackBar("Un problème est survenu!");
          }else{
            _abonn.clear();
            for(int i=0;i<donnees.length;i++){
              _abonn.add(donnees[i]['description']);
            }
            setState(() {
              _ischeck = 2;
              _categorie = _abonn;
            });
            print(_categorie.toList());
          }
        }
      }else print(response.body);
    }else {
      ackAlert(context);
    }
    return "success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
      _opera =="m"|| _opera == "o" || _opera == "y" || _opera == "ne" || _opera == "ca"? Padding(
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
                                  fontSize: taille_libelle_champ+3,
                                  color: couleur_libelle_champ,
                                ),),
                              )
                          ),
                          new Expanded(
                            flex:10,
                            child: new TextFormField(
                              keyboardType: TextInputType.phone,
                              style: TextStyle(
                                fontSize: taille_libelle_champ+3,
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
                                  fontSize: taille_libelle_champ+3,
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
                              fontSize: taille_libelle_champ+3,
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
                                fontSize: taille_libelle_champ+3,
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

            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: _opera == "p"?Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                          bottomLeft: Radius.circular(coched==false?10.0:0.0),
                          bottomRight: Radius.circular(coched==false?10.0:0.0),
                        ),
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
                              fontSize: taille_libelle_champ+3,
                              color: couleur_libelle_champ,
                            ),
                            validator: (String value){
                              if(value.isEmpty){
                                return 'Champ montant vide !';
                              }else{
                                montant = double.parse(value);
                                return null;
                              }
                            },
                            decoration: InputDecoration.collapsed(
                              hintText: 'Montant de l\'ordonnance',
                              hintStyle: TextStyle(
                                fontSize: taille_libelle_champ+3,
                                color: couleur_libelle_champ,
                              ),
                              //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            ),
                          ),
                        ),
                      ),
                    ),

                    coched==false?Container():Container(
                      decoration: new BoxDecoration(
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
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 3,
                                  child: Text("+237")),
                              Expanded(
                                flex: 10,
                                child: new TextFormField(
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                    fontSize: taille_libelle_champ+3,
                                    color: couleur_libelle_champ,
                                  ),
                                  validator: (String value){
                                    if(value.isEmpty){
                                      return 'Champ récepteur vide !';
                                    }else{
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration.collapsed(
                                    hintText: 'Numéro du récepteur',
                                    hintStyle: TextStyle(
                                      fontSize: taille_libelle_champ+3,
                                      color: couleur_libelle_champ,
                                    ),
                                    //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    coched==false?Container():Container(
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.only(
                          bottomRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                        ),
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
                              fontSize: taille_libelle_champ+3,
                              color: couleur_libelle_champ,
                            ),
                            validator: (String value){
                              if(value.isEmpty){
                                return 'Champ récepteur vide !';
                              }else{
                                return null;
                              }
                            },
                            decoration: InputDecoration.collapsed(
                              hintText: 'Nom complet du récepteur',
                              hintStyle: TextStyle(
                                fontSize: taille_libelle_champ+3,
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
              ):Container(),
            ),

            _opera =="e" || _opera == "w" ||  _opera == "c" ||  _opera == "t"?Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 30),
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formKey2,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child:_opera == "t"?Container(): Row(
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
                                        fontSize: taille_libelle_champ+3,
                                        color: couleur_libelle_champ,
                                      ),
                                      validator: (String value){
                                        if(value.isEmpty){
                                          return  _opera == "c" ?'Numéro d\'abonnement vide':'Numéro du compteur vide !';
                                        }else{
                                          _serviceNumber = value;
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration.collapsed(
                                        hintText: _opera == "c" ?'Numéro d\'abonnement':'Numéro du compteur',
                                        hintStyle: TextStyle(
                                          fontSize: taille_libelle_champ+3,
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
                                      /*Future.delayed(const Duration(seconds: 5), () {
                                        setState(() {
                                          _ischeck = 2;
                                        });
                                      });*/
                                      _url = "$BaseUrl/items?merchantId=$_merchantId&serviceNumber=$_serviceNumber";
                                      this.getData(_url);
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
                        _opera =="e" || _opera == "w"?Container():Container(
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
                                  int index = -1;
                                  setState(() {
                                    _current = selected;
                                    if(_opera == "c" || _opera == "t"){
                                      index = _categorie.indexOf(_current);
                                      montant = data[index]['priceAmount'];
                                      currency = data[index]['currency'];
                                      commission = data[index]['spCommissionAmount'];
                                      _userTextController.text = "$montant $currency";
                                    }
                                  });
                                },
                                value: _current,
                                hint: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text( getText(),
                                    style: TextStyle(
                                      color: couleur_libelle_champ,
                                      fontSize:taille_libelle_champ+3,
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
                                            fontSize:taille_libelle_champ+3,
                                            fontWeight: FontWeight.bold
                                        ),),
                                    ),
                                  );
                                }).toList(),
                              )
                          ),
                        ),

                        _current == "Autres"?Container(
                          decoration: new BoxDecoration(

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
                                  fontSize: taille_libelle_champ+3,
                                  color: couleur_libelle_champ,
                                ),
                                validator: (String value){
                                  if(value.isEmpty){
                                    return 'Champ autre vide !';
                                  }else{
                                    return null;
                                  }
                                },
                                decoration: InputDecoration.collapsed(
                                  hintText: 'Préciser le service',
                                  hintStyle: TextStyle(
                                    fontSize: taille_libelle_champ+3,
                                    color: couleur_libelle_champ,
                                  ),
                                  //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                ),
                              ),
                            ),
                          ),
                        ):Container(),

                        coched==false?Container():Container(
                          decoration: new BoxDecoration(
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
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      flex: 3,
                                      child: Text("+237")),
                                  Expanded(
                                    flex: 10,
                                    child: new TextFormField(
                                      keyboardType: TextInputType.text,
                                      style: TextStyle(
                                        fontSize: taille_libelle_champ+3,
                                        color: couleur_libelle_champ,
                                      ),
                                      validator: (String value){
                                        if(value.isEmpty){
                                          return 'Champ récepteur vide !';
                                        }else{
                                          recepteur = "+237$value";
                                          _userTextController1.text = "$recepteur";
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration.collapsed(
                                        hintText: 'Numéro du récepteur',
                                        hintStyle: TextStyle(
                                          fontSize: taille_libelle_champ+3,
                                          color: couleur_libelle_champ,
                                        ),
                                        //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        coched==false?Container():Container(
                          decoration: new BoxDecoration(

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
                                  fontSize: taille_libelle_champ+3,
                                  color: couleur_libelle_champ,
                                ),
                                validator: (String value){
                                  if(value.isEmpty){
                                    return 'Champ récepteur vide !';
                                  }else{
                                    nom = "$value";
                                    _userTextController2.text = "$value";
                                    return null;
                                  }
                                },
                                decoration: InputDecoration.collapsed(
                                  hintText: 'Nom complet du récepteur',
                                  hintStyle: TextStyle(
                                    fontSize: taille_libelle_champ+3,
                                    color: couleur_libelle_champ,
                                  ),
                                  //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                ),
                              ),
                            ),
                          ),
                        ),

                        (_opera=="e"|| _opera=="w")&&montant==-1?Container(): Container(
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.only(
                              bottomRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                              topRight: Radius.circular(_opera =="e" || _opera == "w"?10.0:0.0),
                              topLeft: Radius.circular(_opera =="e" || _opera == "w"?10.0:0.0),
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
                                enabled: _opera=="t"?true: false,
                                controller:_opera=="t"?null: _userTextController,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                  fontSize: taille_libelle_champ+3,
                                  color: couleur_libelle_champ,
                                ),
                                validator: (String value){
                                  if(value.isEmpty){
                                    return 'Champ montant vide !';
                                  }else{
                                    montant = double.parse(value);
                                    _userTextController.text = "$montant";
                                    return null;
                                  }
                                },
                                decoration: InputDecoration.collapsed(
                                  hintText: _opera =="m"|| _opera == "o" || _opera == "y" || _opera == "ne" || _opera == "ca"? 'Montant de la recharge':'Montant',
                                  hintStyle: TextStyle(
                                    fontSize: taille_libelle_champ+3,
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
            _opera=="t"||_opera=="p"?Row(
              //mainAxisAlignment: MainAxisAlignment.center,  1fcc2ec18bc30a725c0dab9970d02291758426dc
              children: <Widget>[
                Checkbox(
                    activeColor: couleur_fond_bouton,
                    value: coched,
                    onChanged: (bool val){
                      setState(() {
                        coched = val;
                      });
                      if(!coched){
                        recepteur = null;
                        nom = null;
                      }
                    }
                ),
                Text("Paiement pour un tiers",style: TextStyle(
                    color: couleur_description_champ,
                    fontSize: taille_champ+3,
                    fontFamily: police_description_champ,
                    fontWeight: FontWeight.normal
                ),),
              ],
            ):Container(),

            Padding(
              padding: EdgeInsets.only(top: 20),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if(_formKey.currentState.validate()){
                      _opera == "p"?currency="XAF":{};
                      _stock("montant","$montant $currency");
                      print("ma commision $commission");
                      if(commission == null){
                        _stock("commission", "0.0 $currency");
                      }else{
                        _stock("commission", "$commission $currency");
                      }
                      _stock("recepteur", "$recepteur");
                      _stock("nom", "$nom");
                      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Confirm(_opera)));
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
                  child: new Center(
                    child: isLoding==false?new Text('Poursuivre l\'opération', style: new TextStyle(fontSize: taille_text_bouton+3, color: couleur_text_bouton),):
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
        case 0: return new Text('Vérifier', style: new TextStyle(fontSize: taille_text_bouton+3, color: couleur_text_bouton),);
        case 1: return new CupertinoActivityIndicator();
        case 2: return new Icon(Icons.check, color: Colors.white,);
      }
  }

  String getText(){
    print("actu == $_current");
    if(_opera == "t"){
      return "Choisissez un service";
    }else if(_opera == "c" && _ischeck ==1 || _ischeck==0){
      return "Vérifier votre numéro d'abonnement";
    }else if(_opera == "c" && _ischeck ==2){
      return "Access 5000 Fcfa/mois";
    }else{
    return "Choisissez une facture";
    }
  }

  lire(String v) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _merchantId = prefs.getString(v)==null?-1:int.parse(prefs.getString(v));
    });
    if(_opera == "t"){
      _url = "$BaseUrl/items?merchantId=$_merchantId";
      this.getData(_url);
    }
    print("Mon merchant Id $_merchantId");
  }

  void _stock(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    print('saved $value');
  }
}