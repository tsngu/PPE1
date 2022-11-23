#!/usr/bin/env bash

#===============================================================================
# VOUS DEVEZ MODIFIER CE BLOC DE COMMENTAIRES.
# Ici, on décrit le comportement du programme.
# Indiquez, entre autres, comment on lance le programme et quels sont
# les paramètres.
# La forme est indicative, sentez-vous libres d'en changer !
# Notamment pour quelque chose de plus léger, il n'y a pas de norme en bash.
#===============================================================================


if [ $# -ne 2 ]
then
echo "Les deux paramètres n'existent pas"
exit
fi

fichier_urls=$1 # le fichier d'URL en entrée
fichier_tableau=$2 # le fichier HTML en sortie

# !!!!!!
# ici on doit vérifier que nos deux paramètres existent, sinon on ferme!
# !!!!!!

#Récupérer code de réponse avec cut -d (delimiter) et -f (field)#

#curl -I url | grep HTTP | cut -d ' ' -f 2

# modifier la ligne suivante pour créer effectivement du HTML
echo "<html>
    <header>
        <meta charset="UTF-8" />
    </header>
<body>
    <table>
        <tr> <td> N° </td> <td> Code de retour </td> <td> URL </td> </tr>" > $fichier_tableau

lineno=1;

while read -r line;
do
    URL=$line
    CODE_URL=$(curl -I "$URL" | grep HTTP | cut -d ' ' -f 2)
    echo "<tr><td>$lineno</td><td>$CODE_URL</td><td>$URL</td></tr>" >> $fichier_tableau
    lineno=$((lineno+1));
done < $fichier_urls

echo "</table></body></html>" >> $fichier_tableau

# while read -r line;
# do
#	echo "ligne $lineno: $line";
#	lineno=$((lineno+1));
#done < $fichier_urls
