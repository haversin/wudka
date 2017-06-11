function [ rot, tra, sdtra ] = read_constraints( file_rot, file_tra, points, bodies)
    irot = 1;
    % rot = [body_i; body_j; s(i); s(j)]
    rot = [];
    tra = [];
    sdtra = {};
    if(file_rot > 0)
        while ~feof(file_rot)
            a(:) = textscan(file_rot, '%f %f %s %s\n', 1);
            
            v1 = [a{1} a{2}]';
            if(size(v1,2) == 0)
                break
            end
            if(v1(1) == 0)
                v2 = points(a{3}{1});
            else
                v2 = points(a{3}{1}) - bodies(:,v1(1));
            end
            if(v1(2) == 0)
                v3 = points(a{3}{1});
            else
                v3 = points(a{3}{1}) - bodies(:,v1(2));
            end
            rot(:,irot) = [v1; v2; v3];
            
            irot = irot+1;
        end
    end
    
    itra = 1;
    isdtra = 1;
    % tra = [body_i; body_j; sai; sbj; vj; fi0]
    if(file_tra > 0)
        while ~feof(file_tra)
            b(:) = textscan(file_tra, '%f %f %s %s %f %f\n', 1);
            bod = [b{1} b{2}]';
            if(size(bod,2) == 0)
                break
            end
            if(bod(1) == 0)
                sai = points(b{3}{1});
            else
                sai = points(b{3}{1}) - bodies(:,bod(1));
            end
            if(bod(2) == 0)
                sbj = points(b{4}{1});
            else
                sbj = points(b{4}{1}) - bodies(:,bod(2));
            end
            vj = [0, -1; 1, 0]*(points(b{4}{1}) - points(b{3}{1}));
            %vj = vj/norm(vj);
            tra(:,itra) = [bod; sai; sbj; vj; 0];
            
            k = b{5};
            c = b{6};
            
            if (k > 0.0) || (c > 0.0)
                sdtra{isdtra} = {itra, k, c, norm(points(b{4}{1}) - points(b{3}{1})) };
                isdtra = isdtra+1;
            end
            
            itra = itra+1;
        end
    end
end

