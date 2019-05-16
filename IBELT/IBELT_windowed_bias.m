function [] = IBELT_windowed_bias(fname_mat)
%% -------- DESCRIPTION --------
% Function takes outputs from the Face-Names tasks and plots them for further interpretation.

%% -------- INPUTS --------
% fname_mat = the file containing the results from the experiment [string, full path]

%% -------- OUTPUTS --------
% Average Windowed Bias vs. Time (line graph)
% Average Quatered Bias vs. Time (line graph)
% Response Time vs. Time (line graph)
% Images Shown vs. Sex (bar graph)
% Average Windowed Bias vs. Sex (bar graph)
% Average Windowed Bias vs. Valence (bar graph)
% Response Time vs. Sex (bar graph)
% Response Time vs. Valence (bar graph)
% bias_ matrix = verifies that the sex displayed was equal
% sex_check = average of the sexes shown
% sex_std = standard deviation of the sexes shown
% valence_average = average of the valences shown
% valence_std = standard deviation of the valences shown

%% -------- EXAMPLE --------
% fname_mat = '/Volumes/gizmo/Workspace/Matt_R/GitRepo/Task1/data/subject0004_2018_07_18/subject_0004_18-Jul-2018.mat';
% windowed_bias(fname_mat);

%% -------- FUNCTION --------
load(fname_mat);
[fdir,fname] = fileparts(fname_mat);
savename = [fdir '/' fname '_windowedbias.mat'];

% The average windowed bias over the span of 5 response values
avg_windowed5_bias = movmean(strcmp(response,bias),5,'Endpoints','shrink');
std_windowed5_bias = movstd(strcmp(response,bias),5,'Endpoints','shrink');

% Creating, scaling, and editing the plot
% Holding a plot with error on it
h = figure;
h.Color = 'w';
subplot(3,3,1);
errorbar(avg_windowed5_bias,std_windowed5_bias,'.-r');
hold all;
h = gca;
y = h.YLim(1):0.2:h.YLim(2);
plot(round(length(response)/2)*ones(length(y),1),y,'black--');
xlabel('Number of Face Shown');
ylabel('Average Windowed Bias');
title('AW(5)Bias vs. Number of Stimuli');

% The quarterly averages of the responses
quarters = 1:floor(length(response)/4):length(response)+1;
quarters(end) = quarters(end) - 1;
for idx = 1:4
    avg_bias_quarter(idx,:) = nanmean(avg_windowed5_bias(quarters(idx):quarters(idx+1))); %#ok
    std_bias_quarter(idx,:) = nanstd(avg_windowed5_bias(quarters(idx):quarters(idx+1))); %#ok
end

subplot(3,3,2);
errorbar(avg_bias_quarter,std_bias_quarter,'*-r');
xlabel('Quarters');
ylabel('Average Windowed Bias per Quarter');
title('AQB vs. Time');

% Make sure that the probability of bias is functioning properly
% If the probability of bias is 0.90, the other key should have a 0.10 bias
% that the next face is a negative valence

side = unique(cell2mat(response(~cellfun('isempty',response))));
% Eliminates the nonresponses, converts it to an array, and designates the sides

valence_group = unique(cell2mat(valence(~cellfun('isempty',valence))));
% Converst cells to an array and finds valences

count = 2;
for sidx = 1:length(side)
    for vidx = 1:length(valence_group)
        cur_side = side(sidx);
        cur_valence_group = valence_group(vidx);
        idx = find(strcmp(response,cur_side))+1; % Finds which responses are equal to the bias and adds one to see what happened with the valence
        if idx(end) > origRepetitions + flippedRepetitions
            idx(end) = []; % Eliminates the valence after the last response because it does not exist
        end
        idx1 = le(idx,origRepetitions + 1); % Takes all of the responses less than or equal t othe 
        idx1 = idx .* idx1; % Keeps all the numbers less than or equal to the origRepetitions + 1
        idx1(idx1==0) = []; 
        idx2 = gt(idx,origRepetitions + 1); % Keeps all the numbers greater than the origRepetitions + 1
        idx2 = idx .* idx2;
        idx2(idx2==0) = [];
        prob1 = mean(strcmp(valence(idx1),cur_valence_group)); 
        prob2 = mean(strcmp(valence(idx2),cur_valence_group));
        std1 = std(strcmp(valence(idx1),cur_valence_group));
        std2 = std(strcmp(valence(idx2),cur_valence_group));
        if (cur_side ~= bias && cur_valence_group == valence_group(1)) || (cur_side == bias && cur_valence_group == valence_group(2))
            m = prob;  
            n = 1 - prob;
        elseif (cur_side  ~= bias && cur_valence_group == valence_group(2)) || (cur_side == bias && cur_valence_group == valence_group(1))
            m = 1 - prob;
            n = prob;
        end      
        bias_matrix(1,:) = {'Category', 'Side', 'Valence', '% Prevalence', 'Good (0) or Bad (1) (z-test)', 'p-value from z-test'};
        [z,p] = ztest(prob1,m,std1); % z = 1 means there is significat difference, z = 0 means there is not significant difference, p should be greater than 0.05
        bias_matrix(count,:) = {'First Part', cur_side, cur_valence_group, prob1*100, z, p}; %#ok
        count = count + 1;
        [z,p] = ztest(prob2,n,std2);
        bias_matrix(count,:) = {'Second Part', cur_side, cur_valence_group, prob2*100, z, p}; %#ok
        count = count + 1;
    end
end
bias_matrix = sortrows(bias_matrix,1); %#ok


subplot(3,3,3);
plot(responsetime,'*-b');
ylabel('Response Time per Face');
xlabel('Time');
average_responsetime = sum(responsetime)/length(responsetime); %#ok
title('Response Time vs Time');


% Bar Plot of Amount of Images Shown vs. Sex (First part and Second part)
sex_check = [sum(strcmp(sex(1:origRepetitions),'M'))/origRepetitions sum(strcmp(sex(1:origRepetitions),'F'))/origRepetitions; sum(strcmp(sex(origRepetitions+1:end),'M'))/flippedRepetitions sum(strcmp(sex(origRepetitions+1:end),'F'))/flippedRepetitions]; %#ok
subplot(3,3,4);
x = [1.4-0.06 1.4+0.06;2-0.06 2+0.06];
bar(x,sex_check,'BarWidth',4);
set(gca,'xtick',[1.4 2], 'xticklabel',{'M','F'});
xlabel('Sex of the Image');
ylabel('Percentage of Sexes Shown');
text(horzcat(x(1,:),x(2,:)),horzcat(sex_check(1,:),sex_check(2,:)),{round(sex_check(1,1),3) round(sex_check(1,2),3) round(sex_check(2,1),3) round(sex_check(2,2),3)},'HorizontalAlignment','left','VerticalAlignment','cap','Rotation',75);
legend('First Part','Second Part','Location','south');
title('Images Shown vs. Sex');

% Bar plot (avg_windowed5_bias for Sex: M/F), takes the windowed biased
% means of each sex and graphs them
sex_average = [mean(avg_windowed5_bias(strcmp(sex(1:origRepetitions),'M'))) mean(avg_windowed5_bias(strcmp(sex(1:origRepetitions),'F'))); mean(avg_windowed5_bias(strcmp(sex(origRepetitions+1:end),'M'))) mean(avg_windowed5_bias(strcmp(sex(origRepetitions+1:end),'F')))];
sex_std = [std(avg_windowed5_bias(strcmp(sex(1:origRepetitions),'M'))) std(avg_windowed5_bias(strcmp(sex(1:origRepetitions),'F'))); std(avg_windowed5_bias(strcmp(sex(origRepetitions+1:end),'M'))) std(avg_windowed5_bias(strcmp(sex(origRepetitions+1:end),'F')))];
subplot(3,3,6);
hold all
x = [1.4-0.06 1.4+0.06;2-0.06 2+0.06];
bar(x,sex_average,'BarWidth',4)
set(gca,'xtick',[1.4 2],'xticklabel',{'M', 'F'});
errorbar(x,sex_average,sex_std,'.');
legend('First Part','Second Part','Location','south');
xlabel('Sex of the Image');
ylabel('Average Windowed Bias');
text(horzcat(x(1,:),x(2,:)),horzcat(sex_average(1,:),sex_average(2,:)),{round(sex_average(1,1),3) round(sex_average(1,2),3) round(sex_average(2,1),3) round(sex_average(2,2),3)},'HorizontalAlignment','left','VerticalAlignment','cap','Rotation',75);
box off
title('AW(5)Bias vs. Sex');

% Bar plot (avg_windowed5_bias for Valence), takes the windowed biased
% means of each valence and graphs them
if sum(strcmp(valence,'H')) > 0
    positive = 'H';
else
    positive = 'N';
end

if sum(strcmp(valence, 'F')) > 0
    negative = 'F';
else
    negative = 'S';
end

valence_average = [mean(avg_windowed5_bias(strcmp(valence(1:end/2),positive))) mean(avg_windowed5_bias(strcmp(valence(1:end/2),negative))); mean(avg_windowed5_bias(strcmp(valence(end/2+1:end),positive))) mean(avg_windowed5_bias(strcmp(valence(end/2+1:end),negative)))];
valence_std = [std(avg_windowed5_bias(strcmp(valence(1:end/2),positive))) std(avg_windowed5_bias(strcmp(valence(1:end/2),negative))); std(avg_windowed5_bias(strcmp(valence(end/2+1:end),positive))) std(avg_windowed5_bias(strcmp(valence(end/2+1:end),negative)))];
subplot(3,3,7);
hold all
x = [1.4-0.05 1.4+0.05;2-0.05 2+0.05];
bar(x,valence_average,'BarWidth',4);
set(gca,'xtick',[1.4 2],'xticklabel', {positive, negative});
errorbar(x,valence_average,valence_std,'.');
legend('First Part','Second Part','Location','south');
ylabel('Average Windowed Bias');
xlabel('Valence of the Image');
text(horzcat(x(1,:),x(2,:)),horzcat(valence_average(1,:),valence_average(2,:)),{round(valence_average(1,1),3) round(valence_average(1,2),3) round(valence_average(2,1),3) round(valence_average(2,2),3)},'HorizontalAlignment','left','VerticalAlignment','cap','Rotation',75);
box off
title('AW(5)Bias vs. Valence');

% Bar plot (responsetime for Sex: M/F - split by first and Second Part)
subplot(3,3,8);
hold all
x = [1.4-0.05 1.4+0.05;2-0.05 2+0.05];
bar(x,sex_average,'BarWidth',4);
set(gca,'xtick',[1.4 2],'xticklabel', {'M', 'F'});
errorbar(x,sex_average,sex_std,'.');
legend('First Part','Second Part','Location','south');
ylabel('Average Response Time');
xlabel('Sex of the Image');
text(horzcat(x(1,:),x(2,:)),horzcat(sex_average(1,:),sex_average(2,:)),{round(sex_average(1,1),4) round(sex_average(1,2),4) round(sex_average(2,1),4) round(sex_average(2,2),4)},'HorizontalAlignment','left','VerticalAlignment','cap','Rotation',75);
box off
title('Average Response Time vs. Sex');

% Bar plot (responsetime for Valence - split by first and Second Part)
subplot(3,3,9);
hold all
x = [1.4-0.05 1.4+0.05;2-0.05 2+0.05];
bar(x,valence_average,'BarWidth',4);
set(gca, 'xtick',[1.4 2],'xticklabel', {positive, negative});
errorbar(x,valence_average,valence_std,'.');
legend('First Part','Second Part','Location','south');
ylabel('Average Response Time');
xlabel('Valence of the Image');
text(horzcat(x(1,:),x(2,:)),horzcat(valence_average(1,:),valence_average(2,:)),{round(valence_average(1,1),4) round(valence_average(1,2),4) round(valence_average(2,1),4) round(valence_average(2,2),4)},'HorizontalAlignment','left','VerticalAlignment','cap','Rotation',75);
box off
title('Average Response Time vs. Valence');

% set(subplot(3,3,5),'Color','w');
% image(imread('/Volumes/gizmo/Workspace/Matt_R/GitRepo/Task1/data/subject0004_2018_07_18/index.png'))
% axis off;

save(savename,'sex_average','sex_std','valence_average','valence_std', 'bias_matrix');
saveas(h,'IBELT_Analysis_.png');
