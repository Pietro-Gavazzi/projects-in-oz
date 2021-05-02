

local  L  N Result NumberOfTrueFalseOfQuestions Resultat SelectQuestion AnswerYesToQ AnswerFalseToQ in
   
   % Compte le nombre de personnes qui répondent vrais ou faux à une question
   fun{NumberOfTrueFalseOfQuestions L N}      
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

   % selectionne la question qui éliminerale plus de monde #true ~= #false
   fun{SelectQuestion L Q A}
      case L of H|T then if H.v > H.f then if H.v-H.f < A then {SelectQuestion T H.q H.v-H.f}
				      else {SelectQuestion T Q A} end
		    else if H.f-H.v < A then {SelectQuestion T H.q H.f-H.v}
			 else {SelectQuestion T Q A } end
		    end
      []nil then Q
      end
   end
   fun{AnswerYesToQ L Q}
      case L of H|T then if H.Q==true then H|{AnswerYesToQ T Q}
			 else {AnswerYesToQ T Q}end
      []nil then nil
      end
   end
   fun{AnswerFalseToQ L Q}
      case L of H|T then if H.Q==false then H|{AnswerFalseToQ T Q}
			 else {AnswerFalseToQ T Q}end
      []nil then nil
      end
   end
   
			    
   

character('Harry Potter'
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
)
]

   N={Arity L.1}
   Result={NumberOfTrueFalseOfQuestions L N.2}
   Resultat={SelectQuestion Result Result.1.q 100}
   {Browse {AnswerYesToQ L Resultat}}
   fun{BuildTree L N}
      res={NumberOfTrueFalseQuestions L N.2}
      result={SelectQuestion Result Result.1.q 100}
      Ltrue={AnswerYesToQ L result}
      questions(result true: 
			  
	
end




			 
			 