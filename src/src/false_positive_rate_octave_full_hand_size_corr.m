function [] = false_positive_rate_octave_full_hand_size_corr(smooth1,smooth2,reg1,reg2,der1,der2,size,corr)
    smooth1 = num2str(smooth1);
    smooth2 = num2str(smooth2);
    reg1 = num2str(reg1);
    reg2 = num2str(reg2);
    der1 = num2str(der1);
    der2 = num2str(der2);

    
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

    if corr==0
        for i=1:1000
            false_positive_rate_octave(smooth1_bis,smooth2_bis,reg1_bis,reg2_bis,der1_bis,der2_bis,['SLA',num2str(i),'_',num2str(size),'_hand'])
        end

        Lfract=[]
        Lmean = []

        if pipeline_order(smooth1,reg1,der1)<=pipeline_order(smooth2,reg2,der2)	
	    for i=1:1000
		a = load(fullfile('data',['SLA',num2str(i),'_',num2str(size),'_hand'],['smooth_',smooth1_bis,'_',smooth2_bis],['reg_',reg1_bis,'_',reg2_bis],['der_',der1_bis,'_',der2_bis],'FPR.mat'))
		Lfract=[Lfract,a.fract]
		Lmean = [Lmean,mean(Lfract)]
	    end
	else
	    for i=1:1000
		a = load(fullfile('data',['SLA',num2str(i),'_',num2str(size),'_hand'],['smooth_',smooth1_bis,'_',smooth2_bis],['reg_',reg1_bis,'_',reg2_bis],['der_',der1_bis,'_',der2_bis],'FPR2.mat'))
		Lfract=[Lfract,a.fract]
		Lmean = [Lmean,mean(Lfract)]
	    end
	end
        mean=Lmean(1000)

        mkdir_mult(fullfile('results',['smooth_',smooth1,'_reg_',reg1,'_der_',der1],['smooth_',smooth2,'_reg_',reg2,'_der_',der2]))
        save('-mat7-binary',fullfile('results',['smooth_',smooth1,'_reg_',reg1,'_der_',der1],['smooth_',smooth2,'_reg_',reg2,'_der_',der2],['Lfract_hand_',num2str(size),'.mat']),'Lfract')
        save('-mat7-binary',fullfile('results',['smooth_',smooth1,'_reg_',reg1,'_der_',der1],['smooth_',smooth2,'_reg_',reg2,'_der_',der2],['Lmean_hand_',num2str(size),'.mat']),'Lmean')
        save('-mat7-binary',fullfile('results',['smooth_',smooth1,'_reg_',reg1,'_der_',der1],['smooth_',smooth2,'_reg_',reg2,'_der_',der2],['mean_hand_',num2str(size),'.mat']),'mean')
    else
        for i=1:1000
            false_positive_rate_octave_corr(smooth1_bis,smooth2_bis,reg1_bis,reg2_bis,der1_bis,der2_bis,['SLA',num2str(i),'_',num2str(size),'_hand'])
        end
        
        Lfract=[]
        Lmean = []

	if pipeline_order(smooth1,reg1,der1)<=pipeline_order(smooth2,reg2,der2)	
	    for i=1:1000
		a = load(fullfile('data',['SLA',num2str(i),'_',num2str(size),'_hand'],['smooth_',smooth1_bis,'_',smooth2_bis],['reg_',reg1_bis,'_',reg2_bis],['der_',der1_bis,'_',der2_bis],'FPR_FWE.mat'))
		Lfract=[Lfract,((a.fract)>0)*1]
		Lmean = [Lmean,mean(Lfract)]
	    end
	else
	    for i=1:1000
		a = load(fullfile('data',['SLA',num2str(i),'_',num2str(size),'_hand'],['smooth_',smooth1_bis,'_',smooth2_bis],['reg_',reg1_bis,'_',reg2_bis],['der_',der1_bis,'_',der2_bis],'FPR_FWE_2.mat'))
		Lfract=[Lfract,((a.fract)>0)*1]
		Lmean = [Lmean,mean(Lfract)]
	    end
	end
        mean=Lmean(1000)

        mkdir_mult(fullfile('results',['smooth_',smooth1,'_reg_',reg1,'_der_',der1],['smooth_',smooth2,'_reg_',reg2,'_der_',der2]))
        save('-mat7-binary',fullfile('results',['smooth_',smooth1,'_reg_',reg1,'_der_',der1],['smooth_',smooth2,'_reg_',reg2,'_der_',der2],['Lfract_hand_',num2str(size),'_FWE.mat']),'Lfract')
        save('-mat7-binary',fullfile('results',['smooth_',smooth1,'_reg_',reg1,'_der_',der1],['smooth_',smooth2,'_reg_',reg2,'_der_',der2],['Lmean_hand_',num2str(size),'_FWE.mat']),'Lmean')
        save('-mat7-binary',fullfile('results',['smooth_',smooth1,'_reg_',reg1,'_der_',der1],['smooth_',smooth2,'_reg_',reg2,'_der_',der2],['mean_hand_',num2str(size),'_FWE.mat']),'mean')
    end
end
