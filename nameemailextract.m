function [ name, email ] = nameemailextract( text )

%find name
name = regexprep(text,'\(.*[0-9].*\)','');%remove anything in parentheses that has a number (phone numbers, room numbers)
name = regexprep(name,'[a-z_]+@[a-z.]*(edu|com|net|org|us)*','','ignorecase');%remove emails (including ones ending in @)
name = regexprep(name,'(F|K|R|V|Z|B|S|T|W).?\d\d','','ignorecase'); %remove Escher room numbers
name = regexprep(name,'(\d{3}.)?\d{3}.\d{4}','');%remove phone numbers
name = name{1}(~isstrprop(name{1},'digit'));%remove other digits


%find email
emailstring = '[a-z_]+@[a-z.]+(edu|com|net|org|us)';
email = regexpi(text, emailstring, 'match');
if isempty(email{1}) %look for intentionally blank umich emails
    email = regexpi(text, '[a-z_]+@[a-z.]*', 'match');
    if ~isempty(email{1})
        email = [email{1}{1} 'umich.edu'];
    end
end

while iscell(email)
    if ~isempty(email)
         email=email{1};
    else
        email='';
    end
end

end

