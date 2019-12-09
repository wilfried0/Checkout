import 'package:carousel_slider/carousel_slider.dart';
import 'package:checkout/colors.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Paiement extends StatefulWidget {
  Paiement(this._opera);
  final String _opera;
  @override
  _PaiementState createState() => _PaiementState(this._opera);
}

class _PaiementState extends State<Paiement> {
  _PaiementState(this._opera);
  final String _opera;
  bool isLoding = false, _isHidden=true;
  int indik = 0;
  var _formKey = GlobalKey<FormState>();
  String _montant, _commission, _nom, _recepteur;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.lire();
  }

  void _toggleVisibility(){
    setState((){
      _isHidden = !_isHidden;
    });
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
      return "images/canal.png";
    }else if(op == "t"){
      return "images/tv.png";
    }else if(op == "p"){
      return "images/pharmacie.png";
    }
  }

  lire() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _montant = prefs.getString("montant")==null?null:prefs.getString("montant");
      _commission = prefs.getString("commission")==null?null:prefs.getString("commission");
      _nom = prefs.getString("nom")==null?null:prefs.getString("nom");
      _recepteur = prefs.getString("recepteur")==null?null:prefs.getString("recepteur");
    });
    print("Montant $_montant");
    print("Commission $_commission");
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
                                  Icon(Icons.description, color: couleur_libelle_champ,),
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
                                  Icon(Icons.credit_card, color: orange_F,),
                                  Text("Paiement", style: TextStyle(
                                      color: orange_F
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
                height: getHeight(indik+1),
                child: Card(
                  elevation: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(_opera=="o" || _opera=="m" || _opera=="y"|| _opera == "ne" || _opera == "ca"?"Achat de crédit téléphonique.":_opera=="p"?"Paiement d'une ordonnance":"Paiement facture", style: TextStyle(
                              color: couleur_libelle_champ
                          ),),
                        ),
                        _opera == "e" || _opera == "w" || _opera == "c" || (_opera=="t" && _recepteur=="null")?Container(): Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child:Text(_opera=="o" || _opera=="m" || _opera=="y" || _opera == "ne" || _opera == "ca" || (_opera=="t" && _recepteur!="null")? "Numéro bénéficiaire":_opera=="p"?"Numéro du récepteur":"Numéro de la facture", style: TextStyle(
                                    color: couleur_libelle_champ
                                ),),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(_opera=="o" || _opera=="m" || _opera=="y" || _opera == "ne" || _opera == "ca" || (_opera=="t" && _recepteur!="null")?"$_recepteur":"1234567", style: TextStyle(
                                    color: couleur_fond_bouton,
                                  fontWeight: FontWeight.bold
                                ),textAlign: TextAlign.end,),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text("Montant", style: TextStyle(
                                    color: couleur_libelle_champ
                                ),),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text("$_montant", style: TextStyle(
                                    color: couleur_fond_bouton,
                                    fontWeight: FontWeight.bold,
                                    fontSize: taille_libelle_champ+3
                                ),textAlign: TextAlign.end),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text("Commission", style: TextStyle(
                                    color: couleur_libelle_champ
                                ),),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text("$_commission", style: TextStyle(
                                    color: couleur_fond_bouton,
                                    fontWeight: FontWeight.bold,
                                    fontSize: taille_libelle_champ+3
                                ),textAlign: TextAlign.end),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text("Total à payer TTC", style: TextStyle(
                                    color: couleur_libelle_champ
                                ),),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text("$_montant", style: TextStyle(
                                    color: couleur_fond_bouton,
                                  fontWeight: FontWeight.bold,
                                  fontSize: taille_libelle_champ+3
                                ),textAlign: TextAlign.end),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 10),
                          child: Text("Moyen de paiement", style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                        CarouselSlider(
                          enlargeCenterPage: true,
                          autoPlay: false,
                          enableInfiniteScroll: true,
                          onPageChanged: (value){
                            setState(() {
                              indik = value;
                              print(indik);
                            });
                          },
                          height: 90.0,
                          items: [1,2,3,4].map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return getMoyen(i, context, indik);
                              },
                            );
                          }).toList(),
                        ),

                          indik == 0? Padding(
                          padding: EdgeInsets.only(top: 20),
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
                                            flex: 5,
                                            child: CountryCodePicker(
                                              showFlag: true,
                                              onChanged: (CountryCode code){
                                                //_mySelection = code.dialCode.toString();
                                              },
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
                                              hintText: 'Numéro de téléphone',
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
                                    margin: EdgeInsets.only(top: 0.0),
                                    decoration: new BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(
                                          width: bordure,
                                          color: couleur_bordure
                                      ),
                                    ),
                                    height: hauteur_champ,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex:2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: new Icon(Icons.lock, color: couleur_bordure,),
                                          ),
                                        ),
                                        new Expanded(
                                          flex:10,
                                          child: new TextFormField(
                                            keyboardType: TextInputType.text,
                                            style: TextStyle(
                                                fontSize: taille_libelle_champ,
                                                color: couleur_libelle_champ
                                            ),
                                            validator: (String value){
                                              if(value.isEmpty){
                                                return 'Champ mot de passe vide !';
                                              }else{
                                                //_password = value;
                                                return null;
                                              }
                                            },
                                            decoration: InputDecoration.collapsed(
                                              hintText: 'Mot de passe',
                                              hintStyle: TextStyle(color: couleur_libelle_champ,
                                                  fontSize: taille_libelle_champ),
                                              //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                            ),
                                            obscureText: _isHidden,
                                            /*textAlign: TextAlign.end,*/
                                          ),
                                          //),
                                        ),
                                        Expanded(
                                          flex:2,
                                          child: new IconButton(
                                            onPressed: _toggleVisibility,
                                            icon: _isHidden? new Icon(Icons.visibility_off,):new Icon(Icons.visibility,),
                                            color: couleur_bordure,
                                            iconSize: 20.0,
                                          ),
                                        ),
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
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex:1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: new Icon(Icons.email, color: couleur_bordure,),
                                          ),
                                        ),
                                        new Expanded(
                                          flex:10,
                                          //child: Padding(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 15),
                                            child: new TextFormField(
                                              keyboardType: TextInputType.text,
                                              style: TextStyle(
                                                  fontSize: taille_libelle_champ,
                                                  color: couleur_libelle_champ
                                              ),
                                              validator: (String value){
                                                if(value.isEmpty){
                                                  return 'Champ email vide !';
                                                }else{
                                                  //_password = value;
                                                  return null;
                                                }
                                              },
                                              decoration: InputDecoration.collapsed(
                                                hintText: 'Adresse mail',
                                                hintStyle: TextStyle(color: couleur_libelle_champ,
                                                    fontSize: taille_libelle_champ),
                                                //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                              ),
                                              /*textAlign: TextAlign.end,*/
                                            ),
                                          ),
                                          //),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                          ),
                        ):Container(),

                        indik == 3||indik ==2? Padding(
                          padding: EdgeInsets.only(top: 20),
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
                                            flex: 5,
                                            child: CountryCodePicker(
                                              showFlag: true,
                                              onChanged: (CountryCode code){
                                                //_mySelection = code.dialCode.toString();
                                              },
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
                                              hintText: 'Numéro de téléphone',
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
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex:1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: new Icon(Icons.email, color: couleur_bordure,),
                                          ),
                                        ),
                                        new Expanded(
                                          flex:10,
                                          //child: Padding(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 15),
                                            child: new TextFormField(
                                              keyboardType: TextInputType.text,
                                              style: TextStyle(
                                                  fontSize: taille_libelle_champ,
                                                  color: couleur_libelle_champ
                                              ),
                                              validator: (String value){
                                                if(value.isEmpty){
                                                  return 'Champ email vide !';
                                                }else{
                                                  //_password = value;
                                                  return null;
                                                }
                                              },
                                              decoration: InputDecoration.collapsed(
                                                hintText: 'Adresse mail',
                                                hintStyle: TextStyle(color: couleur_libelle_champ,
                                                    fontSize: taille_libelle_champ),
                                                //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                              ),
                                              /*textAlign: TextAlign.end,*/
                                            ),
                                          ),
                                          //),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                          ),
                        ):Container(),

                        indik==1?Padding(
                          padding: EdgeInsets.only(top: 20),
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
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex:1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: new Icon(Icons.email, color: couleur_bordure,),
                                  ),
                                ),
                                new Expanded(
                                  flex:10,
                                  //child: Padding(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: new TextFormField(
                                      keyboardType: TextInputType.text,
                                      style: TextStyle(
                                          fontSize: taille_libelle_champ,
                                          color: couleur_libelle_champ
                                      ),
                                      validator: (String value){
                                        if(value.isEmpty){
                                          return 'Champ email vide !';
                                        }else{
                                          //_password = value;
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration.collapsed(
                                        hintText: 'Adresse mail',
                                        hintStyle: TextStyle(color: couleur_libelle_champ,
                                            fontSize: taille_libelle_champ),
                                        //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                      ),
                                      /*textAlign: TextAlign.end,*/
                                    ),
                                  ),
                                  //),
                                ),
                              ],
                            ),
                          ),
                        ):Container(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20,bottom: 20),
              child: GestureDetector(
                onTap: () {
                  //Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Profile('')));
                  if(_formKey.currentState.validate()){
                  }
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
                  child: new Center(child: isLoding==false?new Text('Payer', style: new TextStyle(fontSize: taille_text_bouton+3, color: couleur_text_bouton),):
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
