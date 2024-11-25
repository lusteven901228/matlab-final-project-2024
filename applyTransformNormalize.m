function [outputMusic] = applyTransformNormalize(inputMusic,inputMap)
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

    % Normalize the transformed signal to prevent clipping
    maxVal = max(abs(transformedChannel));
    if maxVal > 0
        transformedChannel = transformedChannel / maxVal; % Scale so that max value is 1
    end
    outputMusic(:, i) = transformedChannel;
end
end

