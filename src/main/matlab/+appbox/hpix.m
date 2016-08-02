function p = hpix(c)
    % Converts horizontal "character" units to pixel units. Similar to using MATLAB's built-in "character" units, 
    % but works with the default Java font instead of the MATLAB defined system font. This function is useful for 
    % cross-platform GUIs that should scale based on the system font size.
    %
    % Per MATLAB's docs: Character units are characters using the default system font; the width of one character is 
    % the width of the letter x, the height of one character is the distance between the baselines of two lines of text.
    
    persistent width;
    if isempty(width)
        jf = javax.swing.JFrame();
        jf.pack();
        graphics = jf.getGraphics;
        font = javax.swing.UIManager.getDefaults().getFont('Panel.font');
        metrics = graphics.getFontMetrics(font);
        width = metrics.charWidth('m');
        clear('jf')
    end
    p = c * width;
end

