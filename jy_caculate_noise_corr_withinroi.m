function output= jy_caculate_noise_corr_withinroi(data,corx,cory,slice,distence_theord)

        dist_matrix = zeros(length(corx),length(cory));
        for i = 1:length(corx)
            for j = 1:length(cory)
                dist_matrix(i,j) = pdist([corx(i) cory(i) slice(i); corx(j) cory(j) slice(j)],'euclidean');
            end
        end
        
        corrmap = corr(data);
        output = mean(corrmap(dist_matrix>distence_theord),'omitnan');
 
end