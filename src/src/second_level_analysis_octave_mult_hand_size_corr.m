function [] = second_level_analysis_octave_mult_hand_size_corr(smooth1,smooth2,reg1,reg2,der1,der2,b1,b2,size,corr)
    file_name=['list_couples_subjects_HCP_',num2str(size),'.mat']
    if ~exist(file_name)
        error('Error: list of groups id does not exist')
    else

        if pipeline_order(smooth1,reg1,der1)<=pipeline_order(smooth2,reg2,der2)
            smooth1_bis=smooth1
            reg1_bis=reg1
            der1_bis=der1
            smooth2_bis=smooth2
            reg2_bis=reg2
            der2_bis=der2
	else
	    smooth1_bis=smooth2
            reg1_bis=reg2
            der1_bis=der2
            smooth2_bis=smooth1
            reg2_bis=reg1
            der2_bis=der1
        end

        G = importdata(['list_couples_subjects_HCP_',num2str(size),'.mat']);
        for i=b1:b2
	    second_level_analysis_octave_hand_corr(G(i,1:size),G(i,(size+1):2*size),smooth1_bis,smooth2_bis,reg1_bis,reg2_bis,der1_bis,der2_bis,['SLA',num2str(i),'_',num2str(size),'_hand'],corr)
        end
    end
end
