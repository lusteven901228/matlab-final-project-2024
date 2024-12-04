function [outputMusic] = applyTransformNormalize(inputMusic,inputMap)
% this can be simply divided into 4 steps
% 1. split the channels
[~, numChannels] = size(inputMusic);

% initialize output
outputMusic = zeros(size(inputMusic));

% pre-calculate the multiplier
inputMapMultiplier = 10.^(inputMap/20);

assert(length(inputMapMultiplier) == L/2 , "inputMap must be half the length of the input music");


% Apply the transformation for each channel
for i = 1:numChannels
    channel = inputMusic(:, i);
    fftMusic = fft(channel);
    fftFiltered = zeros(size(fftMusic));
    fftFiltered(1:L/2) = fftMusic(1:L/2) .* inputMapMultiplier(:);
    fftFiltered(L:-1:L/2+1) = fftMusic(L:-1:L/2+1) .* inputMapMultiplier(:);
    transformedChannel = ifft(fftFiltered,"symmetric");

    % Normalize the transformed signal to prevent clipping
    maxVal = max(abs(transformedChannel));
    if maxVal > 0
        transformedChannel = transformedChannel / maxVal; % Scale so that max value is 1
    end
    outputMusic(:, i) = transformedChannel;
end
end

