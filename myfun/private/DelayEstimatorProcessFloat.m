function [Estimator, delay_estimate] = DelayEstimatorProcessFloat(Estimator, far_spectrum, near_spectrum)
% 估计远端信号与近端的时延
%   Estimator 估计器
%   far_spectrum 对端参考振幅谱
%   near_spectrum 近端振幅谱
% 返回
%   Estimator 更新后的估计器
%   delay_estimate  估计的时延

%Get binary spectra.
[Estimator, binary_far_spectrum] = BinarySpectrumFloat(far_spectrum, Estimator);
[Estimator, binary_near_spectrum] = BinarySpectrumFloat(near_spectrum, Estimator);
[Estimator, delay_estimate] = ProcessBinarySpectrum(Estimator.binary_handle,
                                binary_far_spectrum, binary_near_spectrum);
