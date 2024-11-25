function [outputMusic] = applyTransformMax(inputMusic,inputMap)
% this can be simply divided into 4 steps
% 1. split the channels
[~, numChannels] = size(inputMusic);

% initialize output
outputMusic = zeros(size(inputMusic));

% pre-calculate the multiplier
inputMapMultiplier = 10.^(inputMap/20);

% Apply the transformation for each channel
for i = 1:numChannels
    channel = inputMusic(:, i);
    fftMusic = fft(channel);
    fftFiltered = fftMusic .* inputMapMultiplier(:);
    transformedChannel = ifft(fftFiltered,"symmetric");

    % map max value to 1
    transformedChannel(transformedChannel > 1) = 1;
    transformedChannel(transformedChannel < -1) = -1;
    outputMusic(:, i) = transformedChannel;
end
end

