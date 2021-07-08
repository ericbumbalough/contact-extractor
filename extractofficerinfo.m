function [ officerinfo ] = extractofficerinfo( filename )

year = filename(isstrprop(filename,'digit'));

officerinfo={};

%read file
fileID = fopen(filename);
text = textscan(fileID,'%s','Delimiter','\n','BufSize',20000);
fclose(fileID);

%info = {['Name, Email, Position, Year']};

for n=1:length(text{1}) %look at each line
    if ~isempty(text{1}{n}) %skip empty lines 
              
%         %if line ends in '@'  or '.' append 'umich.edu'
%         if text{1}{n}(end) == '@' || text{1}{n}(end) == '.'
%             text{1}{n} = [text{1}{n} 'umich.edu'];
%         end
        
        %if line has : followed by any letters then it is an officer
        colon = '.:.*[a-zA-Z]';%regular experession for colon with any letter
        foundColon = regexpi(text{1}{n},colon);%position of first colon, empty if there are none
        
        if ~isempty(foundColon)
            officerposition = text{1}{n}(1:foundColon);%everything before the colon is officer title
            
            split = text{1}{n}(foundColon+2:end); %extract everything between : and the end
            split = regexpi(split,'( and | & )','split');%split at and
            for str = split
                [ name, email ] = nameemailextract( str );
                officerinfo = [officerinfo;name, ', ',email, ', ',officerposition,', ',num2str(year)];
            end
            
        end      
    end
end
    
end


