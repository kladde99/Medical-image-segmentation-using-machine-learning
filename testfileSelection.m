function [b_test b_training]=testfileSelection(lengthOfFrame,b,NrOfFile)
% implements to get test file frames and training file frames 
% to be prepared for cross validation.
%% Author info
% Wangbo Zheng and Hao Wang
% University of Stuttgart

%%
% first audio file as test file
if NrOfFile==1
    positionofstart=1
else
    positionofstart=sum(lengthOfFrame(1:NrOfFile-1))+1
end
b_test=b(positionofstart:positionofstart+lengthOfFrame(NrOfFile)-1,:)
if NrOfFile==1
    b_training=b(positionofstart+lengthOfFrame(NrOfFile):end,:)
elseif NrOfFile==10
        b_training=b(1:positionofstart-1,:)
else
     b_training=[b(1:positionofstart-1,:); b(positionofstart+lengthOfFrame(NrOfFile):end,:)]
end;
   