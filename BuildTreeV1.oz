local  L BuildTree Lq in
   fun{BuildTree L Lq}
       R1 R2 Ltrue Lfalse Nlq SpV SpF
       fun{NumberOfTrueFalseOfQuestions L N}        %Methode qui permets de compter le nombre de reponse vrai ou fausse à chaque questions
      fun{CountFalse L Q  F}
	 case L of H|T then if H.Q == false then {CountFalse T Q F+1}
			    else  {CountFalse T Q F} end			       
	 [] nil then F	   			        
	 end
      end
       fun{CountTrue L Q  V}
	 case L of H|T then if H.Q == true then {CountTrue T Q V+1}
			    else  {CountTrue T Q V} end			       
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
      case L of H|T then if H.Q==true then H|{AnswerYesToQ T Q}
			 else {AnswerYesToQ T Q}end
      []nil then nil
      end
   end
   fun{AnswerFalseToQ L Q}  %Methode qui Liste les personnes qui ont repondu faux à la question
      case L of H|T then if H.Q==false then H|{AnswerFalseToQ T Q}
			 else {AnswerFalseToQ T Q}end
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
   
L=[
character('Russell Lambert'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':false
'A-t-il des cheveux?':false
'Est-ce un humain':false
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':false
'A-t-il des cheveux blond?':true
'Est-ce une fille?':true
)
character('Katharine Singleton'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':false
'A-t-il des cheveux?':true
'Est-ce un humain':true
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':true
'Est-ce une fille?':false
)
character('Braydon Bond'
'A-t-il une soeur?':true
'Est-ce un personnage fictif?':false
'A-t-il des cheveux?':true
'Est-ce un humain':false
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':false
'A-t-il des cheveux blond?':false
'Est-ce une fille?':false
)
character('Joely Dejesus'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':false
'Est-ce un humain':false
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':true
'Est-ce une fille?':false
)
character('Shaun Tyler'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':false
'Est-ce un humain':false
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':false
'Est-ce une fille?':false
)
character('Darnell Whittaker'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':true
'Est-ce un humain':false
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':false
'Est-ce une fille?':true
)
character('Osian Gough'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':false
'Est-ce un humain':false
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':true
'Est-ce une fille?':true
)
character('Elle Salter'
'A-t-il une soeur?':true
'Est-ce un personnage fictif?':false
'A-t-il des cheveux?':true
'Est-ce un humain':true
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':false
'A-t-il des cheveux blond?':true
'Est-ce une fille?':true
)
character('Tymon Rossi'
'A-t-il une soeur?':true
'Est-ce un personnage fictif?':false
'A-t-il des cheveux?':true
'Est-ce un humain':false
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':false
'A-t-il des cheveux blond?':true
'Est-ce une fille?':false
)
character('Junior Johns'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':false
'A-t-il des cheveux?':true
'Est-ce un humain':false
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':false
'Est-ce une fille?':true
)
character('Phoenix Bonilla'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':false
'Est-ce un humain':false
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':false
'A-t-il des cheveux blond?':false
'Est-ce une fille?':true
)
character('Arif Singh'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':true
'Est-ce un humain':true
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':true
'Est-ce une fille?':false
)
character('Jiya Beattie'
'A-t-il une soeur?':true
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':true
'Est-ce un humain':false
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':true
'Est-ce une fille?':true
)
character('Ella-May Mcneil'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':true
'Est-ce un humain':true
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':false
'A-t-il des cheveux blond?':true
'Est-ce une fille?':false
)
character('Kaleb Martins'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':false
'A-t-il des cheveux?':true
'Est-ce un humain':false
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':false
'A-t-il des cheveux blond?':true
'Est-ce une fille?':false
)
character('Cadi Rosales'
'A-t-il une soeur?':true
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':true
'Est-ce un humain':true
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':false
'A-t-il des cheveux blond?':true
'Est-ce une fille?':false
)
character('Humera Pope'
'A-t-il une soeur?':true
'Est-ce un personnage fictif?':false
'A-t-il des cheveux?':true
'Est-ce un humain':false
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':true
'Est-ce une fille?':true
)
character('Havin Craig'
'A-t-il une soeur?':true
'Est-ce un personnage fictif?':false
'A-t-il des cheveux?':false
'Est-ce un humain':false
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':false
'Est-ce une fille?':false
)
character('Graham Bennett'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':false
'Est-ce un humain':true
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':false
'A-t-il des cheveux blond?':false
'Est-ce une fille?':true
)
character('Lucien Poole'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':false
'Est-ce un humain':false
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':false
'A-t-il des cheveux blond?':false
'Est-ce une fille?':true
)
character('Neriah Cooley'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':false
'A-t-il des cheveux?':false
'Est-ce un humain':true
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':true
'Est-ce une fille?':false
)
character('Gloria Stewart'
'A-t-il une soeur?':true
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':false
'Est-ce un humain':true
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':false
'A-t-il des cheveux blond?':false
'Est-ce une fille?':true
)
character('Aryan Foster'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':true
'Est-ce un humain':false
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':false
'A-t-il des cheveux blond?':true
'Est-ce une fille?':false
)
character('Said Snider'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':false
'A-t-il des cheveux?':false
'Est-ce un humain':false
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':false
'A-t-il des cheveux blond?':false
'Est-ce une fille?':false
)
character('Marissa Pitt'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':true
'Est-ce un humain':true
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':true
'Est-ce une fille?':false
)
character('Ifrah Dickinson'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':false
'Est-ce un humain':true
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':false
'Est-ce une fille?':false
)
character('Luis Black'
'A-t-il une soeur?':true
'Est-ce un personnage fictif?':false
'A-t-il des cheveux?':false
'Est-ce un humain':true
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':false
'Est-ce une fille?':true
)
character('Zahra Bassett'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':false
'Est-ce un humain':false
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':true
'Est-ce une fille?':true
)
character('Zoya Smart'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':false
'Est-ce un humain':true
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':false
'Est-ce une fille?':false
)
character('Courtney Tapia'
'A-t-il une soeur?':true
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':true
'Est-ce un humain':true
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':false
'Est-ce une fille?':true
)
character('Callum Zhang'
'A-t-il une soeur?':true
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':true
'Est-ce un humain':false
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':false
'A-t-il des cheveux blond?':true
'Est-ce une fille?':true
)
character('Georgie Rudd'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':false
'A-t-il des cheveux?':false
'Est-ce un humain':false
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':false
'Est-ce une fille?':true
)
character('Jim Flynn'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':true
'Est-ce un humain':false
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':false
'A-t-il des cheveux blond?':false
'Est-ce une fille?':false
)
character('Addison Ortega'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':false
'A-t-il des cheveux?':false
'Est-ce un humain':true
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':true
'Est-ce une fille?':true
)
character('Zayn Bryan'
'A-t-il une soeur?':true
'Est-ce un personnage fictif?':false
'A-t-il des cheveux?':false
'Est-ce un humain':true
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':false
'Est-ce une fille?':false
)
character('Jago Gates'
'A-t-il une soeur?':true
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':true
'Est-ce un humain':true
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':false
'A-t-il des cheveux blond?':false
'Est-ce une fille?':false
)
character('Kole Romero'
'A-t-il une soeur?':true
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':true
'Est-ce un humain':true
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':false
'Est-ce une fille?':false
)
character('Tarik Albert'
'A-t-il une soeur?':true
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':true
'Est-ce un humain':true
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':false
'A-t-il des cheveux blond?':false
'Est-ce une fille?':true
)
character('Lucian Broughton'
'A-t-il une soeur?':true
'Est-ce un personnage fictif?':false
'A-t-il des cheveux?':false
'Est-ce un humain':true
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':true
'Est-ce une fille?':false
)
character('Brenna Small'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':false
'A-t-il des cheveux?':false
'Est-ce un humain':true
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':false
'Est-ce une fille?':false
)
character('Jibril Hull'
'A-t-il une soeur?':true
'Est-ce un personnage fictif?':false
'A-t-il des cheveux?':true
'Est-ce un humain':false
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':true
'Est-ce une fille?':false
)
character('Paul Love'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':false
'Est-ce un humain':true
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':false
'A-t-il des cheveux blond?':false
'Est-ce une fille?':false
)
character('Ellie-Louise Partridge'
'A-t-il une soeur?':true
'Est-ce un personnage fictif?':false
'A-t-il des cheveux?':true
'Est-ce un humain':false
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':false
'A-t-il des cheveux blond?':false
'Est-ce une fille?':false
)
character('Mercy Hood'
'A-t-il une soeur?':true
'Est-ce un personnage fictif?':false
'A-t-il des cheveux?':false
'Est-ce un humain':true
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':false
'Est-ce une fille?':true
)
character('Cecelia Dennis'
'A-t-il une soeur?':true
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':false
'Est-ce un humain':true
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':false
'Est-ce une fille?':false
)
character('Nadia Chapma'
'A-t-il une soeur?':true
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':true
'Est-ce un humain':true
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':false
'Est-ce une fille?':true
)
character('Devonte Reid'
'A-t-il une soeur?':true
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':false
'Est-ce un humain':false
'A-t-il des cheveux noirs?':true
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':true
'Est-ce une fille?':false
)
character('Annabel Slater'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':false
'A-t-il des cheveux?':false
'Est-ce un humain':true
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':false
'A-t-il des cheveux blond?':true
'Est-ce une fille?':false
)
character('Aarush Samuels'
'A-t-il une soeur?':false
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':true
'Est-ce un humain':true
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':false
'A-t-il des cheveux blond?':false
'Est-ce une fille?':true
)
character('Haya Mcloughlin'
'A-t-il une soeur?':true
'Est-ce un personnage fictif?':true
'A-t-il des cheveux?':true
'Est-ce un humain':false
'A-t-il des cheveux noirs?':false
'Porte-t-il des lunettes?':true
'A-t-il des cheveux blond?':true
'Est-ce une fille?':true
)
]


   
     {Browse {BuildTree L {Arity L.1}.2}}
end




			 
			 