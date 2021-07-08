%extract officer data from text files
clear all

filenames %load strfiles array

path='C:\Users\Nun Maker\Dropbox\Esher\Alumni\Annual Officer Directories\Annual Officer Directories\All Directories\';


officerinfo = {['Name, Email, Position, Year']};%initialize array

for file = strfiles
    [ output ] = extractofficerinfo( [path file{1}] );
    officerinfo = [officerinfo;output];
end
