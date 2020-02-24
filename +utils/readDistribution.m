function Fwrite = readDistribution(file,pattern,scenario)
    fid = fopen(file);
    FC = textscan(fid, '%s', 'delimiter', '\n', 'whitespace', '');
    fclose(fid);
    FC = FC{1};
    FC = strtrim(FC);
    FC = FC(~cellfun(@isempty, strfind(FC,'IDM')));
    Ftmp = char(FC);
    
    Fwrite = [];
    [x,~] = size(Ftmp);
    for i = 1:x
        [~,idx] = regexp(Ftmp(i,:),['id="' pattern]);
        if strcmp(pattern,'CAV') && scenario.sumo.rerouting
            Fwrite = [ Fwrite Ftmp(i,1:idx) num2str(i) Ftmp(i,idx+1:end-2) '>\n<param key="has.rerouting.device" value="true"/>\n</vType>\n' ];
        else
            Fwrite = [ Fwrite Ftmp(i,1:idx) num2str(i) Ftmp(i,idx+1:end) '\n' ];
        end
        
    end
end

