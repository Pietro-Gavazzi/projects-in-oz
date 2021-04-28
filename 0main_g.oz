
functor
import
   ProjectLib
   Browser
   OS
   System
   Application
declare

INPUTRECORD = [character('Harry Potter'
'Est-ce que c\'est une fille ?':false
'A-t-il des cheveux noirs ?':true
'Porte-t-il des lunettes ?':true
'A-t-il des cheveux roux ?':false
)
character('Ron Weasley'
'Est-ce que c\'est une fille ?':false
'A-t-il des cheveux noirs ?':false
'Porte-t-il des lunettes ?':false
'A-t-il des cheveux roux ?':true
)
character('Hermione Granger'
'Est-ce que c\'est une fille ?':true
'A-t-il des cheveux noirs ?':false
'Porte-t-il des lunettes ?':false
'A-t-il des cheveux roux ?':false
)
character('Ginny Weasley'
'Est-ce que c\'est une fille ?':true
'A-t-il des cheveux noirs ?':false
'Porte-t-il des lunettes ?':false
'A-t-il des cheveux roux ?':true
)
character('Minerva McGonagall'
'Est-ce que c\'est une fille ?':true
'A-t-il des cheveux noirs ?':false
'Porte-t-il des lunettes ?':true
'A-t-il des cheveux roux ?':false
)
character('Severus Rogue'
'Est-ce que c\'est une fille ?':false
'A-t-il des cheveux noirs ?':true
'Porte-t-il des lunettes ?':false
'A-t-il des cheveux roux ?':false
)]


OUTPUTRECORD = question('Est-ce que c\'est une fille ?'
          true: leaf(['Hermione Granger'])
          false: question('Porte-t-il des lunettes ?'
                 true: leaf(['Harry Potter'])
                 false: leaf(['Ron Weasley'])))




ListOfCharacters = {ProjectLiblLoadDatabase file "database.txt"}




Options = opts(characters:ListOfCharacters
               builder:TreeBuilder
               driver:GameDriver
               noGUI:false
               autoPlay:ListOfAnswers)
               
{ProjectLib.play Options}