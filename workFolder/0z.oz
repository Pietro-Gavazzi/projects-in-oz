declare 
OUTPUTRECORD = question(1:'Est-ce que c\'est une fille ?' false:question(1:'A-t-il des cheveux noirs ?' false:leaf(['Ron Weasley']) true:question(1:'Porte-t-il des lunettes ?' false:leaf(['Severus Rogue']) true:leaf(['Harry Potter']))) true:question(1:'A-t-il des cheveux roux ?' false:question(1:'Porte-t-il des lunettes ?' false:leaf(['Hermione Granger']) true:leaf(['Minerva McGonagall'])) true:leaf(['Ginny Weasley'])))
List1 = 4|3|1|1|2|nil
List2 = 4|5|nil
% fun  {LastElement List}
%    case List
%    of H|nil then H
%    [] H|T   then {LastElement T}
%    end
% end

% {Browse {LastElement ListOfAnswers} }

fun {PopTwoElements List}
 case List 
  of nil then nil
  [] A|nil then nil 
  [] A|B|nil then nil
  [] A|B|C|nil then A 
  [] A|B|C|D then {Append A {PopTwoElements {Append }}}
 end
end

{Browse {PopTwoElements List1}}