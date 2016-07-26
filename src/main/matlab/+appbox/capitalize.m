function out = capitalize(in)
    % hello world => Hello World
    % wOOOW mEmE => Wooow Meme
    
    out = regexprep(lower(in),'(\<[a-z])','${upper($1)}');
end

