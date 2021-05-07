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
   Args = {Application.getArgs 
   record( 'ans'(single type:string)
   'nogui'(single type:bool default:false optional:true) 
   'db'(single type:string)
   )} 

in 
   local
	  NoGUI = Args.'nogui'
	  DB = Args.'db'
     ListOfCharacters = {ProjectLib.loadDatabase file Args.'db'}
      % Vous devez modifier le code pour que cette variable soit assigné un argument 	
     ListOfAnswersFile = Args.'ans'
     ListOfAnswers = {ProjectLib.loadCharacter file Args.'ans'}
   %_______________________________________________________________________________________
     fun {TreeBuilder Database}
         local
            fun{BuildTree L Lq}
               R1 R2 Ltrue Lfalse Nlq SpV SpF
               fun{NumberOfTrueFalseOfQuestions L N}        %Methode qui permets de compter le nombre de reponse vrai ou fausse à chaque questions
               fun{CountFalse L Q  F}
            case L of H|T  then try if H.Q == false then {CountFalse T Q F+1}
                     else  {CountFalse T Q F} end catch error(...) then{CountFalse T Q F} end		       
            [] nil then F	   			        
            end
               end
               fun{CountTrue L Q  V}
            case L of H|T then try if H.Q == true then {CountTrue T Q V+1}
                     else  {CountTrue T Q V} end	catch error(...) then  {CountTrue T Q V} end		       
            [] nil then V	   			        
            end
               end
                  
            in      
               
               case N of H|T then valueQuestion(q:H v:{CountTrue L H 0} f:{CountFalse L H 0})|{NumberOfTrueFalseOfQuestions L T}	 
               [] nil then nil  end      
            end
               fun{SelectQuestion L Q A}   %Methode qui permets de choisir la question avec  la difference la plus petite de vrai ou faux comme encouragé dans l'algo
               case L of H|T then if H.v > H.f then if H.v-H.f < A then {SelectQuestion T H.q H.v-H.f}
                           else {SelectQuestion T Q A} end
                  else if H.f-H.v < A then {SelectQuestion T H.q H.f-H.v}
                  else {SelectQuestion T Q A } end
                  end
               []nil then Q
               end
            end
            fun{AnswerYesToQ L Q}  %Methode qui Liste les personnes qui ont repondu vrai à la question
               case L of H|T then try if H.Q==true then H|{AnswerYesToQ T Q}
                  else {AnswerYesToQ T Q}end catch error(...) then H|{AnswerYesToQ T Q}end
               []nil then nil
               end
            end
            fun{AnswerFalseToQ L Q}  %Methode qui Liste les personnes qui ont repondu faux à la question
               case L of H|T then try if H.Q==false then H|{AnswerFalseToQ T Q}
                  else {AnswerFalseToQ T Q}end catch error(...) then H|{AnswerFalseToQ T Q} end
               []nil then nil
               end
            end
            fun{DeleteQuestion L Q} %Methode qui supprime la question utilisé dans la racine dans l'ensemble des questions
               case L of H|T then  if H \= Q then H|{DeleteQuestion T Q}
                  else {DeleteQuestion T Q} end
               []nil then nil end
            end
            fun{ListOfNames L} %Methode qui etabli un liste  avec uniquement les noms des personnes
               case L of H|T then H.1|{ListOfNames T}
            []nil then nil 
               end
            end
            fun{StilSeparable L} %Methode qui verifie qu'il est toujours possible de separer l'ensemble en un ensemble plus petits
               case L of H|T then if(H.v>0 andthen H.f>0) then true
                     else {StilSeparable T} end
                     
               []nil then false end
            end
            
            in
               R1={NumberOfTrueFalseOfQuestions L Lq}
               R2={SelectQuestion R1 R1.1.q 100}
               Ltrue={AnswerYesToQ L R2}
               Lfalse={AnswerFalseToQ L R2}      
               Nlq={DeleteQuestion Lq R2}
               SpV={StilSeparable{NumberOfTrueFalseOfQuestions Ltrue Nlq}}
               SpF={StilSeparable{NumberOfTrueFalseOfQuestions Lfalse Nlq}}
         
            if (Nlq \=nil andthen SpV==true andthen SpF==true) then  question(R2 true:{BuildTree Ltrue Nlq} false:{BuildTree Lfalse Nlq})
            else if (Nlq \=nil andthen SpV==true andthen SpF==false) then  question(R2 true:{BuildTree Ltrue Nlq} false:leaf({ListOfNames Lfalse}))
            else if(Nlq \=nil andthen SpV==false andthen SpF==true) then  question(R2 true:leaf({ListOfNames Ltrue}) false:{BuildTree Lfalse Nlq})
                  else   question(R2 true:leaf({ListOfNames Ltrue}) false:leaf({ListOfNames Lfalse})) end
            end
            end 
            end
            fun{BiggestListOfQ L A}
               case L of H|T then if{Length{Arity H}.2}>{Length A} then {BiggestListOfQ T {Arity H}.2}
                     else{BiggestListOfQ T A} end
               []nil then A end
            end
         in 
            {BuildTree Database {BiggestListOfQ Database nil}}
         end
      end

   %_______________________________________________________________________________________

      fun {GameDriver Tree}
         Result
         Result1
      in
         local 
         fun {Navigate Tree}  
            case Tree
               of leaf(1:A) then {ProjectLib.found A}
               [] question(1:A true:B false:C) then 
               {Navigate Tree.{ProjectLib.askQuestion A}}
            end
         end
         in
            Result1 = {Navigate Tree}
            case Result1 
            of A|nil then Result = A
            else Result = Result1 end
         end
         if Result == false then
            % Arf ! L'algorithme s'est trompé !
            {Print 'Je me suis trompé\n'}
            {Print {ProjectLib.surrender}}

            % warning, Browse do not work in noGUI mode
            {Print {ProjectLib.askQuestion 'A-t-il des cheveux roux ?'}}

         else
             {Print Result}
         end

         % Toujours renvoyer unit
         unit
      end
   in
      {ProjectLib.play opts(characters:ListOfCharacters driver:GameDriver 
                            noGUI:NoGUI builder:TreeBuilder 
                            autoPlay:ListOfAnswers 
                            oopsButton:false )}
      {Application.exit 0}
   end
end

