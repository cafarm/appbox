% hello world => Hello World
% wOOOW mEmE => Wooow Meme

function out = capitalize(in)
    out = regexprep(lower(in),'(\<[a-z])','${upper($1)}');
end

