functor
import
   ProjectLib
   Browser
   OS
   System
   Application
define
   CWD = {Atom.toString {OS.getCWD}}#"/"
   Browse = proc {$ Buf} {Browser.browse Buf} end
   Print = proc{$ S} {System.print S} end
   Args = {Application.getArgs record('nogui'(single type:bool default:false optional:true)
									  'db'(single type:string default:CWD#"database.txt"))} 
   
   
   OUTPUTRECORD = question('Est-ce que c\'est une fille ?'
          true: leaf(['Hermione Granger'])
          false: question('Porte-t-il des lunettes ?'
                 true: leaf(['Harry Potter'])
                 false: leaf(['Ron Weasley'])))
in 
   local
	  NoGUI = Args.'nogui'
	  DB = Args.'db'
     ListOfCharacters = {ProjectLib.loadDatabase file Args.'db'}
     NewCharacter = {ProjectLib.loadCharacter file CWD#"new_character.txt"}
	  % Vous devez modifier le code pour que cette variable soit
	  % assigné un argument 	
     ListOfAnswersFile = CWD#"test_answers.txt"
     ListOfAnswers = {ProjectLib.loadCharacter file CWD#"test_answers.txt"}

     fun {TreeBuilder Database}
       leaf(nil)
     end

      fun {GameDriver Tree}
         Result
      in
         local 
         fun {Navigate Tree}
            case Tree
            of leaf(1:A) then {ProjectLib.found A}
            [] question(1:A true:B false:C) then {Navigate Tree.{ProjectLib.askQuestion A}}
            end
         end
         in
            Result = {Navigate OUTPUTRECORD}
         end
         if Result == false then
            % Arf ! L'algorithme s'est trompé !
            {Print 'Je me suis trompé\n'}
            {Print {ProjectLib.surrender}}

            % warning, Browse do not work in noGUI mode
            {Browse {ProjectLib.askQuestion 'A-t-il des cheveux roux ?'}}

         else
             {Print Result}
         end

         % Toujours renvoyer unit
         unit
      end
   in
      {ProjectLib.play opts(characters:ListOfCharacters driver:GameDriver 
                            noGUI:NoGUI builder:TreeBuilder 
                            autoPlay:ListOfAnswers newCharacter:NewCharacter)}
      {Application.exit 0}
   end
end

