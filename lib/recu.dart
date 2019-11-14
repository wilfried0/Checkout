import 'package:checkout/colors.dart';
import 'package:flutter/material.dart';

class Recu extends StatefulWidget {
  @override
  _RecuState createState() => _RecuState();
}

class _RecuState extends State<Recu> {

  List data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: couleur_champ,
      appBar: AppBar(
        title: Text("Mes Reçus", style: TextStyle(
            color: couleur_libelle_champ
        ),),
      ),
      body: ListView.builder(
        itemCount: data==null?10:data.length,
        itemBuilder: (BuildContext context, int i){
          var nom = "Pharmacie du Lac";
          var date = "22 AOût 2019 à 13H55";
          var ref = "8B02V2N19";
          var moyen = "Carte de crédit";
          var quoi = "Achat de médicaments";
          var trans = "BS82323H23";
          var recu = "242122";
          var montant = "30 080 XAF";
          return Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Card(
              elevation: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10,bottom: 10, left: 10),
                        child: Text("Reçu N° $recu",style: TextStyle(
                          color: couleur_fond_bouton
                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 10),
                        child: Text("Transaction: $trans",style: TextStyle(
                            color: couleur_libelle_champ
                        ),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, bottom: 10),
                        child: Text("$quoi",style: TextStyle(
                            color: couleur_libelle_champ
                        ),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, bottom: 10),
                        child: Text("Moyen de paiement: $moyen",style: TextStyle(
                            color: couleur_libelle_champ
                        ),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, bottom: 10),
                        child: Text("Référence: $ref",style: TextStyle(
                            color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, bottom: 10),
                        child: Text("Date et heure: $date",style: TextStyle(
                            color: couleur_libelle_champ
                        ),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, bottom: 10),
                        child: Text("$montant",style: TextStyle(
                            color: couleur_fond_bouton,
                          fontWeight: FontWeight.bold
                        ),),
                      ),
                      Divider(color: couleur_bordure,
                        height: 10,),
                      Padding(
                        padding: EdgeInsets.only(left: 10, bottom: 10, top: 5),
                        child: Text("$nom",style: TextStyle(
                            color: Colors.black,
                          fontSize: taille_libelle_etape,
                          fontWeight: FontWeight.bold
                        ),),
                      ),
                    ],
                  ),
              ),
            ),
          );
        },
      ),
    );
  }
}
