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
   OUTPUTRECORD = question(1:'Est-ce que c\'est une fille ?' false:question(1:'A-t-il des cheveux noirs ?' false:leaf(['Ron Weasley']) true:question(1:'Porte-t-il des lunettes ?' false:leaf(['Severus Rogue']) true:leaf(['Harry Potter']))) true:question(1:'A-t-il des cheveux roux ?' false:question(1:'Porte-t-il des lunettes ?' false:leaf(['Hermione Granger']) true:leaf(['Minerva McGonagall'])) true:leaf(['Ginny Weasley'])))

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
         fun {Navigate Tree List}
            local
               NewList
               fun {Accumulator Tree List}
                  case List 
                  of H | T then {Accumulator Tree.H  T}
                  [] nil then Tree
                  % else Tree
                  end
               end
               fun  {LastElement List}
                  case List
                  of H|nil then H
                  [] H|T   then {LastElement T}
                  end
               end
            in 
               case {Accumulator Tree List}
                  of leaf(1:A) then {ProjectLib.found A}
                  [] question(1:A true:B false:C) then 
                  NewList = {Append List {ProjectLib.askQuestion A}|nil} 
                  % if {LastElement NewList} == oops then 
                  %    {Navigate Tree {PopTwoElements NewList}}
                  % else
                     {Navigate Tree NewList}
                  % end
               end
            end
         end
         in
            Result = {Navigate OUTPUTRECORD nil}
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
                            autoPlay:ListOfAnswers newCharacter:NewCharacter 
                            oopsButton:true )}
      {Application.exit 0}
   end
end

