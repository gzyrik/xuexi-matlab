function [Estimator, binary_far_spectrum] = BinarySpectrumFloat(far_spectrum, Estimator)

% Only bit |kBandFirst| through bit |kBandLast| are processed and
% |kBandFirst| - |kBandLast| must be < 32
kBandFirst = 12;
kBandLast = 43;

end
