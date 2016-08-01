function p = hpix(c, fig)
    % Converts horizontal "character" units to pixel units. Similar to using MATLAB's built-in "character" units, 
    % but works with the default Java font instead of the MATLAB defined system font. This function is useful for 
    % cross-platform GUIs that should scale based on the system font size. Fig only needs to be provided on the first
    % call and must be a displayed figure. 
    %
    % Per MATLAB's docs: Character units are characters using the default system font; the width of one character is 
    % the width of the letter x, the height of one character is the distance between the baselines of two lines of text.
    
    persistent width;
    if isempty(width)
        if nargin < 2
            fig = gcf;
        end
        warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
        jf = get(handle(fig), 'JavaFrame');
        warning('on','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
        vis = fig.Visible;
        fig.Visible = 'on';
        drawnow();
        fig.Visible = vis;
        graphics = jf.fHG2Client.getGraphics;
        font = javax.swing.UIManager.getDefaults().getFont('Panel.font');
        metrics = graphics.getFontMetrics(font);
        width = metrics.charWidth('m');
    end
    p = c * width;
end

